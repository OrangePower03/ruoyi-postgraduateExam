package com.ruoyi.user.mapper;

import java.util.List;
import com.ruoyi.user.domain.School;
import com.ruoyi.user.domain.minSchool;
import org.apache.ibatis.annotations.Param;

/**
 * 【请填写功能名称】Mapper接口
 *
 * @date 2023-03-26
 */
public interface SchoolMapper
{
    public int findAreaTypeBySchoolName(String schoolName);
    /**
     * 查询【请填写功能名称】
     *
     * @param schoolId 【请填写功能名称】主键
     * @return 【请填写功能名称】
     */
    public School selectWxSchoolBySchoolId(Long schoolId);

    /**
     * 查询数据列表
     *
     * @param wxSchool 【请填写功能名称】
     * @return 【请填写功能名称】集合
     */
    public List<School> selectWxSchoolList(School wxSchool);

    /**
     * 查询下拉框列表
     *
     * @return 【请填写功能名称】集合
     */
    public List<minSchool> optionWxSchoolList();

    /**
     * 新增【请填写功能名称】
     *
     * @param wxSchool 【请填写功能名称】
     * @return 结果
     */
    public int insertWxSchool(School wxSchool);

    /**
     * 修改【请填写功能名称】
     *
     * @param wxSchool 【请填写功能名称】
     * @return 结果
     */
    public int updateWxSchool(School wxSchool);

    /**
     * 删除【请填写功能名称】
     *
     * @param schoolId 【请填写功能名称】主键
     * @return 结果
     */
    public int deleteWxSchoolBySchoolId(Long schoolId);

    /**
     * 批量删除【请填写功能名称】
     *
     * @param schoolIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteWxSchoolBySchoolIds(Long[] schoolIds);

    public float selectQSBySchoolName(String schoolName);

    public float selectRKBySchoolName(String schoolName);

    public int selectAreaIdBySchoolName(String schoolName);

    String getSchoolNameById(Long schoolId);

    List<String> getSchoolNameByIds(@Param("schoolIds") List<Long> schoolIds);
}
