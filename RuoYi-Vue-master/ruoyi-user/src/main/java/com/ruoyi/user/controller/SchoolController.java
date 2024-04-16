package com.ruoyi.user.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.user.domain.School;
import com.ruoyi.user.domain.minSchool;
import com.ruoyi.user.service.ISchoolService;
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
 * 学校信息Controller
 *
 * @date 2023-03-26
 */
@RestController
@RequestMapping("/user/school")
public class SchoolController extends BaseController
{
    @Autowired
    private ISchoolService wxSchoolService;

    /**
     * 查询学校信息列表
     */
    @PreAuthorize("@ss.hasPermi('user:school:list')")
    @GetMapping("/list")
    public TableDataInfo list(School wxSchool)
    {
        startPage();
        List<School> list = wxSchoolService.selectWxSchoolList(wxSchool);
        System.out.println(list);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('user:school:list')")
    @GetMapping("/schoolList")
    public TableDataInfo schoolList()
    {
        List<minSchool> list = wxSchoolService.optionWxSchoolList();
        return getDataTable(list);
    }

    /**
     * 导出学校信息列表
     */
    @PreAuthorize("@ss.hasPermi('user:school:export')")
    @Log(title = "【请填写功能名称】", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, School wxSchool)
    {
        List<School> list = wxSchoolService.selectWxSchoolList(wxSchool);
        ExcelUtil<School> util = new ExcelUtil<School>(School.class);
        util.exportExcel(response, list, "【请填写功能名称】数据");
    }

    /**
     * 获取学校信息详细信息
     */
    @PreAuthorize("@ss.hasPermi('user:school:list')")
    @GetMapping(value = "/{schoolId}")
    public AjaxResult getInfo(@PathVariable("schoolId") Long schoolId)
    {
        return success(wxSchoolService.selectWxSchoolBySchoolId(schoolId));
    }

    /**
     * 新增学校信息
     */
    @PreAuthorize("@ss.hasPermi('user:school:add')")
    @Log(title = "新增学校信息", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody School wxSchool)
    {
        return toAjax(wxSchoolService.insertWxSchool(wxSchool));
    }

    /**
     * 修改学校信息
     */
    @PreAuthorize("@ss.hasPermi('user:school:edit')")
    @Log(title = "修改学校信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody School wxSchool)
    {
        return toAjax(wxSchoolService.updateWxSchool(wxSchool));
    }

    /**
     * 删除学校信息
     */
    @PreAuthorize("@ss.hasPermi('user:school:remove')")
    @Log(title = "删除学校信息", businessType = BusinessType.DELETE)
    @DeleteMapping("/{schoolIds}")
    public AjaxResult remove(@PathVariable Long[] schoolIds)
    {
        return toAjax(wxSchoolService.deleteWxSchoolBySchoolIds(schoolIds));
    }
}
