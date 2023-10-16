package com.ruoyi.user.controller;


import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.user.domain.Area;
import com.ruoyi.user.service.IAreaService;
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
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 【请填写功能名称】Controller
 *
 * @author ruoyi
 * @date 2023-03-25
 */
@RestController
@RequestMapping("/user/area")
public class AreaController extends BaseController
{
    @Autowired
    private IAreaService wxAreaService;

    /**
     * 查询【请填写功能名称】列表
     */
    @PreAuthorize("@ss.hasPermi('user:area:list')")
    @GetMapping("/list")
    public TableDataInfo list(Area wxArea)
    {
        startPage();
        List<Area> list = wxAreaService.selectWxAreaList(wxArea);
        return getDataTable(list);
    }

    /**
     * 查询【请填写功能名称】列表
     */
    @PreAuthorize("@ss.hasPermi('user:area:list')")
    @GetMapping("/areaList")
    public TableDataInfo areaList(Area wxArea)
    {
        List<Area> list = wxAreaService.selectWxAreaList(wxArea);
        return getDataTable(list);
    }

    /**
     * 导出【请填写功能名称】列表
     */
    @PreAuthorize("@ss.hasPermi('user:area:export')")
    @Log(title = "【请填写功能名称】", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Area wxArea)
    {
        List<Area> list = wxAreaService.selectWxAreaList(wxArea);
        ExcelUtil<Area> util = new ExcelUtil<Area>(Area.class);
        util.exportExcel(response, list, "地区数据");
    }

    /**
     * 获取【请填写功能名称】详细信息
     */
    @PreAuthorize("@ss.hasPermi('user:area:query')")
    @GetMapping(value = "/{areaId}")
    public AjaxResult getInfo(@PathVariable("areaId") Long areaId)
    {
        return success(wxAreaService.selectWxAreaByAreaId(areaId));
    }

    /**
     * 新增【请填写功能名称】
     */
    @PreAuthorize("@ss.hasPermi('user:area:add')")
    @Log(title = "【请填写功能名称】", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Area wxArea)
    {
        return toAjax(wxAreaService.insertWxArea(wxArea));
    }

    /**
     * 修改【请填写功能名称】
     */
    @PreAuthorize("@ss.hasPermi('user:area:edit')")
    @Log(title = "【请填写功能名称】", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Area wxArea)
    {
        return toAjax(wxAreaService.updateWxArea(wxArea));
    }

    /**
     * 删除【请填写功能名称】
     */
    @PreAuthorize("@ss.hasPermi('user:area:remove')")
    @Log(title = "【请填写功能名称】", businessType = BusinessType.DELETE)
    @DeleteMapping("/{areaIds}")
    public AjaxResult remove(@PathVariable Long[] areaIds)
    {
        return toAjax(wxAreaService.deleteWxAreaByAreaIds(areaIds));
    }
}
