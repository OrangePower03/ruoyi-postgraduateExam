package com.ruoyi.user.mapper;

import java.util.List;
import com.ruoyi.user.domain.Department;

/**
 * 【请填写功能名称】Mapper接口
 *
 * @date 2023-03-29
 */
public interface DepartmentMapper
{
    /**
     * 查询【请填写功能名称】
     *
     * @param departmentId 【请填写功能名称】主键
     * @return 【请填写功能名称】
     */
    public Department selectWxDepartmentByDepartmentId(Long departmentId);

    /**
     * 查询【请填写功能名称】列表
     *
     * @param wxDepartment 【请填写功能名称】
     * @return 【请填写功能名称】集合
     */
    public List<Department> selectWxDepartmentList(Department wxDepartment);

    /**
     * 新增【请填写功能名称】
     *
     * @param wxDepartment 【请填写功能名称】
     * @return 结果
     */
    public int insertWxDepartment(Department wxDepartment);

    /**
     * 修改【请填写功能名称】
     *
     * @param wxDepartment 【请填写功能名称】
     * @return 结果
     */
    public int updateWxDepartment(Department wxDepartment);

    /**
     * 删除【请填写功能名称】
     *
     * @param departmentId 【请填写功能名称】主键
     * @return 结果
     */
    public int deleteWxDepartmentByDepartmentId(Long departmentId);

    /**
     * 批量删除【请填写功能名称】
     *
     * @param departmentIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteWxDepartmentByDepartmentIds(Long[] departmentIds);
}
