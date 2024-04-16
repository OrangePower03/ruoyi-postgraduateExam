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
import com.ruoyi.user.domain.Info;
import com.ruoyi.user.service.IInfoService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 招生信息Controller
 *
 * @date 2024-02-17
 */
@RestController
@RequestMapping("/user/info")
public class InfoController extends BaseController
{
    @Autowired
    private IInfoService infoService;

    /**
     * 查询招生信息列表
     */
    @PreAuthorize("@ss.hasPermi('user:info:list')")
    @GetMapping("/list")
    public TableDataInfo list(Info info)
    {
        startPage();
        List<Info> list = infoService.selectInfoList(info);
        return getDataTable(list);
    }

    /**
     * 导出招生信息列表
     */
    @PreAuthorize("@ss.hasPermi('user:info:export')")
    @Log(title = "招生信息", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Info info)
    {
        List<Info> list = infoService.selectInfoList(info);
        ExcelUtil<Info> util = new ExcelUtil<Info>(Info.class);
        util.exportExcel(response, list, "招生信息数据");
    }

    /**
     * 获取招生信息详细信息
     */
    @PreAuthorize("@ss.hasPermi('user:info:query')")
    @GetMapping(value = "/{infoId}")
    public AjaxResult getInfo(@PathVariable("infoId") Long infoId)
    {
        return success(infoService.selectInfoByInfoId(infoId));
    }

    /**
     * 新增招生信息
     */
    @PreAuthorize("@ss.hasPermi('user:info:add')")
    @Log(title = "招生信息", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Info info)
    {
        return toAjax(infoService.insertInfo(info));
    }

    /**
     * 修改招生信息
     */
    @PreAuthorize("@ss.hasPermi('user:info:edit')")
    @Log(title = "招生信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Info info)
    {
        return toAjax(infoService.updateInfo(info));
    }

    /**
     * 删除招生信息
     */
    @PreAuthorize("@ss.hasPermi('user:info:remove')")
    @Log(title = "招生信息", businessType = BusinessType.DELETE)
    @DeleteMapping("/{infoIds}")
    public AjaxResult remove(@PathVariable Long[] infoIds)
    {
        return toAjax(infoService.deleteInfoByInfoIds(infoIds));
    }
}
