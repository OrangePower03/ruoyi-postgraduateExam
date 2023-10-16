package com.ruoyi.user.service;

import java.util.List;
import com.ruoyi.user.domain.Area;

/**
 * 【请填写功能名称】Service接口
 *
 * @author ruoyi
 * @date 2023-03-26
 */
public interface IAreaService
{
    /**
     * 查询【请填写功能名称】
     *
     * @param areaId 【请填写功能名称】主键
     * @return 【请填写功能名称】
     */
    public Area selectWxAreaByAreaId(Long areaId);

    /**
     * 查询【请填写功能名称】列表
     *
     * @param wxArea 【请填写功能名称】
     * @return 【请填写功能名称】集合
     */
    public List<Area> selectWxAreaList(Area wxArea);

    /**
     * 新增【请填写功能名称】
     *
     * @param wxArea 【请填写功能名称】
     * @return 结果
     */
    public int insertWxArea(Area wxArea);

    /**
     * 修改【请填写功能名称】
     *
     * @param wxArea 【请填写功能名称】
     * @return 结果
     */
    public int updateWxArea(Area wxArea);

    /**
     * 批量删除【请填写功能名称】
     *
     * @param areaIds 需要删除的【请填写功能名称】主键集合
     * @return 结果
     */
    public int deleteWxAreaByAreaIds(Long[] areaIds);

    /**
     * 删除【请填写功能名称】信息
     *
     * @param areaId 【请填写功能名称】主键
     * @return 结果
     */
    public int deleteWxAreaByAreaId(Long areaId);
}
