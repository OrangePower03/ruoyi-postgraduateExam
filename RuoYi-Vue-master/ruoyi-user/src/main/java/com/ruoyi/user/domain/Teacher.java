package com.ruoyi.user.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 导师表对象 wx_teacher
 *
 * @author wx
 * @date 2024-01-20
 */
public class Teacher extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 导师主键 */
    private Long teacherId;

    /** 导师姓名 */
    @Excel(name = "导师姓名")
    private String teacherName;

    /** 研究方向 */
    @Excel(name = "研究方向")
    private String teacherDirection;

    /** 导师职称 */
    @Excel(name = "导师职称")
    private Long teacherPosition;

    /** 导师图片地址 */
    @Excel(name = "导师图片地址")
    private String teacherImage;

    /** 导师信息链接 */
    @Excel(name = "导师信息链接")
    private String teacherLink;

    /** 所在学院 */
    @Excel(name = "所在学院Id")
    private Long departmentId;

    @Excel(name = "所在学校")
    private String schoolName;

    @Excel(name = "所在学院")
    private String departmentName;

    public void setTeacherId(Long teacherId)
    {
        this.teacherId = teacherId;
    }

    public Long getTeacherId()
    {
        return teacherId;
    }
    public void setTeacherName(String teacherName)
    {
        this.teacherName = teacherName;
    }

    public String getTeacherName()
    {
        return teacherName;
    }
    public void setTeacherDirection(String teacherDirection)
    {
        this.teacherDirection = teacherDirection;
    }

    public String getTeacherDirection()
    {
        return teacherDirection;
    }
    public void setTeacherPosition(Long teacherPosition)
    {
        this.teacherPosition = teacherPosition;
    }

    public Long getTeacherPosition()
    {
        return teacherPosition;
    }
    public void setTeacherImage(String teacherImage)
    {
        this.teacherImage = teacherImage;
    }

    public String getTeacherImage()
    {
        return teacherImage;
    }
    public void setTeacherLink(String teacherLink)
    {
        this.teacherLink = teacherLink;
    }

    public String getTeacherLink()
    {
        return teacherLink;
    }
    public void setDepartmentId(Long departmentId)
    {
        this.departmentId = departmentId;
    }

    public Long getDepartmentId()
    {
        return departmentId;
    }

    public void setDepartmentName(String departmentName)
    {
        this.departmentName = departmentName;
    }

    public String getDepartmentName()
    {
        return departmentName;
    }

    public void setSchoolName(String schoolName)
    {
        this.schoolName = schoolName;
    }

    public String getSchoolName()
    {
        return schoolName;
    }

    @Override
    public String toString() {
        return "Teacher{" +
                "teacherId=" + teacherId +
                ", teacherName='" + teacherName + '\'' +
                ", teacherDirection='" + teacherDirection + '\'' +
                ", teacherPosition=" + teacherPosition +
                ", teacherImage='" + teacherImage + '\'' +
                ", teacherLink='" + teacherLink + '\'' +
                ", departmentId=" + departmentId +
                ", schoolName='" + schoolName + '\'' +
                ", departmentName='" + departmentName + '\'' +
                '}';
    }
}
