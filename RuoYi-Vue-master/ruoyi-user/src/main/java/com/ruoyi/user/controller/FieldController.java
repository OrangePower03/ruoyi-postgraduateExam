package com.ruoyi.user.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;
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
import com.ruoyi.user.domain.Field;
import com.ruoyi.user.service.IFieldService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 学科类别Controller
 *
 * @author wx
 * @date 2024-02-26
 */
@RestController
@RequestMapping("/user/field")
public class FieldController extends BaseController
{
    @Autowired
    private IFieldService fieldService;

    /**
     * 查询学科类别列表
     */
    @PreAuthorize("@ss.hasPermi('user:field:list')")
    @GetMapping("/list")
    public TableDataInfo list(Field field)
    {
        startPage();
        List<Field> list = fieldService.selectFieldList(field);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('user:field:list')")
    @GetMapping("/fieldList")
    public TableDataInfo fieldList(Field field)
    {
        List<Field> list = fieldService.selectFieldList(field);
        return getDataTable(list);
    }

    /**
     * 导出学科类别列表
     */
    @PreAuthorize("@ss.hasPermi('user:field:export')")
    @Log(title = "学科类别", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Field field)
    {
        List<Field> list = fieldService.selectFieldList(field);
        ExcelUtil<Field> util = new ExcelUtil<Field>(Field.class);
        util.exportExcel(response, list, "学科类别数据");
    }

    /**
     * 获取学科类别详细信息
     */
    @PreAuthorize("@ss.hasPermi('user:field:query')")
    @GetMapping(value = "/{fieldId}")
    public AjaxResult getInfo(@PathVariable("fieldId") Long fieldId)
    {
        return success(fieldService.selectFieldByFieldId(fieldId));
    }

    /**
     * 新增学科类别
     */
    @PreAuthorize("@ss.hasPermi('user:field:add')")
    @Log(title = "学科类别", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Field field)
    {
        return toAjax(fieldService.insertField(field));
    }

    /**
     * 修改学科类别
     */
    @PreAuthorize("@ss.hasPermi('user:field:edit')")
    @Log(title = "学科类别", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Field field)
    {
        return toAjax(fieldService.updateField(field));
    }

    /**
     * 删除学科类别
     */
    @PreAuthorize("@ss.hasPermi('user:field:remove')")
    @Log(title = "学科类别", businessType = BusinessType.DELETE)
    @DeleteMapping("/{fieldIds}")
    public AjaxResult remove(@PathVariable Long[] fieldIds)
    {
        return toAjax(fieldService.deleteFieldByFieldIds(fieldIds));
    }
}
