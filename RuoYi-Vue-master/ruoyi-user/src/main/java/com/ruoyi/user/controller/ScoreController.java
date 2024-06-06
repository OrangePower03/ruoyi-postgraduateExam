package com.ruoyi.user.controller;

import java.util.List;
import java.util.stream.Collectors;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.user.domain.AllInfo;
import com.ruoyi.user.domain.Score;
import com.ruoyi.user.domain.dto.RecommendDto;
import com.ruoyi.user.domain.vo.RecommendVo;
import com.ruoyi.user.service.IScoreService;
import com.ruoyi.user.service.RecommendService;
import com.ruoyi.user.utils.QwenPlusUtils;
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
 * 复试线Controller
 *
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
     * 查询复试线列表
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
     * 查询复试线列表
     */
    @PreAuthorize("@ss.hasPermi('user:score:list')")
    @GetMapping("/AllInfoList")
    public TableDataInfo AllInfoList(AllInfo allInfo)
    {
        List<AllInfo> list = wxScoreService.selectAllInfoList(allInfo);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('user:score:list')")
    @GetMapping("/recommend")
    public TableDataInfo recommend(RecommendDto recommendDto) {
        List<RecommendVo>list = recommendService.recommend(recommendDto);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('user:score:list')")
    @GetMapping("/user/score")
    public AjaxResult getScore()
    {
        return success(wxScoreService.getScore());
    }

    /**
     * 查询近三年复试线
     */
    @PreAuthorize("@ss.hasPermi('user:score:list')")
    @GetMapping("/ThreeRetestLine")
    public TableDataInfo selectThreeRetestLine(Score score)
    {
        List<Score> list = wxScoreService.selectThreeRetestLine(score);
        return getDataTable(list);
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
     * 获取复试线详细信息
     */
    @PreAuthorize("@ss.hasPermi('user:score:query')")
    @GetMapping(value = "/{scoreId}")
    public AjaxResult getInfo(@PathVariable("scoreId") Long scoreId)
    {
        return success(wxScoreService.selectWxScoreByScoreId(scoreId));
    }

    /**
     * 新增复试线信息
     */
    @PreAuthorize("@ss.hasPermi('user:score:add')")
    @Log(title = "新增复试线信息", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Score wxScore)
    {
        return toAjax(wxScoreService.insertWxScore(wxScore));
    }

    /**
     * 修改复试线信息
     */
    @PreAuthorize("@ss.hasPermi('user:score:edit')")
    @Log(title = "修改复试线信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Score wxScore)
    {
        return toAjax(wxScoreService.updateWxScore(wxScore));
    }

    /**
     * 删除复试线信息
     */
    @PreAuthorize("@ss.hasPermi('user:score:remove')")
    @Log(title = "删除复试线信息", businessType = BusinessType.DELETE)
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
//        System.out.println(scoreList);
        // 数据库操作
        String message = wxScoreService.importData(scoreList);
        //返回消息
        return AjaxResult.success(message);
    }
}
