package com.ruoyi.user.domain;

import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

public class AllInfo  extends BaseEntity {
    /** 考试年份*/
    @Excel(name = "考试年份")
    private Long scoreYear;

    /** 复试线 */
    @Excel(name = "复试线")
    private Long scoreAll;

    /** 数学线 */
    @Excel(name = "数学线")
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

    /** 专业代码 */
    @Excel(name = "专业代码")
    private String majorCode;

    /** 专业名称 */
    @Excel(name = "专业名称")
    private String majorName;

    /** 专业类型（学硕、专硕） */
    @Excel(name = "专业类型", readConverterExp = "1=学硕,2=专硕")
    private Long majorType;

    /** 院系名称 */
    @Excel(name = "院系名称")
    private String departmentName;

    /** 学校名称 */
    @Excel(name = "学校名称")
    private String schoolName;

    /** 是否为34所自划线 */
    @Excel(name = "是否为34所自划线", readConverterExp = "1=是,2=否")
    private Long schoolType;

    /** 学校层次 */
    @Excel(name = "学校层次")
    private Long schoolLevels;

    @Excel(name = "学校官网")
    protected String schoolWebsite;

    @Excel(name = "学校官研招网")
    private String schoolRecruit;

    /** 地区名称 */
    @Excel(name = "地区名称")
    private String areaName;

    /** 地区类型（1.A区、2.B区） */
    @Excel(name = "地区类型", readConverterExp = "1=A区,2=B区")
    private Long areaType;

    public Long getScoreYear() {
        return scoreYear;
    }

    public void setScoreYear(Long scoreYear) {
        this.scoreYear = scoreYear;
    }

    public Long getScoreAll() {
        return scoreAll;
    }

    public void setScoreAll(Long scoreAll) {
        this.scoreAll = scoreAll;
    }

    public Long getScoreMath() {
        return scoreMath;
    }

    public void setScoreMath(Long scoreMath) {
        this.scoreMath = scoreMath;
    }

    public Long getScoreEnglish() {
        return scoreEnglish;
    }

    public void setScoreEnglish(Long scoreEnglish) {
        this.scoreEnglish = scoreEnglish;
    }

    public Long getScorePolitics() {
        return scorePolitics;
    }

    public void setScorePolitics(Long scorePolitics) {
        this.scorePolitics = scorePolitics;
    }

    public Long getScoreMajor() {
        return scoreMajor;
    }

    public void setScoreMajor(Long scoreMajor) {
        this.scoreMajor = scoreMajor;
    }

    public String getMajorCode() {
        return majorCode;
    }

    public void setMajorCode(String majorCode) {
        this.majorCode = majorCode;
    }

    public String getMajorName() {
        return majorName;
    }

    public void setMajorName(String majorName) {
        this.majorName = majorName;
    }

    public Long getMajorType() {
        return majorType;
    }

    public void setMajorType(Long majorType) {
        this.majorType = majorType;
    }

    public String getDepartmentName() {
        return departmentName;
    }

    public void setDepartmentName(String departmentName) {
        this.departmentName = departmentName;
    }

    public String getSchoolName() {
        return schoolName;
    }

    public void setSchoolName(String schoolName) {
        this.schoolName = schoolName;
    }

    public Long getSchoolType() {
        return schoolType;
    }

    public void setSchoolType(Long schoolType) {
        this.schoolType = schoolType;
    }

    public Long getSchoolLevels() {
        return schoolLevels;
    }

    public void setSchoolLevels(Long schoolLevels) {
        this.schoolLevels = schoolLevels;
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

    public String getAreaName() {
        return areaName;
    }

    public void setAreaName(String areaName) {
        this.areaName = areaName;
    }

    public Long getAreaType() {
        return areaType;
    }

    public void setAreaType(Long areaType) {
        this.areaType = areaType;
    }

    @Override
    public String toString() {
        return "AllInfo{" +
                "scoreYear=" + scoreYear +
                ", scoreAll=" + scoreAll +
                ", scoreMath=" + scoreMath +
                ", scoreEnglish=" + scoreEnglish +
                ", scorePolitics=" + scorePolitics +
                ", scoreMajor=" + scoreMajor +
                ", majorCode='" + majorCode + '\'' +
                ", majorName='" + majorName + '\'' +
                ", majorType=" + majorType +
                ", departmentName='" + departmentName + '\'' +
                ", schoolName='" + schoolName + '\'' +
                ", schoolType=" + schoolType +
                ", schoolLevels=" + schoolLevels +
                ", schoolWebsite='" + schoolWebsite + '\'' +
                ", schoolRecruit='" + schoolRecruit + '\'' +
                ", areaName='" + areaName + '\'' +
                ", areaType=" + areaType +
                '}';
    }
}
