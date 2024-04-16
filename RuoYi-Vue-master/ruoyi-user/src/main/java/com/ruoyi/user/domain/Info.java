package com.ruoyi.user.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 招生信息对象 wx_info
 *
 * @date 2024-02-17
 */
public class Info extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 信息id */
    private Long infoId;

    /** 信息标题 */
    @Excel(name = "信息标题")
    private String infoTitle;

    /** 信息链接 */
    @Excel(name = "信息链接")
    private String infoLink;

    /** 信息日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "信息日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date infoDate;

    @Excel(name = "信息类型")
    private Long infoType;

    /** 学校id */
    @Excel(name = "学校id")
    private Long schoolId;

    /** 学校名称 */
    @Excel(name = "学校名称")
    private String schoolName;


    public void setInfoId(Long infoId)
    {
        this.infoId = infoId;
    }

    public Long getInfoId()
    {
        return infoId;
    }
    public void setInfoTitle(String infoTitle)
    {
        this.infoTitle = infoTitle;
    }

    public String getInfoTitle()
    {
        return infoTitle;
    }
    public void setInfoLink(String infoLink)
    {
        this.infoLink = infoLink;
    }

    public String getInfoLink()
    {
        return infoLink;
    }
    public void setInfoDate(Date infoDate)
    {
        this.infoDate = infoDate;
    }

    public Date getInfoDate()
    {
        return infoDate;
    }
    public void setSchoolId(Long schoolId)
    {
        this.schoolId = schoolId;
    }

    public Long getSchoolId()
    {
        return schoolId;
    }

    public void setSchoolName(String schoolName) {
        this.schoolName = schoolName;
    }

    public String getSchoolName() {
        return schoolName;
    }

    public void setInfoType(Long infoType) {
        this.infoType = infoType;
    }

    public Long getInfoType() {
        return infoType;
    }

    @Override
    public String toString() {
        return "Info{" +
                "infoId=" + infoId +
                ", infoTitle='" + infoTitle + '\'' +
                ", infoLink='" + infoLink + '\'' +
                ", infoDate=" + infoDate +
                ", infoType=" + infoType +
                ", schoolId=" + schoolId +
                ", schoolName='" + schoolName + '\'' +
                '}';
    }
}
