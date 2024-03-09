package com.ruoyi.user.mapper;

import java.util.List;
import com.ruoyi.user.domain.Teacher;

/**
 * 导师表Mapper接口
 *
 * @author wx
 * @date 2024-01-20
 */
public interface TeacherMapper
{
    /**
     * 查询导师表
     *
     * @param teacherId 导师表主键
     * @return 导师表
     */
    public Teacher selectTeacherByTeacherId(Long teacherId);

    /**
     * 查询导师表列表
     *
     * @param teacher 导师表
     * @return 导师表集合
     */
    public List<Teacher> selectTeacherList(Teacher teacher);

    /**
     * 新增导师表
     *
     * @param teacher 导师表
     * @return 结果
     */
    public int insertTeacher(Teacher teacher);

    /**
     * 修改导师表
     *
     * @param teacher 导师表
     * @return 结果
     */
    public int updateTeacher(Teacher teacher);

    /**
     * 删除导师表
     *
     * @param teacherId 导师表主键
     * @return 结果
     */
    public int deleteTeacherByTeacherId(Long teacherId);

    /**
     * 批量删除导师表
     *
     * @param teacherIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteTeacherByTeacherIds(Long[] teacherIds);
}
