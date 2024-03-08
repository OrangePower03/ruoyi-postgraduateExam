package com.ruoyi.user.mapper;

import java.util.List;
import com.ruoyi.user.domain.Area;

/**
 * 【请填写功能名称】Mapper接口
 *
 * @author ruoyi
 * @date 2023-03-26
 */
public interface AreaMapper
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
     * 删除【请填写功能名称】
     *
     * @param areaId 【请填写功能名称】主键
     * @return 结果
     */
    public int deleteWxAreaByAreaId(Long areaId);

    /**
     * 批量删除【请填写功能名称】
     *
     * @param areaIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteWxAreaByAreaIds(Long[] areaIds);
}
