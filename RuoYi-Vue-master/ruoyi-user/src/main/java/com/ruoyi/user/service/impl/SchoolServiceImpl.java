package com.ruoyi.user.service.impl;

import java.util.List;

import com.ruoyi.user.domain.School;
import com.ruoyi.user.domain.minSchool;
import com.ruoyi.user.mapper.SchoolMapper;
import com.ruoyi.user.service.ISchoolService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 【请填写功能名称】Service业务层处理
 *
 * @date 2023-03-26
 */
@Service
public class SchoolServiceImpl implements ISchoolService
{
    @Autowired
    private SchoolMapper wxSchoolMapper;

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
}
