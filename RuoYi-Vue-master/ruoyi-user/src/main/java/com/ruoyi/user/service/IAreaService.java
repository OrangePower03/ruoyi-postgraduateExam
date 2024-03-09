package com.ruoyi.user.service;

import java.util.List;
import com.ruoyi.user.domain.Area;

/**
 * 地区Service接口
 *
 * @author wx
 * @date 2024-01-18
 */
public interface IAreaService
{
    /**
     * 查询地区
     *
     * @param areaId 地区主键
     * @return 地区
     */
    public Area selectAreaByAreaId(Long areaId);

    /**
     * 查询地区列表
     *
     * @param area 地区
     * @return 地区集合
     */
    public List<Area> selectAreaList(Area area);

    /**
     * 新增地区
     *
     * @param area 地区
     * @return 结果
     */
    public int insertArea(Area area);

    /**
     * 修改地区
     *
     * @param area 地区
     * @return 结果
     */
    public int updateArea(Area area);

    /**
     * 批量删除地区
     *
     * @param areaIds 需要删除的地区主键集合
     * @return 结果
     */
    public int deleteAreaByAreaIds(Long[] areaIds);

    /**
     * 删除地区信息
     *
     * @param areaId 地区主键
     * @return 结果
     */
    public int deleteAreaByAreaId(Long areaId);
}
