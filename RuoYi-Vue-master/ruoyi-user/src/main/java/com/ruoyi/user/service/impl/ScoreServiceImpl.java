package com.ruoyi.user.service.impl;

import java.util.List;

import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.user.domain.AllInfo;
import com.ruoyi.user.domain.UserScoreInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.user.mapper.ScoreMapper;
import com.ruoyi.user.domain.Score;
import com.ruoyi.user.service.IScoreService;

/**
 * 【请填写功能名称】Service业务层处理
 *
 * @date 2023-04-02
 */
@Service
public class ScoreServiceImpl implements IScoreService
{
    @Autowired
    private ScoreMapper wxScoreMapper;

    /**
     * 查询【请填写功能名称】
     *
     * @param scoreId 【请填写功能名称】主键
     * @return 【请填写功能名称】
     */
    @Override
    public Score selectWxScoreByScoreId(Long scoreId)
    {
        return wxScoreMapper.selectWxScoreByScoreId(scoreId);
    }

    /**
     * 查询【请填写功能名称】列表
     *
     * @param wxScore 【请填写功能名称】
     * @return 【请填写功能名称】
     */
    @Override
    public List<Score> selectWxScoreList(Score wxScore)
    {
        return wxScoreMapper.selectWxScoreList(wxScore);
    }

    @Override
    public List<Score> selectThreeRetestLine(Score score) {
        return wxScoreMapper.selectThreeRetestLine(score);
    }

    @Override
    public Score scoreJudge(Score score) {
        return wxScoreMapper.scoreJudge(score);
    }

    /**
     * 新增【请填写功能名称】
     *
     * @param wxScore 【请填写功能名称】
     * @return 结果
     */
    @Override
    public int insertWxScore(Score wxScore)
    {
        return wxScoreMapper.insertWxScore(wxScore);
    }

    /**
     * 修改【请填写功能名称】
     *
     * @param wxScore 【请填写功能名称】
     * @return 结果
     */
    @Override
    public int updateWxScore(Score wxScore)
    {
        return wxScoreMapper.updateWxScore(wxScore);
    }

    /**
     * 批量删除【请填写功能名称】
     *
     * @param scoreIds 需要删除的【请填写功能名称】主键
     * @return 结果
     */
    @Override
    public int deleteWxScoreByScoreIds(Long[] scoreIds)
    {
        return wxScoreMapper.deleteWxScoreByScoreIds(scoreIds);
    }

    /**
     * 删除【请填写功能名称】信息
     *
     * @param scoreId 【请填写功能名称】主键
     * @return 结果
     */
    @Override
    public int deleteWxScoreByScoreId(Long scoreId)
    {
        return wxScoreMapper.deleteWxScoreByScoreId(scoreId);
    }

    @Override
    public List<AllInfo> selectAllInfoList(AllInfo allInfo) {
        return wxScoreMapper.selectAllInfoList(allInfo);
    }

    public String importData(List<Score> scoreList){
        int i=1;
        int j=1;
        StringBuilder successMsg = new StringBuilder();
        StringBuilder failureMsg = new StringBuilder();
        StringBuilder failureMsg2 = new StringBuilder();
        failureMsg.append("表中第");
        for(Score score : scoreList){
//            System.out.println(score);
            if(score.getScoreYear()==null||score.getMajorCode()==null||score.getMajorName()==null||score.getSchoolName()==null||score.getDepartmentName()==null||score.getScoreAll()==null||score.getScoreMath()==null||score.getScoreEnglish()==null||score.getScorePolitics()==null||score.getScoreMajor()==null){
                if(i==1){
                    failureMsg.append(j);
                }
                else {
                    failureMsg.append(',');
                    failureMsg.append(j);
                }
                i++;
            }
            j++;
        }
        if(i>1){
            failureMsg.append("行数据填写有误");
            return failureMsg.toString();
        }
        failureMsg2.append("表中第");
        i=1;
        for (j = 0;j < scoreList.size(); j++) {
            Score score = scoreList.get(j);
            Score score1 = this.scoreJudge(score);
            if (score1 == null) {
                if (i == 1) {
                    failureMsg2.append(j+1);
                } else {
                    failureMsg2.append(',');
                    failureMsg2.append(j+1);
                }
                i++;
            } else {
                score.setScoreMajorId(score1.getScoreMajorId());
            }
        }
        if(i>1){
            failureMsg2.append("行学校或学院填写有误");
            return failureMsg2.toString();
        }
        i=0;
        for(Score score : scoreList){
            this.insertWxScore(score);
            i++;
        }
        successMsg.append("共");
        successMsg.append(i);
        successMsg.append("数据,全部插入成功");
        return successMsg.toString();
    }

    @Override
    public UserScoreInfo getScore() {
        UserScoreInfo userScore = wxScoreMapper.getUserScore(SecurityUtils.getUserId());
        return userScore == null ?  wxScoreMapper.getUserScore(1L) : userScore;
    }
}
