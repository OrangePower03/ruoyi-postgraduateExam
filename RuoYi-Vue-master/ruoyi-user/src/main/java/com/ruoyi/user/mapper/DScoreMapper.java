package com.ruoyi.user.mapper;

import java.util.List;
import com.ruoyi.user.domain.DScore;

/**
 * 【请填写功能名称】Mapper接口
 *
 * @date 2023-04-23
 */
public interface DScoreMapper
{
    /**
     * 查询【请填写功能名称】
     *
     * @param scoreId 【请填写功能名称】主键
     * @return 【请填写功能名称】
     */
    public DScore selectWxDscoreByScoreId(Long scoreId);

    /**
     * 查询【请填写功能名称】列表
     *
     * @param wxDscore 【请填写功能名称】
     * @return 【请填写功能名称】集合
     */
    public List<DScore> selectWxDscoreList(DScore wxDscore);

    /**
     * 查询【请填写功能名称】列表
     *
     * @param wxDscore 【请填写功能名称】
     * @return 【请填写功能名称】集合
     */
    public List<DScore> selectRetestList(DScore wxDscore);

    /**
     * 新增【请填写功能名称】
     *
     * @param wxDscore 【请填写功能名称】
     * @return 结果
     */
    public int insertWxDscore(DScore wxDscore);

    /**
     * 修改【请填写功能名称】
     *
     * @param wxDscore 【请填写功能名称】
     * @return 结果
     */
    public int updateWxDscore(DScore wxDscore);

    /**
     * 删除【请填写功能名称】
     *
     * @param scoreId 【请填写功能名称】主键
     * @return 结果
     */
    public int deleteWxDscoreByScoreId(Long scoreId);

    /**
     * 批量删除【请填写功能名称】
     *
     * @param scoreIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteWxDscoreByScoreIds(Long[] scoreIds);

    List<DScore> selectByMajorName(String majorName);
}
