package com.ruoyi.user.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.user.domain.Department;
import com.ruoyi.user.service.IDepartmentService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 学院Controller
 *
 * @date 2023-03-29
 */
@RestController
@RequestMapping("/user/department")
public class DepartmentController extends BaseController
{
    @Autowired
    private IDepartmentService wxDepartmentService;

    /**
     * 查询【请填写功能名称】列表
     */
    @PreAuthorize("@ss.hasPermi('user:department:list')")
    @GetMapping("/list")
    public TableDataInfo list(Department wxDepartment)
    {
        startPage();
        List<Department> list = wxDepartmentService.selectWxDepartmentList(wxDepartment);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('user:department:list')")
    @GetMapping("/departmentList")
    public TableDataInfo departmentList(Department wxDepartment)
    {
        System.out.println("**************************");
        System.out.println(wxDepartment);
        System.out.println("**************************");
        List<Department> list = wxDepartmentService.selectWxDepartmentList(wxDepartment);
        return getDataTable(list);
    }

    /**
     * 导出学院列表
     */
    @PreAuthorize("@ss.hasPermi('user:department:export')")
    @Log(title = "导出学院列表", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Department wxDepartment)
    {
        List<Department> list = wxDepartmentService.selectWxDepartmentList(wxDepartment);
        ExcelUtil<Department> util = new ExcelUtil<Department>(Department.class);
        util.exportExcel(response, list, "学院数据");
    }

    /**
     * 获取学院详细信息
     */
    @PreAuthorize("@ss.hasPermi('user:department:query')")
    @GetMapping(value = "/{departmentId}")
    public AjaxResult getInfo(@PathVariable("departmentId") Long departmentId)
    {
        return success(wxDepartmentService.selectWxDepartmentByDepartmentId(departmentId));
    }

    /**
     * 新增学院信息
     */
    @PreAuthorize("@ss.hasPermi('user:department:add')")
    @Log(title = "新增学院信息", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Department wxDepartment)
    {
        return toAjax(wxDepartmentService.insertWxDepartment(wxDepartment));
    }

    /**
     * 修改学院信息
     */
    @PreAuthorize("@ss.hasPermi('user:department:edit')")
    @Log(title = "修改学院信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Department wxDepartment)
    {
        return toAjax(wxDepartmentService.updateWxDepartment(wxDepartment));
    }

    /**
     * 删除学院信息
     */
    @PreAuthorize("@ss.hasPermi('user:department:remove')")
    @Log(title = "删除学院信息", businessType = BusinessType.DELETE)
    @DeleteMapping("/{departmentIds}")
    public AjaxResult remove(@PathVariable Long[] departmentIds)
    {
        return toAjax(wxDepartmentService.deleteWxDepartmentByDepartmentIds(departmentIds));
    }
}
