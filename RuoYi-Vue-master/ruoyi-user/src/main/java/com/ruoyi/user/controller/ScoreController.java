package com.ruoyi.user.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.common.constant.HttpStatus;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.user.domain.AllInfo;
import com.ruoyi.user.domain.Score;
import com.ruoyi.user.domain.dto.RecommendDto;
import com.ruoyi.user.domain.vo.RecommendVo;
import com.ruoyi.user.service.IScoreService;
import com.ruoyi.user.service.RecommendService;
import org.springframework.beans.BeanUtils;
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
import org.springframework.web.multipart.MultipartFile;

/**
 * 【请填写功能名称】Controller
 *
 * @author ruoyi
 * @date 2023-04-02
 */
@RestController
@RequestMapping("/user/score")
public class ScoreController extends BaseController
{
    @Autowired
    private IScoreService wxScoreService;

    @Autowired
    private RecommendService recommendService;

    /**
     * 查询【请填写功能名称】列表
     */
    @PreAuthorize("@ss.hasPermi('user:score:list')")
    @GetMapping("/list")
    public TableDataInfo list(Score wxScore)
    {
        startPage();
        List<Score> list = wxScoreService.selectWxScoreList(wxScore);
        return getDataTable(list);
    }

    /**
     * 查询【请填写功能名称】列表
     */
    @PreAuthorize("@ss.hasPermi('user:score:list')")
    @GetMapping("/AllInfoList")
    public TableDataInfo allInfoList(AllInfo allInfo)
    {
        List<AllInfo> list = wxScoreService.selectAllInfoList(allInfo);
//        System.out.println(list);
        return getDataTable(list);
    }

    /**
     * 推荐算法的接口
     * @param recommendDto 前端发来的分数和地区，专业
     * @return 返回九个推荐的院校，其中包括
     */
    @PreAuthorize("@ss.hasPermi('user:score:list')")
    @GetMapping("/recommend")
    public TableDataInfo recommend(RecommendDto recommendDto)
    {
        List<RecommendVo> recommend = recommendService.recommend(recommendDto);
        return getDataTable(recommend);
    }


    /**
     * 导出复试线列表
     */
    @PreAuthorize("@ss.hasPermi('user:score:export')")
    @Log(title = "导出复试线列表", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Score wxScore)
    {
        List<Score> list = wxScoreService.selectWxScoreList(wxScore);
        ExcelUtil<Score> util = new ExcelUtil<Score>(Score.class);
        util.exportExcel(response, list, "复试线信息");
    }

    /**
     * 获取【请填写功能名称】详细信息
     */
    @PreAuthorize("@ss.hasPermi('user:score:query')")
    @GetMapping(value = "/{scoreId}")
    public AjaxResult getInfo(@PathVariable("scoreId") Long scoreId)
    {
        return success(wxScoreService.selectWxScoreByScoreId(scoreId));
    }

    /**
     * 新增【请填写功能名称】
     */
    @PreAuthorize("@ss.hasPermi('user:score:add')")
    @Log(title = "【请填写功能名称】", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Score wxScore)
    {
        return toAjax(wxScoreService.insertWxScore(wxScore));
    }

    /**
     * 修改【请填写功能名称】
     */
    @PreAuthorize("@ss.hasPermi('user:score:edit')")
    @Log(title = "【请填写功能名称】", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Score wxScore)
    {
        return toAjax(wxScoreService.updateWxScore(wxScore));
    }

    /**
     * 删除【请填写功能名称】
     */
    @PreAuthorize("@ss.hasPermi('user:score:remove')")
    @Log(title = "【请填写功能名称】", businessType = BusinessType.DELETE)
    @DeleteMapping("/{scoreIds}")
    public AjaxResult remove(@PathVariable Long[] scoreIds)
    {
        return toAjax(wxScoreService.deleteWxScoreByScoreIds(scoreIds));
    }

    @PostMapping("/importTemplate")
    public void importTemplate(HttpServletResponse response)
    {
        ExcelUtil<Score> util = new ExcelUtil<>(Score.class);
        util.importTemplateExcel(response, "复试线数据表");
    }

    @PreAuthorize("@ss.hasPermi('user:score:add')")
    @PostMapping("/importData")
    public AjaxResult importData(MultipartFile file) throws Exception
    {
        ExcelUtil<Score> util = new ExcelUtil<>(Score.class);
        //返回文件中的所有数据
        List<Score> scoreList = util.importExcel(file.getInputStream());
        System.out.println(scoreList);
        // 数据库操作
        String message = wxScoreService.importData(scoreList);
        //返回消息
        return AjaxResult.success(message);
    }
}
