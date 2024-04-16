package com.ruoyi.user.service.impl;

import java.util.List;

import com.ruoyi.user.domain.Department;
import com.ruoyi.user.mapper.DepartmentMapper;
import com.ruoyi.user.service.IDepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 【请填写功能名称】Service业务层处理
 *
 * @date 2023-03-29
 */
@Service
public class DepartmentServiceImpl implements IDepartmentService
{
    @Autowired
    private DepartmentMapper wxDepartmentMapper;

    /**
     * 查询【请填写功能名称】
     *
     * @param departmentId 【请填写功能名称】主键
     * @return 【请填写功能名称】
     */
    @Override
    public Department selectWxDepartmentByDepartmentId(Long departmentId)
    {
        return wxDepartmentMapper.selectWxDepartmentByDepartmentId(departmentId);
    }

    /**
     * 查询【请填写功能名称】列表
     *
     * @param wxDepartment 【请填写功能名称】
     * @return 【请填写功能名称】
     */
    @Override
    public List<Department> selectWxDepartmentList(Department wxDepartment)
    {
        return wxDepartmentMapper.selectWxDepartmentList(wxDepartment);
    }

    /**
     * 新增【请填写功能名称】
     *
     * @param wxDepartment 【请填写功能名称】
     * @return 结果
     */
    @Override
    public int insertWxDepartment(Department wxDepartment)
    {
        return wxDepartmentMapper.insertWxDepartment(wxDepartment);
    }

    /**
     * 修改【请填写功能名称】
     *
     * @param wxDepartment 【请填写功能名称】
     * @return 结果
     */
    @Override
    public int updateWxDepartment(Department wxDepartment)
    {
        return wxDepartmentMapper.updateWxDepartment(wxDepartment);
    }

    /**
     * 批量删除【请填写功能名称】
     *
     * @param departmentIds 需要删除的【请填写功能名称】主键
     * @return 结果
     */
    @Override
    public int deleteWxDepartmentByDepartmentIds(Long[] departmentIds)
    {
        return wxDepartmentMapper.deleteWxDepartmentByDepartmentIds(departmentIds);
    }

    /**
     * 删除【请填写功能名称】信息
     *
     * @param departmentId 【请填写功能名称】主键
     * @return 结果
     */
    @Override
    public int deleteWxDepartmentByDepartmentId(Long departmentId)
    {
        return wxDepartmentMapper.deleteWxDepartmentByDepartmentId(departmentId);
    }
}
