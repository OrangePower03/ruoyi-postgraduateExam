package com.ruoyi.system.service.impl;

import java.util.List;

import com.ruoyi.user.domain.DScore;
import com.ruoyi.user.mapper.DScoreMapper;
import com.ruoyi.user.service.IDScoreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 【请填写功能名称】Service业务层处理
 *
 * @date 2023-04-23
 */
@Service
public class DScoreServiceImpl implements IDScoreService
{
    @Autowired
    private DScoreMapper wxDscoreMapper;

    /**
     * 查询【请填写功能名称】
     *
     * @param scoreId 【请填写功能名称】主键
     * @return 【请填写功能名称】
     */
    @Override
    public DScore selectWxDscoreByScoreId(Long scoreId)
    {
        return wxDscoreMapper.selectWxDscoreByScoreId(scoreId);
    }

    /**
     * 查询【请填写功能名称】列表
     *
     * @param wxDscore 【请填写功能名称】
     * @return 【请填写功能名称】
     */
    @Override
    public List<DScore> selectWxDscoreList(DScore wxDscore)
    {
        return wxDscoreMapper.selectWxDscoreList(wxDscore);
    }

    @Override
    public List<DScore> selectRetestList(DScore wxDscore) {
        return wxDscoreMapper.selectRetestList(wxDscore);
    }

    /**
     * 新增【请填写功能名称】
     *
     * @param wxDscore 【请填写功能名称】
     * @return 结果
     */
    @Override
    public int insertWxDscore(DScore wxDscore)
    {
        return wxDscoreMapper.insertWxDscore(wxDscore);
    }

    /**
     * 修改【请填写功能名称】
     *
     * @param wxDscore 【请填写功能名称】
     * @return 结果
     */
    @Override
    public int updateWxDscore(DScore wxDscore)
    {
        return wxDscoreMapper.updateWxDscore(wxDscore);
    }

    /**
     * 批量删除【请填写功能名称】
     *
     * @param scoreIds 需要删除的【请填写功能名称】主键
     * @return 结果
     */
    @Override
    public int deleteWxDscoreByScoreIds(Long[] scoreIds)
    {
        return wxDscoreMapper.deleteWxDscoreByScoreIds(scoreIds);
    }

    /**
     * 删除【请填写功能名称】信息
     *
     * @param scoreId 【请填写功能名称】主键
     * @return 结果
     */
    @Override
    public int deleteWxDscoreByScoreId(Long scoreId)
    {
        return wxDscoreMapper.deleteWxDscoreByScoreId(scoreId);
    }
}
