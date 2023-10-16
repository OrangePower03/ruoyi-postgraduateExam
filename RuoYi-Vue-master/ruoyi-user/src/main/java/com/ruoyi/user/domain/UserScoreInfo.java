package com.ruoyi.user.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 【请填写功能名称】对象 wx_user_scoreinfo
 *
 * @author ruoyi
 * @date 2023-04-26
 */
public class UserScoreInfo extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 用户编号 */
    private Long userId;

    /** 初试成绩 */
    @Excel(name = "初试成绩")
    private Long scoreAll;

    /** 初试英语 */
    @Excel(name = "初试英语")
    private Long scoreEnglish;

    /** 初始政治 */
    @Excel(name = "初始政治")
    private Long scorePolitics;

    /** 专业一 */
    @Excel(name = "专业一")
    private Long scoreMath;

    /** 专业二 */
    @Excel(name = "专业二")
    private Long scoreMajor;

    /** 专业名称 */
    @Excel(name = "专业名称")
    private String majorName;

    /** 专业类型 */
    @Excel(name = "专业类型")
    private Long majorType;

    /** 地区名称 */
    @Excel(name = "地区名称")
    private String areaName;

    public void setUserId(Long userId)
    {
        this.userId = userId;
    }

    public Long getUserId()
    {
        return userId;
    }
    public void setScoreAll(Long scoreAll)
    {
        this.scoreAll = scoreAll;
    }

    public Long getScoreAll()
    {
        return scoreAll;
    }
    public void setScoreEnglish(Long scoreEnglish)
    {
        this.scoreEnglish = scoreEnglish;
    }

    public Long getScoreEnglish()
    {
        return scoreEnglish;
    }
    public void setScorePolitics(Long scorePolitics)
    {
        this.scorePolitics = scorePolitics;
    }

    public Long getScorePolitics()
    {
        return scorePolitics;
    }
    public void setScoreMath(Long scoreMath)
    {
        this.scoreMath = scoreMath;
    }

    public Long getScoreMath()
    {
        return scoreMath;
    }
    public void setScoreMajor(Long scoreMajor)
    {
        this.scoreMajor = scoreMajor;
    }

    public Long getScoreMajor()
    {
        return scoreMajor;
    }
    public void setMajorName(String majorName)
    {
        this.majorName = majorName;
    }

    public String getMajorName()
    {
        return majorName;
    }
    public void setMajorType(Long majorType)
    {
        this.majorType = majorType;
    }

    public Long getMajorType()
    {
        return majorType;
    }
    public void setAreaName(String areaName)
    {
        this.areaName = areaName;
    }

    public String getAreaName()
    {
        return areaName;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
                .append("userId", getUserId())
                .append("scoreAll", getScoreAll())
                .append("scoreEnglish", getScoreEnglish())
                .append("scorePolitics", getScorePolitics())
                .append("scoreMath", getScoreMath())
                .append("scoreMajor", getScoreMajor())
                .append("majorName", getMajorName())
                .append("majorType", getMajorType())
                .append("areaName", getAreaName())
                .toString();
    }
}
