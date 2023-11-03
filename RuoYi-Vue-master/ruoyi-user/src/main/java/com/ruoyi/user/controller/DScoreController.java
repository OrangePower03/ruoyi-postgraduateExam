package com.ruoyi.user.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.user.domain.DScore;
import com.ruoyi.user.service.IDScoreService;
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
 * @author ruoyi
 * @date 2023-04-23
 */
@RestController
@RequestMapping("/user/dscore")
public class DScoreController extends BaseController
{
    @Autowired
    private IDScoreService wxDscoreService;

    /**
     * 查询【请填写功能名称】列表
     */
    @PreAuthorize("@ss.hasPermi('user:dscore:list')")
    @GetMapping("/list")
    public TableDataInfo list(DScore wxDscore)
    {
        startPage();
        List<DScore> list = wxDscoreService.selectWxDscoreList(wxDscore);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('user:dscore:list')")
    @GetMapping("/retestList")
    public TableDataInfo retestList(DScore wxDscore)
    {
        List<DScore> list = wxDscoreService.selectRetestList(wxDscore);
        return getDataTable(list);
    }

    /**
     * 导出【请填写功能名称】列表
     */
    @PreAuthorize("@ss.hasPermi('user:dscore:export')")
    @Log(title = "【请填写功能名称】", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, DScore wxDscore)
    {
        List<DScore> list = wxDscoreService.selectWxDscoreList(wxDscore);
        ExcelUtil<DScore> util = new ExcelUtil<DScore>(DScore.class);
        util.exportExcel(response, list, "国家线数据");
    }

    /**
     * 获取【请填写功能名称】详细信息
     */
    @PreAuthorize("@ss.hasPermi('user:dscore:query')")
    @GetMapping(value = "/{scoreId}")
    public AjaxResult getInfo(@PathVariable("scoreId") Long scoreId)
    {
        return success(wxDscoreService.selectWxDscoreByScoreId(scoreId));
    }

    /**
     * 新增【请填写功能名称】
     */
    @PreAuthorize("@ss.hasPermi('user:dscore:add')")
    @Log(title = "【请填写功能名称】", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody DScore wxDscore)
    {
        return toAjax(wxDscoreService.insertWxDscore(wxDscore));
    }

    /**
     * 修改【请填写功能名称】
     */
    @PreAuthorize("@ss.hasPermi('user:dscore:edit')")
    @Log(title = "【请填写功能名称】", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody DScore wxDscore)
    {
        return toAjax(wxDscoreService.updateWxDscore(wxDscore));
    }

    /**
     * 删除【请填写功能名称】
     */
    @PreAuthorize("@ss.hasPermi('user:dscore:remove')")
    @Log(title = "【请填写功能名称】", businessType = BusinessType.DELETE)
    @DeleteMapping("/{scoreIds}")
    public AjaxResult remove(@PathVariable Long[] scoreIds)
    {
        return toAjax(wxDscoreService.deleteWxDscoreByScoreIds(scoreIds));
    }
}
