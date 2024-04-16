package com.ruoyi.user.domain;

import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 【请填写功能名称】对象 wx_school
 *
 * @date 2023-03-26
 */
public class School extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 学校的编号 */
    private Long schoolId;

    /** 学校的名字 */
    @Excel(name = "学校名称")
    private String schoolName;

    /** 学校所在地区 */
    private Long schoolArea;
    @Excel(name = "所在地区")
    private String areaName;

    /** 是否为34所自划线 */
    @Excel(name = "是否为34所自划线", readConverterExp = "1=是,2=否")
    private Long schoolType;

    /** 学校层次 */
    @Excel(name = "是否为34所自划线", readConverterExp = "1=985、211、双一流,2=211、双一流,3=211,4=双一流,5=普通院校")
    private Long schoolLevels;

    private String schoolWebsite;
    private String schoolRecruit;

    private Long areaType;

    public void setSchoolId(Long schoolId)
    {
        this.schoolId = schoolId;
    }

    public Long getSchoolId()
    {
        return schoolId;
    }
    public void setSchoolName(String schoolName)
    {
        this.schoolName = schoolName;
    }

    public String getSchoolName()
    {
        return schoolName;
    }
    public void setSchoolArea(Long schoolArea)
    {
        this.schoolArea = schoolArea;
    }

    public Long getSchoolArea()
    {
        return schoolArea;
    }

    public void setAreaName(String areaName) {
        this.areaName = areaName;
    }

    public String getAreaName() {
        return areaName;
    }

    public void setSchoolType(Long schoolType)
    {
        this.schoolType = schoolType;
    }

    public Long getSchoolType()
    {
        return schoolType;
    }
    public void setSchoolLevels(Long schoolLevels)
    {
        this.schoolLevels = schoolLevels;
    }

    public Long getSchoolLevels()
    {
        return schoolLevels;
    }

    public void setSchoolWebsite(String schoolWebsite) {
        this.schoolWebsite = schoolWebsite;
    }

    public String getSchoolWebsite() {
        return schoolWebsite;
    }

    public void setSchoolRecruit(String schoolRecruit) {
        this.schoolRecruit = schoolRecruit;
    }

    public String getSchoolRecruit() {
        return schoolRecruit;
    }

    public void setAreaType(Long areaType) {
        this.areaType = areaType;
    }

    public Long getAreaType() {
        return areaType;
    }

    @Override
    public String toString() {
        return "School{" +
                "schoolId=" + schoolId +
                ", schoolName='" + schoolName + '\'' +
                ", schoolArea=" + schoolArea +
                ", areaName='" + areaName + '\'' +
                ", schoolType=" + schoolType +
                ", schoolLevels=" + schoolLevels +
                ", schoolWebsite='" + schoolWebsite + '\'' +
                ", schoolRecruit='" + schoolRecruit + '\'' +
                ", areaType=" + areaType +
                '}';
    }
}
