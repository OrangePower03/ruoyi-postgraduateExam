package com.ruoyi.user.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 【请填写功能名称】对象 wx_major
 *
 * @date 2023-04-01
 */
public class Major extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 专业代码 */
    private Long majorId;

    /** 专业代码 */
    private String majorCode;

    /** 专业名称 */
    @Excel(name = "专业名称")
    private String majorName;

    /** 专业所在院 */
    private Long majorDepartmentId;

    /** 专业所在院的名称 */
    @Excel(name = "院系名称")
    private String majorDepartmentName;

    private Long schoolId;

    @Excel(name = "学校名称")
    private String majorSchoolName;

    private Long connectId;

    /** 专业类型（学硕、专硕） */
    @Excel(name = "专业类型", readConverterExp = "1=学硕,2=专硕")
    private Long majorType;

    public void setMajorId(Long majorId)
    {
        this.majorId = majorId;
    }

    public Long getMajorId()
    {
        return majorId;
    }

    public void setMajorCode(String majorCode) {
        this.majorCode = majorCode;
    }

    public String getMajorCode() {
        return majorCode;
    }

    public void setMajorName(String majorName)
    {
        this.majorName = majorName;
    }

    public String getMajorName()
    {
        return majorName;
    }
    public void setMajorDepartmentId(Long majorDepartmentId)
    {
        this.majorDepartmentId = majorDepartmentId;
    }

    public Long getMajorDepartmentId()
    {
        return majorDepartmentId;
    }

    public void setMajorDepartmentName(String majorDepartmentName) {
        this.majorDepartmentName = majorDepartmentName;
    }

    public String getMajorDepartmentName() {
        return majorDepartmentName;
    }

    public void setMajorType(Long majorType)
    {
        this.majorType = majorType;
    }

    public Long getMajorType()
    {
        return majorType;
    }

    public void setMajorSchoolName(String majorSchoolName) {
        this.majorSchoolName = majorSchoolName;
    }

    public String getMajorSchoolName() {
        return majorSchoolName;
    }

    public void setConnectId(Long connectId) {
        this.connectId = connectId;
    }

    public Long getConnectId() {
        return connectId;
    }

    public void setSchoolId(Long schoolId) {
        this.schoolId = schoolId;
    }

    public Long getSchoolId() {
        return schoolId;
    }

    @Override
    public String toString() {
        return "Major{" +
                "majorId=" + majorId +
                ", majorCode='" + majorCode + '\'' +
                ", majorName='" + majorName + '\'' +
                ", majorDepartmentId=" + majorDepartmentId +
                ", majorDepartmentName='" + majorDepartmentName + '\'' +
                ", schoolId=" + schoolId +
                ", majorSchoolName='" + majorSchoolName + '\'' +
                ", connectId=" + connectId +
                ", majorType=" + majorType +
                '}';
    }
}
