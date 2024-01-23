package com.ruoyi.user.service.impl;

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
import com.ruoyi.user.domain.common.ScoreCommon;
import com.ruoyi.user.domain.common.ScoreWithSchoolName;
import com.ruoyi.user.domain.dto.RecommendDto;
import com.ruoyi.user.domain.vo.RecommendVo;
import com.ruoyi.user.domain.vo.SchoolWithScoreVo;
import com.ruoyi.user.mapper.*;
import com.ruoyi.user.service.RecommendService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.*;
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

    private static final int FLUCTUATE=10; // 分数浮动大小
    private static final int NEAR_YEAR=3;  // 近三年的分数，以后改这就行了
    public static final int NOW_YEAR=2023; // 从2023年开始算分，一直往前算三年
    public static final float QS_WEIGHT=0.5f; // QS排名的权重
    public static final float RK_WEIGHT=0.4f; // 软科的权重
    public static final float AREA_WEIGHT=0.1f; // 地区的权重

    /**
     * 推荐算法主体
     */
    @Override
    public List<RecommendVo> recommend(RecommendDto recommendDto) {
        if(StringUtils.isEmpty(recommendDto.getMajorName())) {
            throw new ServiceException("专业不能为空", HttpStatus.BAD_REQUEST);
        }

        verify(recommendDto);

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
        if(StringUtils.isNotEmpty(schools)) {
            //cqtodo 得到一个空的学校怎么办（
        }

        // 此时的schools是具有往年复试线的平均分和学校名
        FWV(recommendDto, schools);
        DV(recommendDto, schools);
        WV(schools);
        schools = schools.stream()
                         .sorted()  // 注意要从大到小的取最大的九个数据
                         .limit(9)
                         .collect(Collectors.toList());

        normalizeAlgorithm(schools);

        return packaging(schools);
    }

    @Override
    public void WV(List<SchoolWithScoreVo> schools) {
        schools.forEach(school-> school.setUnhandledPower((float) (0.4 * school.getDv() + 0.6 * school.getFwv())));
    }

    /**
     * 校验数据完整性，避免分数输入的不全，现暂无智能推测分数算法
     * 因为用户本身是带有分数的，所以如果不输入分数就会默认使用用户本身的分数
     */
    @Override
    public void verify(RecommendDto recommendDto) {
        Long userId = SecurityUtils.getLoginUser().getUser().getUserId();
        UserScoreInfo userScoreInfo = userMapper.selectWxUserScoreInfoByUserId(userId);
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
    }

    /**
     * 归一化后的学校
     */
    @Override
    public void normalizeAlgorithm(List<SchoolWithScoreVo> schools) {
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

    @Override
    public void DV(RecommendDto recommendDto, List<SchoolWithScoreVo> schools) {
        schools.forEach(school ->
            school.setDv((float) (recommendDto.scoreAll-school.scoreAll))
        );
    }

    @Override
    public void FWV(RecommendDto recommendDto, List<SchoolWithScoreVo> schools) {
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
    @Override
    public List<SchoolWithScoreVo> getAllFloatSchool(RecommendDto recommendDto, boolean isOverA) {
        Long scoreAll = recommendDto.getScoreAll();
        String majorName = recommendDto.getMajorName();
        int first_year=NOW_YEAR-NEAR_YEAR+1;
        // 先把所有的分数拉出来，放入封装了Score的类中
        List<Score> scoreList = scoreMapper.selectByMajorAndScoreAll(majorName, scoreAll, FLUCTUATE, first_year);
        if(StringUtils.isNull(scoreList)) {
            //cqtodo 这玩意是个空的玩意，没有学校符合？
        }

        // 此时要将所有的学校根据学校名字来独立拉出来
        for(Score score : scoreList) {
            score.setSchoolName(scoreMapper.getSchoolNameByScoreConnectId(score.getConnectId()));
        }
        // 将相同学校计算平均分，先排序再计算
        Collections.sort(scoreList);
        if(!isOverA) {
            // 每过A线但过了B的，得把A区学校割去
            scoreList.removeIf(score ->
                schoolMapper.findAreaTypeBySchoolName(score.getSchoolName()) == SystemConstants.AREA_TYPE_A
            );
        }
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
    @Override
    public String compareCountryScore(RecommendDto recommendDto) {
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
    @Override
    public ScoreCommon getAreaTypeAverageScore(List<DScore> dScores, Long areaType) {
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

    @Override
    public boolean doCompareCountryScore(RecommendDto recommendDto, ScoreCommon areaAAverageScore) {
        if(recommendDto.getScoreAll() >= areaAAverageScore.scoreAll           &&
           recommendDto.getScorePolitics() >= areaAAverageScore.scorePolitics &&
           recommendDto.getScoreEnglish() >= areaAAverageScore.scoreEnglish   &&
           recommendDto.getScoreMath() >= areaAAverageScore.scoreMath         &&
           recommendDto.getScoreMajor() >= areaAAverageScore.scoreMajor)      {
            return true;
        }
        return false;
    }

    /**
     * 封装vo发送前端咯
     */
    @Override
    public List<RecommendVo> packaging(List<SchoolWithScoreVo> schools) {
        return schools.stream()
                .map(school -> {
                    RecommendVo result = new RecommendVo();
                    result.setSchoolName(school.getSchool().getSchoolName());
                    result.setHandledPower(school.getHandledPower());
                    ScoreCommon score = new ScoreCommon();
                    BeanUtils.copyBeanProp(score,school);
                    result.setAverageScore(score);
                    return result;
                })
                .collect(Collectors.toList());
    }

    @Override
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
}
