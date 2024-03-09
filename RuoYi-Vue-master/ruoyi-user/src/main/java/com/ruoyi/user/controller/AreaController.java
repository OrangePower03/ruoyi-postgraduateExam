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
import com.ruoyi.user.domain.Area;
import com.ruoyi.user.service.IAreaService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 地区Controller
 *
 * @author wx
 * @date 2024-01-18
 */
@RestController
@RequestMapping("/user/area")
public class AreaController extends BaseController
{
    @Autowired
    private IAreaService areaService;

    /**
     * 查询地区列表
     */
    @PreAuthorize("@ss.hasPermi('user:area:list')")
    @GetMapping("/list")
    public TableDataInfo list(Area area)
    {
        startPage();
        List<Area> list = areaService.selectAreaList(area);
        return getDataTable(list);
    }

    /**
     * 查询所有地区列表
     */
    @PreAuthorize("@ss.hasPermi('user:area:list')")
    @GetMapping("/areaList")
    public TableDataInfo allList(Area area)
    {
        List<Area> list = areaService.selectAreaList(area);
        return getDataTable(list);
    }

    /**
     * 导出地区列表
     */
    @PreAuthorize("@ss.hasPermi('user:area:export')")
    @Log(title = "地区", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Area area)
    {
        List<Area> list = areaService.selectAreaList(area);
        ExcelUtil<Area> util = new ExcelUtil<Area>(Area.class);
        util.exportExcel(response, list, "地区数据");
    }

    /**
     * 获取地区详细信息
     */
    @PreAuthorize("@ss.hasPermi('user:area:query')")
    @GetMapping(value = "/{areaId}")
    public AjaxResult getInfo(@PathVariable("areaId") Long areaId)
    {
        return success(areaService.selectAreaByAreaId(areaId));
    }

    /**
     * 新增地区
     */
    @PreAuthorize("@ss.hasPermi('user:area:add')")
    @Log(title = "地区", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Area area)
    {
        return toAjax(areaService.insertArea(area));
    }

    /**
     * 修改地区
     */
    @PreAuthorize("@ss.hasPermi('user:area:edit')")
    @Log(title = "地区", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Area area)
    {
        return toAjax(areaService.updateArea(area));
    }

    /**
     * 删除地区
     */
    @PreAuthorize("@ss.hasPermi('user:area:remove')")
    @Log(title = "地区", businessType = BusinessType.DELETE)
    @DeleteMapping("/{areaIds}")
    public AjaxResult remove(@PathVariable Long[] areaIds)
    {
        return toAjax(areaService.deleteAreaByAreaIds(areaIds));
    }
}
