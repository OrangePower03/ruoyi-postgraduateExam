package com.ruoyi.user.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.user.domain.Major;
import com.ruoyi.user.service.IMajorService;
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
 * 专业Controller
 *
 * @date 2023-04-01
 */
@RestController
@RequestMapping("/user/major")
public class MajorController extends BaseController
{
    @Autowired
    private IMajorService wxMajorService;

    @PreAuthorize("@ss.hasPermi('user:major:list')")
    @GetMapping("/sList")
    public TableDataInfo sList(Major wxMajor)
    {
        startPage();
        List<Major> list = wxMajorService.selectMajorList(wxMajor);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('user:major:list')")
    @GetMapping("/slist")
    public TableDataInfo slist(Major wxMajor)
    {
        List<Major> list = wxMajorService.selectMajorList(wxMajor);
        return getDataTable(list);
    }

    /**
     * 导出专业列表
     */
    @PreAuthorize("@ss.hasPermi('user:major:export')")
    @Log(title = "导出专业列表", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Major wxMajor)
    {
        List<Major> list = wxMajorService.selectMajorList(wxMajor);
        ExcelUtil<Major> util = new ExcelUtil<Major>(Major.class);
        util.exportExcel(response, list, "专业数据");
    }

    /**
     * 获取专业详细信息
     */
    @PreAuthorize("@ss.hasPermi('user:major:query')")
    @GetMapping(value = "/{majorId}")
    public AjaxResult getInfo(@PathVariable("majorId") Long majorId)
    {
        return success(wxMajorService.selectWxMajorByMajorId(majorId));
    }

    /**
     * 新增专业信息
     */
    @PreAuthorize("@ss.hasPermi('user:major:add')")
    @Log(title = "新增专业信息", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Major wxMajor)
    {
        return toAjax(wxMajorService.insertWxMajor(wxMajor));
    }

    /**
     * 修改专业信息
     */
    @PreAuthorize("@ss.hasPermi('user:major:edit')")
    @Log(title = "修改专业信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Major wxMajor)
    {
        return toAjax(wxMajorService.updateWxMajor(wxMajor));
    }

    /**
     * 删除专业信息
     */
    @PreAuthorize("@ss.hasPermi('uesr:major:remove')")
    @Log(title = "删除专业信息", businessType = BusinessType.DELETE)
    @DeleteMapping("/{majorIds}")
    public AjaxResult remove(@PathVariable Long[] majorIds)
    {
        return toAjax(wxMajorService.deleteWxMajorByMajorIds(majorIds));
    }
}
