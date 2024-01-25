package com.ruoyi.user.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.user.mapper.TeacherMapper;
import com.ruoyi.user.domain.Teacher;
import com.ruoyi.user.service.ITeacherService;

/**
 * 导师表Service业务层处理
 *
 * @author wx
 * @date 2024-01-20
 */
@Service
public class TeacherServiceImpl implements ITeacherService
{
    @Autowired
    private TeacherMapper teacherMapper;

    /**
     * 查询导师表
     *
     * @param teacherId 导师表主键
     * @return 导师表
     */
    @Override
    public Teacher selectTeacherByTeacherId(Long teacherId)
    {
        return teacherMapper.selectTeacherByTeacherId(teacherId);
    }

    /**
     * 查询导师表列表
     *
     * @param teacher 导师表
     * @return 导师表
     */
    @Override
    public List<Teacher> selectTeacherList(Teacher teacher)
    {
        return teacherMapper.selectTeacherList(teacher);
    }

    /**
     * 新增导师表
     *
     * @param teacher 导师表
     * @return 结果
     */
    @Override
    public int insertTeacher(Teacher teacher)
    {
        return teacherMapper.insertTeacher(teacher);
    }

    /**
     * 修改导师表
     *
     * @param teacher 导师表
     * @return 结果
     */
    @Override
    public int updateTeacher(Teacher teacher)
    {
        return teacherMapper.updateTeacher(teacher);
    }

    /**
     * 批量删除导师表
     *
     * @param teacherIds 需要删除的导师表主键
     * @return 结果
     */
    @Override
    public int deleteTeacherByTeacherIds(Long[] teacherIds)
    {
        return teacherMapper.deleteTeacherByTeacherIds(teacherIds);
    }

    /**
     * 删除导师表信息
     *
     * @param teacherId 导师表主键
     * @return 结果
     */
    @Override
    public int deleteTeacherByTeacherId(Long teacherId)
    {
        return teacherMapper.deleteTeacherByTeacherId(teacherId);
    }
}
