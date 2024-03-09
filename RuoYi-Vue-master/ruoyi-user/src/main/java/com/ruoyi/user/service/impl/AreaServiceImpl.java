package com.ruoyi.user.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.user.mapper.AreaMapper;
import com.ruoyi.user.domain.Area;
import com.ruoyi.user.service.IAreaService;

/**
 * 地区Service业务层处理
 *
 * @author wx
 * @date 2024-01-18
 */
@Service
public class AreaServiceImpl implements IAreaService
{
    @Autowired
    private AreaMapper areaMapper;

    /**
     * 查询地区
     *
     * @param areaId 地区主键
     * @return 地区
     */
    @Override
    public Area selectAreaByAreaId(Long areaId)
    {
        return areaMapper.selectAreaByAreaId(areaId);
    }

    /**
     * 查询地区列表
     *
     * @param area 地区
     * @return 地区
     */
    @Override
    public List<Area> selectAreaList(Area area)
    {
        return areaMapper.selectAreaList(area);
    }

    /**
     * 新增地区
     *
     * @param area 地区
     * @return 结果
     */
    @Override
    public int insertArea(Area area)
    {
        return areaMapper.insertArea(area);
    }

    /**
     * 修改地区
     *
     * @param area 地区
     * @return 结果
     */
    @Override
    public int updateArea(Area area)
    {
        return areaMapper.updateArea(area);
    }

    /**
     * 批量删除地区
     *
     * @param areaIds 需要删除的地区主键
     * @return 结果
     */
    @Override
    public int deleteAreaByAreaIds(Long[] areaIds)
    {
        return areaMapper.deleteAreaByAreaIds(areaIds);
    }

    /**
     * 删除地区信息
     *
     * @param areaId 地区主键
     * @return 结果
     */
    @Override
    public int deleteAreaByAreaId(Long areaId)
    {
        return areaMapper.deleteAreaByAreaId(areaId);
    }
}
