package com.ruoyi.user.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.user.domain.UserScoreInfo;
import com.ruoyi.user.service.IUserScoreInfoService;
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
 * 用户考研信息Controller
 *
 * @date 2023-04-26
 */
@RestController
@RequestMapping("/user/scoreinfo")
public class UserScoreInfoController extends BaseController
{
    @Autowired
    private IUserScoreInfoService wxUserScoreinfoService;

    /**
     * 查询用户考研信息列表
     */
    @GetMapping("/list")
    public AjaxResult list(UserScoreInfo wxUserScoreinfo)
    {
        return success(wxUserScoreinfoService.selectWxUserScoreInfoByUserId(SecurityUtils.getLoginUser().getUserId()));
    }

    /**
     * 获取用户考研详细信息
     */
    @GetMapping(value = "/{userId}")
    public AjaxResult getInfo(@PathVariable("userId") Long userId)
    {
        return success(wxUserScoreinfoService.selectWxUserScoreInfoByUserId(userId));
    }

    /**
     * 导出用户考研信息列表
     */
    @Log(title = "导出用户考研信息列表", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, UserScoreInfo wxUserScoreinfo)
    {
        List<UserScoreInfo> list = wxUserScoreinfoService.selectWxUserScoreInfoList(wxUserScoreinfo);
        ExcelUtil<UserScoreInfo> util = new ExcelUtil<UserScoreInfo>(UserScoreInfo.class);
        util.exportExcel(response, list, "【请填写功能名称】数据");
    }

    /**
     * 新增用户考研信息
     */
    @PostMapping
    public AjaxResult add(@RequestBody UserScoreInfo wxUserScoreinfo)
    {
        return toAjax(wxUserScoreinfoService.insertWxUserScoreInfo(wxUserScoreinfo));
    }

    /**
     * 修改用户考研信息
     */
    @PutMapping
    public AjaxResult edit(@RequestBody UserScoreInfo wxUserScoreinfo)
    {
        Long userId= SecurityUtils.getLoginUser().getUserId();
        wxUserScoreinfo.setUserId(userId);
        if(wxUserScoreinfoService.selectWxUserScoreInfoByUserId(userId)==null)
            return toAjax(wxUserScoreinfoService.insertWxUserScoreInfo(wxUserScoreinfo));
        else
            return toAjax(wxUserScoreinfoService.updateWxUserScoreInfo(wxUserScoreinfo));
    }

    /**
     * 删除用户考研信息
     */
    @PreAuthorize("@ss.hasPermi('user:scoreinfo:remove')")
    @DeleteMapping("/{userIds}")
    public AjaxResult remove(@PathVariable Long[] userIds)
    {
        return toAjax(wxUserScoreinfoService.deleteWxUserScoreInfoByUserIds(userIds));
    }
}
