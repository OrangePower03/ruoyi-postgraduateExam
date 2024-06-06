package com.ruoyi.user.service.impl;

import java.util.List;

import com.ruoyi.common.constant.CacheConstants;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.utils.AssertUtils;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.user.domain.School;
import com.ruoyi.user.domain.minSchool;
import com.ruoyi.user.domain.vo.AnalysisResultVo;
import com.ruoyi.user.mapper.SchoolMapper;
import com.ruoyi.user.service.ISchoolService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 【请填写功能名称】Service业务层处理
 *
 * @date 2023-03-26
 */
@Slf4j
@Service
public class SchoolServiceImpl implements ISchoolService
{
    @Autowired
    private SchoolMapper wxSchoolMapper;
    @Autowired
    private RedisCache redisCache;

    /**
     * 查询【请填写功能名称】
     *
     * @param schoolId 【请填写功能名称】主键
     * @return 【请填写功能名称】
     */
    @Override
    public School selectWxSchoolBySchoolId(Long schoolId)
    {
        return wxSchoolMapper.selectWxSchoolBySchoolId(schoolId);
    }

    /**
     * 查询【请填写功能名称】列表
     *
     * @param wxSchool 【请填写功能名称】
     * @return 【请填写功能名称】
     */
    @Override
    public List<School> selectWxSchoolList(School wxSchool)
    {
        return wxSchoolMapper.selectWxSchoolList(wxSchool);
    }

    @Override
    public List<minSchool> optionWxSchoolList() {
        return wxSchoolMapper.optionWxSchoolList();
    }

    /**
     * 新增【请填写功能名称】
     *
     * @param wxSchool 【请填写功能名称】
     * @return 结果
     */
    @Override
    public int insertWxSchool(School wxSchool)
    {
        return wxSchoolMapper.insertWxSchool(wxSchool);
    }

    /**
     * 修改【请填写功能名称】
     *
     * @param wxSchool 【请填写功能名称】
     * @return 结果
     */
    @Override
    public int updateWxSchool(School wxSchool)
    {
        return wxSchoolMapper.updateWxSchool(wxSchool);
    }

    /**
     * 批量删除【请填写功能名称】
     *
     * @param schoolIds 需要删除的【请填写功能名称】主键
     * @return 结果
     */
    @Override
    public int deleteWxSchoolBySchoolIds(Long[] schoolIds)
    {
        return wxSchoolMapper.deleteWxSchoolBySchoolIds(schoolIds);
    }



    /**
     * 删除【请填写功能名称】信息
     *
     * @param schoolId 【请填写功能名称】主键
     * @return 结果
     */
    @Override
    public int deleteWxSchoolBySchoolId(Long schoolId)
    {
        return wxSchoolMapper.deleteWxSchoolBySchoolId(schoolId);
    }

//    @Override
//    public String analysis(AnalysisDto analysisDto) {
//        log.info("userId:{}", SecurityUtils.getUserId());
//        log.info("message:{}", analysisDto);
//        return QwenPlusUtils.call(analysisDto.getAnalysisDetail());
//    }

    /**
     * 从redis中获取大模型数据
     * @param schoolName 想要获取的学校
     * @return AnalysisResultVo
     *       返回分析报告，包括学校简介、学校分析
     * @throws com.ruoyi.common.exception.ServiceException
     *       如果未找到学校，也不是没查到，就是学校名错误，会返回错误
     */
    @Override
    public AnalysisResultVo analysis(String schoolName) {
        Long userId = SecurityUtils.getUserId();
        AnalysisResultVo analysisResult = redisCache.getCacheMapValue(CacheConstants.QWEN_PLUS_KEY + userId, schoolName);
        AssertUtils.nonNull(analysisResult, "正在生成中，稍等");
        return analysisResult;
    }
}
