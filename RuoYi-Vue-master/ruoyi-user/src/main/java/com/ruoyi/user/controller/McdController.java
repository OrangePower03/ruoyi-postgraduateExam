package com.ruoyi.user.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.framework.web.domain.server.Sys;
import com.ruoyi.user.domain.Connect;
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
 * 【请填写功能名称】Controller
 *
 * @date 2023-04-01
 */
@RestController
@RequestMapping("/user/connect")
public class McdController extends BaseController
{
    @Autowired
    private IMajorService wxMajorService;

    /**
     * 查询院校专业列表
     */
    @PreAuthorize("@ss.hasPermi('user:major:list')")
    @GetMapping("/list")
    public TableDataInfo list(Major wxMajor)
    {
        startPage();
        List<Major> list = wxMajorService.selectWxMajorList(wxMajor);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('user:major:list')")
    @GetMapping("/majorList")
    public TableDataInfo majorList(Major wxMajor)
    {
        List<Major> list = wxMajorService.selectWxMajorList(wxMajor);
        return getDataTable(list);
    }
    /**
     * 获取院校专业详细信息
     */
    @PreAuthorize("@ss.hasPermi('user:connect:query')")
    @GetMapping(value = "/{connectId}")
    public AjaxResult getConnectInfo(@PathVariable("connectId") Long connectId)
    {
        return success(wxMajorService.selectWxConnectByConnectId(connectId));
    }
    /**
     * 新增院校专业信息
     */
    @PreAuthorize("@ss.hasPermi('user:connect:add')")
    @Log(title = "新增院校专业信息", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Connect wxMcd)
    {
        System.out.println("***************************");
        System.out.println(wxMcd);
        System.out.println("***************************");
        return toAjax(wxMajorService.insertWxMcd(wxMcd));
    }

    /**
     * 修改院校专业信息
     */
    @PreAuthorize("@ss.hasPermi('user:connect:edit')")
    @Log(title = "修改院校专业信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Connect wxMcd)
    {
        return toAjax(wxMajorService.updateWxMcd(wxMcd));
    }

    /**
     * 删除院校专业信息
     */
    @PreAuthorize("@ss.hasPermi('user:connect:remove')")
    @Log(title = "删除院校专业信息", businessType = BusinessType.DELETE)
    @DeleteMapping("/{connectIds}")
    public AjaxResult connectRemove(@PathVariable Long[] connectIds)
    {
        return toAjax(wxMajorService.deleteWxMcdByConnectIds(connectIds));
    }
}
