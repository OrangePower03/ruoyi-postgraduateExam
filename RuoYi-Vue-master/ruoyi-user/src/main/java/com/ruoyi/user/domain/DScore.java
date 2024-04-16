package com.ruoyi.user.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 【请填写功能名称】对象 wx_dscore
 *
 * @date 2023-04-23
 */
public class DScore extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 分数编号 */
    private Long scoreId;

    /** 考研年份 */
    @Excel(name = "考研年份")
    private Long scoreYear;

    /** 复试线 */
    @Excel(name = "复试线")
    private Long scoreAll;

    /** 专业一 */
    @Excel(name = "专业一")
    private Long scoreMath;

    /** 英语线 */
    @Excel(name = "英语线")
    private Long scoreEnglish;

    /** 政治线 */
    @Excel(name = "政治线")
    private Long scorePolitics;

    /** 专业线 */
    @Excel(name = "专业线")
    private Long scoreMajor;

    /** 专业编号 */
    @Excel(name = "专业编号")
    private Long majorId;

    @Excel(name = "专业编号")
    private String majorName;

    /** 地区类型 */
    @Excel(name = "地区类型", readConverterExp = "1=A区,2=B区")
    private Long areaType;

    public void setScoreId(Long scoreId)
    {
        this.scoreId = scoreId;
    }

    public Long getScoreId()
    {
        return scoreId;
    }
    public void setScoreYear(Long scoreYear)
    {
        this.scoreYear = scoreYear;
    }

    public Long getScoreYear()
    {
        return scoreYear;
    }
    public void setScoreAll(Long scoreAll)
    {
        this.scoreAll = scoreAll;
    }

    public Long getScoreAll()
    {
        return scoreAll;
    }
    public void setScoreMath(Long scoreMath)
    {
        this.scoreMath = scoreMath;
    }

    public Long getScoreMath()
    {
        return scoreMath;
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
    public void setScoreMajor(Long scoreMajor)
    {
        this.scoreMajor = scoreMajor;
    }

    public Long getScoreMajor()
    {
        return scoreMajor;
    }
    public void setMajorId(Long majorId)
    {
        this.majorId = majorId;
    }

    public Long getMajorId()
    {
        return majorId;
    }
    public void setAreaType(Long areaType)
    {
        this.areaType = areaType;
    }

    public Long getAreaType()
    {
        return areaType;
    }

    public void setMajorName(String majorName) {
        this.majorName = majorName;
    }

    public String getMajorName() {
        return majorName;
    }

    @Override
    public String toString() {
        return "DScore{" +
                "scoreId=" + scoreId +
                ", scoreYear=" + scoreYear +
                ", scoreAll=" + scoreAll +
                ", scoreMath=" + scoreMath +
                ", scoreEnglish=" + scoreEnglish +
                ", scorePolitics=" + scorePolitics +
                ", scoreMajor=" + scoreMajor +
                ", majorId=" + majorId +
                ", areaType=" + areaType +
                ", majorName='" + majorName + '\'' +
                '}';
    }
}
