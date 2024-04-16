package com.ruoyi.user.service;

import java.util.List;

import com.ruoyi.user.domain.AllInfo;
import com.ruoyi.user.domain.Score;
import com.ruoyi.user.domain.UserScoreInfo;
import com.ruoyi.user.domain.common.ScoreCommon;

/**
 * 【请填写功能名称】Service接口
 *
 * @date 2023-04-02
 */
public interface IScoreService
{
    /**
     * 查询【请填写功能名称】
     *
     * @param scoreId 【请填写功能名称】主键
     * @return 【请填写功能名称】
     */
    public Score selectWxScoreByScoreId(Long scoreId);

    /**
     * 查询【请填写功能名称】列表
     *
     * @param wxScore 【请填写功能名称】
     * @return 【请填写功能名称】集合
     */
    public List<Score> selectWxScoreList(Score wxScore);

    public List<Score> selectThreeRetestLine(Score score);

    /**
     * 查询【请填写功能名称】
     *
     * @param score 【请填写功能名称】主键
     * @return 【请填写功能名称】
     */
    public Score scoreJudge(Score score);


    /**
     * 新增【请填写功能名称】
     *
     * @param wxScore 【请填写功能名称】
     * @return 结果
     */
    public int insertWxScore(Score wxScore);

    /**
     * 修改【请填写功能名称】
     *
     * @param wxScore 【请填写功能名称】
     * @return 结果
     */
    public int updateWxScore(Score wxScore);

    /**
     * 批量删除【请填写功能名称】
     *
     * @param scoreIds 需要删除的【请填写功能名称】主键集合
     * @return 结果
     */
    public int deleteWxScoreByScoreIds(Long[] scoreIds);

    /**
     * 删除【请填写功能名称】信息
     *
     * @param scoreId 【请填写功能名称】主键
     * @return 结果
     */
    public int deleteWxScoreByScoreId(Long scoreId);

    public List<AllInfo> selectAllInfoList(AllInfo allInfo);

    String importData(List<Score> scoreList);

    UserScoreInfo getScore();
}
