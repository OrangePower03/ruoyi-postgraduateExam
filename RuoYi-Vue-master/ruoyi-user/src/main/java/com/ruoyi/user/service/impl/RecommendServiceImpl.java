package com.ruoyi.user.service.impl;

import com.ruoyi.common.constant.CacheConstants;
import com.ruoyi.common.constant.HttpStatus;
import com.ruoyi.common.constant.SystemConstants;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.bean.BeanUtils;
import com.ruoyi.user.domain.DScore;
import com.ruoyi.user.domain.Score;
import com.ruoyi.user.domain.UserScoreInfo;
import com.ruoyi.user.domain.common.QwenAnalysisThread;
import com.ruoyi.user.domain.common.ScoreCommon;
import com.ruoyi.user.domain.dto.RecommendDto;
import com.ruoyi.user.domain.vo.RecommendVo;
import com.ruoyi.user.domain.vo.SchoolWithScoreVo;
import com.ruoyi.user.mapper.*;
import com.ruoyi.user.service.RecommendService;
import com.ruoyi.user.utils.QwenPlusUtils;
import lombok.RequiredArgsConstructor;
import org.jetbrains.annotations.NotNull;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class RecommendServiceImpl implements RecommendService {
    private final DScoreMapper wxDScoreMapper;
    private final UserScoreInfoMapper userMapper;
    private final ScoreMapper scoreMapper;
    private final SchoolMapper schoolMapper;
    private final AreaMapper areaMapper;
    private final RedisCache redisCache;

    private static final int TOP_NUMBER=9;
    private static final int FLUCTUATE=10; // 分数浮动大小
    private static final int NEAR_YEAR=3;  // 近三年的分数，以后改这就行了
    public static final int NOW_YEAR=2023; // 从2023年开始算分，一直往前算三年
    public static final float QS_WEIGHT=0.5f; // QS排名的权重
    public static final float RK_WEIGHT=0.4f; // 软科的权重
    public static final float AREA_WEIGHT=0.1f; // 地区的权重
    public static final float DAWV_WEIGHT=0.4f; // 地区的权重
    public static final float BWV_WEIGHT=0.6f; // 地区的权重
    private static final Map<Long, String> connectIdToSchoolName=new HashMap<>();
    private static final Map<Long, Long> connectIdToSchoolId=new HashMap<>();

    @Autowired
    private ThreadPoolTaskExecutor taskExecutor;


    /**
     * 推荐算法主体
     * 首先对发来的数据进行校验，校验数据的完整性和正确性
     * 接着会先对用户的分数进行国家线的过线评估
     * 接着设定浮动分数来将临近的学校和三年分数拉出来
     * 接着执行算法
     * 每一个学校都拥有QS国内排名和RK软科排名，并且根据学校的地理位置得到BWV权重
     * 然后根据用户分数和学校三年的平均分做比较得到DAWV
     * 最后将这两个权重集成在一起得到FWV，排序返回
     */
    @NotNull
    @Override
    public List<RecommendVo> recommend(RecommendDto recommendDto) {
        Long userId = verify(recommendDto);

        // 是否过了A区线
        boolean isOverA=true;

        // 过了A区线，没有任何阻拦
        String compareResult = compareCountryScore(recommendDto);
        if("B".equals(compareResult)) {
            isOverA=false;
        }
        // 未过线，二战吧
        else if("C".equals(compareResult)){
            return new ArrayList<>();
        }

        List<SchoolWithScoreVo> schools= getAllFloatSchool(recommendDto, isOverA);
        if(StringUtils.isEmpty(schools)) {
            return new ArrayList<>();
        }

        // 此时的schools是具有往年复试线的平均分和学校名
        BWV(recommendDto, schools);
        DAWV(recommendDto, schools);
        FWV(schools);
        schools = schools.stream()
                .sorted()  // 注意要从大到小的取最大的九个数据
                .limit(TOP_NUMBER)
                .collect(Collectors.toList());

        normalizeAlgorithm(schools);
        List<RecommendVo> result = packaging(schools);

        if(!redisCache.hasKey(CacheConstants.QWEN_PLUS_USER_KEY + userId)) {
            List<String> schoolNames = result.stream().map(RecommendVo::getSchoolName).collect(Collectors.toList());
            List<String> questions = createQuestions(recommendDto.getMajorName(), schoolNames);
            analyseFromAI(questions, userId, schoolNames);
        }

        return result;
    }

    private void FWV(List<SchoolWithScoreVo> schools) {
        schools.forEach(school-> school.setUnhandledPower((DAWV_WEIGHT * school.getDv() + BWV_WEIGHT * school.getFwv())));
    }

    /**
     * 校验数据完整性，避免分数输入的不全，现暂无智能推测分数算法
     * 因为用户本身是带有分数的，所以如果不输入分数就会默认使用用户本身的分数
     */
    private Long verify(RecommendDto recommendDto) {
        Long userId = SecurityUtils.getLoginUser().getUser().getUserId();
        UserScoreInfo userScoreInfo = userMapper.selectWxUserScoreInfoByUserId(userId);
        if(userScoreInfo == null) {
            userScoreInfo = userMapper.selectWxUserScoreInfoByUserId(1L);
        }

        if(StringUtils.isEmpty(recommendDto.getMajorName())) {
            if(Objects.isNull(userScoreInfo.getMajorName())){
                throw new ServiceException("专业不能为空", HttpStatus.BAD_REQUEST);
            }
            recommendDto.setMajorName(userScoreInfo.getMajorName());
        }
        if(StringUtils.isEmpty(recommendDto.getScoreAll())) {
            if(Objects.isNull(userScoreInfo.getScoreAll())) {
                throw new ServiceException("请输入您的成绩",HttpStatus.BAD_REQUEST);
            }
            recommendDto.setScoreAll(userScoreInfo.getScoreAll());
        }
        if(StringUtils.isEmpty(recommendDto.getScoreMath())) {
            if(Objects.isNull(userScoreInfo.getScoreMath())) {
                throw new ServiceException("请输入您的数学成绩",HttpStatus.BAD_REQUEST);
            }
            recommendDto.setScoreMath(userScoreInfo.getScoreMath());
        }
        if(StringUtils.isEmpty(recommendDto.getScoreEnglish())) {
            if(Objects.isNull(userScoreInfo.getScoreEnglish())) {
                throw new ServiceException("请输入您的英语成绩",HttpStatus.BAD_REQUEST);
            }
            recommendDto.setScoreEnglish(userScoreInfo.getScoreEnglish());
        }
        if(StringUtils.isEmpty(recommendDto.getScorePolitics())) {
            if(Objects.isNull(userScoreInfo.getScorePolitics())) {
                throw new ServiceException("请输入您的政治成绩",HttpStatus.BAD_REQUEST);
            }
            recommendDto.setScorePolitics(userScoreInfo.getScorePolitics());
        }
        if(StringUtils.isEmpty(recommendDto.getScoreMajor())) {
            if(Objects.isNull(userScoreInfo.getScoreMajor())) {
                throw new ServiceException("请输入您的专业成绩",HttpStatus.BAD_REQUEST);
            }
            recommendDto.setScoreMajor(userScoreInfo.getScoreMajor());
        }

        if(!verifyScore(recommendDto)) {
            throw new ServiceException("分数不符合考研机制，请重新输入", HttpStatus.BAD_REQUEST);
        }
        recommendDto.setScoreAll(recommendDto.getScoreEnglish() + recommendDto.getScoreMajor() +
                                 recommendDto.getScorePolitics() + recommendDto.getScoreMath());
        return userId;
    }

    private boolean verifyScore(RecommendDto recommendDto) {
        return !(recommendDto.getScoreMath() > 150 ||
                recommendDto.getScoreEnglish() > 100 ||
                recommendDto.getScoreMath() > 150 ||
                recommendDto.getScorePolitics() > 100 );
    }

    /**
     * 归一化后的学校
     */
    private void normalizeAlgorithm(List<SchoolWithScoreVo> schools) {
        float min=101f;
        float max=0f;
        for(SchoolWithScoreVo school : schools) {
            float cur = school.getUnhandledPower();

            if(cur > max) {
                max = cur;
            }
            if(cur < min) {
                min = cur;
            }
        }
        float range = max - min;
        for(SchoolWithScoreVo school : schools) {
            school.setHandledPower((school.getUnhandledPower() - min) /range);
        }
    }

    private void DAWV(RecommendDto recommendDto, List<SchoolWithScoreVo> schools) {
        schools.forEach(school ->
                school.setDv((float) (recommendDto.scoreAll-school.scoreAll))
        );
    }

    private void BWV(RecommendDto recommendDto, List<SchoolWithScoreVo> schools) {
        String area = recommendDto.getArea();

        int areaId = StringUtils.isEmpty(area) ? -1 : areaMapper.selectAreaIdByAreaName(area);
        for (SchoolWithScoreVo school : schools) {
            String schoolName = school.getSchool().getSchoolName();
            school.setQS(schoolMapper.selectQSBySchoolName(schoolName));
            school.setRK(schoolMapper.selectRKBySchoolName(schoolName));
            if(areaId == -1) {
                school.setArea(100f);
            }
            else {
                double distance = redisCache.distance(SystemConstants.REDIS_AREA_KEY,
                        String.valueOf(areaId),
                        String.valueOf(schoolMapper.selectAreaIdBySchoolName(schoolName)));
                school.setArea((float) distance);
            }
        }
        compressAlgorithm(schools, StringUtils.isEmpty(area));
        schools.forEach(school -> school.setFwv(QS_WEIGHT*school.getQS() + RK_WEIGHT*school.getRK() + AREA_WEIGHT*school.getArea()));
    }


    /**
     * 根据分数和专业初始化所有大学，注意要判断是否过了A线，没过只能选B区的学校
     * 取这个专业下的学校近几年下的复试线平均分在浮动范围内的
     * @return 在浮动范围内的所有学校
     */
    private List<SchoolWithScoreVo> getAllFloatSchool(RecommendDto recommendDto, boolean isOverA) {
        Long scoreAll = recommendDto.getScoreAll();
        String majorName = recommendDto.getMajorName();
        int first_year=NOW_YEAR-NEAR_YEAR+1;
        // 先把这个专业的connectId拉出来
        List<Long> connectIds = scoreMapper.getConnectIdByMajorName(majorName, scoreAll, FLUCTUATE, first_year);
        if(StringUtils.isNull(connectIds)) {
            return new ArrayList<>();
        }
        // 排序，否则学校和connectId对不上的
        Collections.sort(connectIds);
        // 获取到所有的学校id
        List<Long> schoolIds = scoreMapper.getSchoolIdByScoreConnectId(connectIds);

//        for(int i=0;i<connectIds.size();i++) {
//            if (!scoreMapper.getSchoolIdByConnectId(connectIds.get(i)).equals(schoolIds.get(i))) {
//                throw new RuntimeException("学校未对上，系统错误，仅供测试使用，上线请删除");
//            }
//        }
//        connectIds.forEach(connectId -> System.out.print(connectId + ","));

        // 根据connectId映射到学校名字，还是要遍历所有的数据，无法，但按照学校id获取学校名有索引，性能趋近于O(1)
        for(int i=0;i<connectIds.size();i++) {
            connectIdToSchoolId.put(connectIds.get(i), schoolIds.get(i));
            if(!connectIdToSchoolName.containsKey(connectIds.get(i)))
                connectIdToSchoolName.put(connectIds.get(i), schoolMapper.getSchoolNameById(schoolIds.get(i)));
        }

        // 通过学校id获取到分数们，此时没办法直接获取到学校
        List<Score> scoreList = scoreMapper.selectByMajorAndSchoolId(majorName, schoolIds, first_year);

        // 这一步最慢，有待优化
//        scoreList.forEach(score -> score.setSchoolName(scoreMapper.getSchoolNameByScoreConnectId(score.getConnectId())));
        // 使用map映射优化

        for (int i = 0; i < scoreList.size(); i++) {
            Score score = scoreList.get(i);
            score.setSchoolName(connectIdToSchoolName.get(score.getConnectId()));
            score.setSchoolId(connectIdToSchoolId.get(score.getConnectId()));
        }

        if(!isOverA) {
            // 没过A线但过了B的，得把A区学校割去
            scoreList.removeIf(score ->
                    schoolMapper.findAreaTypeBySchoolName(score.getSchoolName()) == SystemConstants.AREA_TYPE_A
            );
        }

        if(scoreList.isEmpty()) {
            return Collections.emptyList();
        }

        // 将相同学校计算平均分，先排序再计算
        Collections.sort(scoreList);

        String schoolName = scoreList.get(0).getSchoolName();
        List<SchoolWithScoreVo> result=new ArrayList<>();
        SchoolWithScoreVo school=new SchoolWithScoreVo();
        school.getSchool().setSchoolName(schoolName);

        int count=0;
        for (Score nowSchool : scoreList) {
            String nowSchoolName = nowSchool.getSchoolName();
            // 一个一个学校比对，如果学校名相同，就把分数加上去
            if (!schoolName.equals(nowSchoolName)) {
                // 不同学校了，把之前这个学校分数除以累加次数，得到平均分，然后添加进集合中
                school.average(count);
                result.add(school);
                count = 0;
                school = new SchoolWithScoreVo();
                schoolName = nowSchoolName;
                school.getSchool().setSchoolId(nowSchool.getSchoolId());
                school.getSchool().setSchoolName(schoolName);
            }
            school.scoreAll += nowSchool.getScoreAll();
            school.scorePolitics += nowSchool.getScorePolitics();
            school.scoreEnglish += nowSchool.getScoreEnglish();
            school.scoreMath += nowSchool.getScoreMath();
            school.scoreMajor += nowSchool.getScoreMajor();
            count++;
        }
        // 最后的记得要加进去，要不然少一个学校，白忙活了
        school.average(count);
        result.add(school);

        return result;
    }

    /**
     * 拿用户的分数判断是否过了国家线
     * @return A: 过A线，B: 过B但未过A，C: 未过线
     */
    private String compareCountryScore(RecommendDto recommendDto) {
        List<DScore> dScores = wxDScoreMapper.selectByMajorName(recommendDto.getMajorName());
        if(dScores.size() == 0) {
            //cqtodo 如果这个专业的国家线并没有加入数据库怎么办
            return "A";
        }

        ScoreCommon area_A_AverageScore=getAreaTypeAverageScore(dScores, SystemConstants.AREA_TYPE_A);
        if (doCompareCountryScore(recommendDto,area_A_AverageScore)) {
            return "A";
        }
        else {
            ScoreCommon area_B_AverageScore=getAreaTypeAverageScore(dScores, SystemConstants.AREA_TYPE_B);
            if(doCompareCountryScore(recommendDto,area_B_AverageScore)) {
                return "B";
            }
            else {
                return "C";
            }
        }
    }

    /**
     * 用来单独获取A、B区的平均分
     * @param dScores 可以是包含有A、B区的国家线分数集合
     * @param areaType 地区的类型，A是1、B是2
     * @return 返回算好的平均分
     */
    private ScoreCommon getAreaTypeAverageScore(List<DScore> dScores, Long areaType) {
        ScoreCommon averageScore=new ScoreCommon();
        List<DScore> areaScore = dScores.stream()
                .filter(dScore -> areaType.equals(dScore.getAreaType()))
                .collect(Collectors.toList());
        for(DScore dScore : areaScore) {
            averageScore.scoreAll += dScore.getScoreAll();
            averageScore.scorePolitics += dScore.getScorePolitics();
            averageScore.scoreEnglish += dScore.getScoreEnglish();
            averageScore.scoreMath += dScore.getScoreMath();
            averageScore.scoreMajor += dScore.getScoreMajor();
        }
        averageScore.average(areaScore.size());
        return averageScore;
    }

    private boolean doCompareCountryScore(RecommendDto recommendDto, ScoreCommon areaAAverageScore) {
        return recommendDto.getScoreAll() >= areaAAverageScore.scoreAll &&
               recommendDto.getScorePolitics() >= areaAAverageScore.scorePolitics &&
               recommendDto.getScoreEnglish() >= areaAAverageScore.scoreEnglish &&
               recommendDto.getScoreMath() >= areaAAverageScore.scoreMath &&
               recommendDto.getScoreMajor() >= areaAAverageScore.scoreMajor;
    }

    /**
     * 封装vo发送前端咯
     */
    public List<RecommendVo> packaging(List<SchoolWithScoreVo> schools) {
        return schools.stream()
                .map(school -> {
                    RecommendVo result = new RecommendVo();
                    result.setSchoolId(school.getSchool().getSchoolId());
                    result.setSchoolName(school.getSchool().getSchoolName());
                    result.setHandledPower(school.getHandledPower());
                    ScoreCommon score = new ScoreCommon();
                    BeanUtils.copyBeanProp(score,school);
                    result.setAverageScore(score);
                    return result;
                })
                .collect(Collectors.toList());
    }

    /**
     * 压缩数据的算法
     */
    public void compressAlgorithm(List<SchoolWithScoreVo> schools, boolean areaIsSame) {
        int size = schools.size();
        // 降序排列QS
        schools.sort((school1, school2) -> (int) (school2.getQS() - school1.getQS()));
        for(int i=0;i < size;i++) {
            schools.get(i).setQS((float) (100-i));
        }
        // 降序排列RK
        schools.sort((school1, school2) -> (int) (school2.getRK() - school1.getRK()));
        for(int i=0;i < size;i++) {
            schools.get(i).setRK((float) (100-i));
        }
        if(!areaIsSame) {
            schools.sort((school1, school2) -> (int) (school1.getArea() - school2.getArea()));
            for(int i=0;i < size;i++) {
                schools.get(i).setArea((float) (100-i));
            }
        }
    }

    @Override
    public void analyseFromAI(List<String> questions, Long userId, List<String> schoolNames) {
        redisCache.setCacheObject(CacheConstants.QWEN_PLUS_USER_KEY + userId, 0, CacheConstants.QWEN_PLUS_USER_KEY_EXPIRE_TIME, TimeUnit.SECONDS);
        for(int i=0;i<questions.size();i++) {
            taskExecutor.execute(
                new QwenAnalysisThread(
                    questions.get(i),
                    userId,
                    schoolNames.get(i)
                )
            );
        }
    }
}
