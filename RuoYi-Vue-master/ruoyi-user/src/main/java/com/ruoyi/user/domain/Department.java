package com.ruoyi.user.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 【请填写功能名称】对象 wx_department
 *
 * @date 2023-03-29
 */
public class Department extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 院系编号 */
    private Long departmentId;

    /** 院系名称 */
    @Excel(name = "院系名称")
    private String departmentName;

    /** 院系所在的学校 */
    private Long departmentSchoolId;

    /** 院系所在的学校的名称 */
    @Excel(name = "所在学校")
    private String schoolName;

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
    public void setDepartmentSchoolId(Long departmentSchoolId)
    {
        this.departmentSchoolId = departmentSchoolId;
    }

    public Long getDepartmentSchoolId()
    {
        return departmentSchoolId;
    }

    public void setSchoolName(String schoolName) {
        this.schoolName = schoolName;
    }

    public String getSchoolName() {
        return schoolName;
    }

    @Override
    public String toString() {
        return "Department{" +
                "departmentId=" + departmentId +
                ", departmentName='" + departmentName + '\'' +
                ", departmentSchoolId=" + departmentSchoolId +
                ", schoolName='" + schoolName + '\'' +
                '}';
    }
}
