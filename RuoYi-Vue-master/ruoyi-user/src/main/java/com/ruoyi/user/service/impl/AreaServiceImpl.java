package com.ruoyi.user.service.impl;

import java.util.List;

import com.ruoyi.framework.web.domain.server.Sys;
import com.ruoyi.user.domain.Area;
import com.ruoyi.user.service.IAreaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.user.mapper.AreaMapper;

/**
 * 【请填写功能名称】Service业务层处理
 *
 * @author ruoyi
 * @date 2023-03-26
 */
@Service
public class AreaServiceImpl implements IAreaService
{
    @Autowired
    private AreaMapper wxAreaMapper;

    /**
     * 查询【请填写功能名称】
     *
     * @param areaId 【请填写功能名称】主键
     * @return 【请填写功能名称】
     */
    @Override
    public Area selectWxAreaByAreaId(Long areaId)
    {
        return wxAreaMapper.selectWxAreaByAreaId(areaId);
    }

    /**
     * 查询【请填写功能名称】列表
     *
     * @param wxArea 【请填写功能名称】
     * @return 【请填写功能名称】
     */
    @Override
    public List<Area> selectWxAreaList(Area wxArea)
    {
        return wxAreaMapper.selectWxAreaList(wxArea);
    }

    /**
     * 新增【请填写功能名称】
     *
     * @param wxArea 【请填写功能名称】
     * @return 结果
     */
    @Override
    public int insertWxArea(Area wxArea)
    {
        return wxAreaMapper.insertWxArea(wxArea);
    }

    /**
     * 修改【请填写功能名称】
     *
     * @param wxArea 【请填写功能名称】
     * @return 结果
     */
    @Override
    public int updateWxArea(Area wxArea)
    {
        return wxAreaMapper.updateWxArea(wxArea);
    }

    /**
     * 批量删除【请填写功能名称】
     *
     * @param areaIds 需要删除的【请填写功能名称】主键
     * @return 结果
     */
    @Override
    public int deleteWxAreaByAreaIds(Long[] areaIds)
    {
        return wxAreaMapper.deleteWxAreaByAreaIds(areaIds);
    }

    /**
     * 删除【请填写功能名称】信息
     *
     * @param areaId 【请填写功能名称】主键
     * @return 结果
     */
    @Override
    public int deleteWxAreaByAreaId(Long areaId)
    {
        return wxAreaMapper.deleteWxAreaByAreaId(areaId);
    }
}
