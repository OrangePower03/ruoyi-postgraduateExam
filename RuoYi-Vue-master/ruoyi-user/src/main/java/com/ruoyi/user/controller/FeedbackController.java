package com.ruoyi.user.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.user.domain.Feedback;
import com.ruoyi.user.service.IFeedbackService;
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
 * 考研反馈Controller
 *
 * @date 2023-04-25
 */
@RestController
@RequestMapping("/user/feedback")
public class FeedbackController extends BaseController
{
    @Autowired
    private IFeedbackService wxFeedbackService;

    /**
     * 查询考研反馈列表
     */
    @PreAuthorize("@ss.hasPermi('user:feedback:list')")
    @GetMapping("/list")
    public TableDataInfo list(Feedback wxFeedback)
    {
        startPage();
        List<Feedback> list = wxFeedbackService.selectWxFeedbackList(wxFeedback);
        return getDataTable(list);
    }

    /**
     * 导出考研反馈列表
     */
    @PreAuthorize("@ss.hasPermi('user:feedback:export')")
    @Log(title = "导出考研反馈列表", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Feedback wxFeedback)
    {
        List<Feedback> list = wxFeedbackService.selectWxFeedbackList(wxFeedback);
        ExcelUtil<Feedback> util = new ExcelUtil<Feedback>(Feedback.class);
        util.exportExcel(response, list, "【请填写功能名称】数据");
    }

    /**
     * 获取考研反馈详细信息
     */
    @PreAuthorize("@ss.hasPermi('user:feedback:query')")
    @GetMapping(value = "/{userId}")
    public AjaxResult getInfo(@PathVariable("userId") Long userId)
    {
        return success(wxFeedbackService.selectWxFeedbackByUserId(userId));
    }


    @PreAuthorize("@ss.hasPermi('user:feedback:add')")
    @PostMapping
    public AjaxResult add(@RequestBody Feedback wxFeedback)
    {
        Long userId=SecurityUtils.getLoginUser().getUserId();
        if(wxFeedbackService.selectWxFeedbackByUserId(userId)==null){
            wxFeedback.setUserId(userId);
            return wxFeedbackService.insertWxFeedback(wxFeedback)>0?AjaxResult.success("提交成功，感谢您的反馈！") : AjaxResult.error("提交失败，请联系管理员。");
        }else{
            return AjaxResult.warn("您已提交过反馈，感谢您的参与！");
        }

    }

    /**
     * 修改考研反馈信息
     */
    @PreAuthorize("@ss.hasPermi('user:feedback:edit')")
    @Log(title = "修改考研反馈信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Feedback wxFeedback)
    {
        return toAjax(wxFeedbackService.updateWxFeedback(wxFeedback));
    }

    /**
     * 删除考研反馈信息
     */
    @PreAuthorize("@ss.hasPermi('user:feedback:remove')")
    @Log(title = "删除考研反馈信息", businessType = BusinessType.DELETE)
    @DeleteMapping("/{userIds}")
    public AjaxResult remove(@PathVariable Long[] userIds)
    {
        return toAjax(wxFeedbackService.deleteWxFeedbackByUserIds(userIds));
    }
}
