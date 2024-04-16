package com.ruoyi.user.domain;

import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;
import lombok.Data;

/**
 * 【请填写功能名称】对象 wx_score
 *
 * @date 2023-04-02
 */
public class Score extends BaseEntity  implements Comparable<Score>
{
    private static final long serialVersionUID = 1L;

    /** 分数线编号 */
    private Long scoreId;

    /** 考试的年份 */
    @Excel(name = "考试的年份")
    private Long scoreYear;

    /** 专业编号 */
    private Long scoreMajorId;

    @Excel(name = "专业代码")
    private String majorCode;

    @Excel(name = "专业名称")
    private String majorName;

    @Excel(name = "专业类型", readConverterExp = "1=学硕,2=专硕")
    private Long majorType;

    @Excel(name = "所属学校")
    private String schoolName;
    @Excel(name = "所属院系")
    private String departmentName;

    /** 复试线 */
    @Excel(name = "复试线")
    private Long scoreAll;

    /** 英语线 */
    @Excel(name = "英语线")
    private Long scoreEnglish;

    /** 政治线 */
    @Excel(name = "政治线")
    private Long scorePolitics;

    /** 专业一 */
    @Excel(name = "专业一")
    private Long scoreMath;

    /** 专业二 */
    @Excel(name = "专业二")
    private Long scoreMajor;

    /** 表中该有的都得有*/
    private Long connectId;

    private Long schoolId;

    @Override
    public String toString() {
        return "Score{" +
                "scoreId=" + scoreId +
                ", scoreYear=" + scoreYear +
                ", scoreAll=" + scoreAll +
                ", scoreMath=" + scoreMath +
                ", scoreEnglish=" + scoreEnglish +
                ", scorePolitics=" + scorePolitics +
                ", scoreMajor=" + scoreMajor +
                ", scoreMajorId=" + scoreMajorId +
                ", majorName='" + majorName + '\'' +
                ", majorType=" + majorType +
                ", majorCode='" + majorCode + '\'' +
                ", departmentName='" + departmentName + '\'' +
                ", schoolName='" + schoolName + '\'' +
                '}';
    }

    @Override
    public int compareTo(Score other) {
        return schoolName.compareTo(other.getSchoolName());
    }

    @Override
    public boolean equals(Object other) {
        return schoolName.equals(((Score) other).getSchoolName());
    }

    public void setSchoolId(Long schoolId) {
        this.schoolId = schoolId;
    }

    public Long getSchoolId() {
        return schoolId;
    }

    public Long getScoreId() {
        return scoreId;
    }

    public void setScoreId(Long scoreId) {
        this.scoreId = scoreId;
    }

    public Long getScoreYear() {
        return scoreYear;
    }

    public void setScoreYear(Long scoreYear) {
        this.scoreYear = scoreYear;
    }

    public Long getScoreMajorId() {
        return scoreMajorId;
    }

    public void setScoreMajorId(Long scoreMajorId) {
        this.scoreMajorId = scoreMajorId;
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

    public String getSchoolName() {
        return schoolName;
    }

    public void setSchoolName(String schoolName) {
        this.schoolName = schoolName;
    }

    public String getDepartmentName() {
        return departmentName;
    }

    public void setDepartmentName(String departmentName) {
        this.departmentName = departmentName;
    }

    public Long getScoreAll() {
        return scoreAll;
    }

    public void setScoreAll(Long scoreAll) {
        this.scoreAll = scoreAll;
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

    public Long getScoreMath() {
        return scoreMath;
    }

    public void setScoreMath(Long scoreMath) {
        this.scoreMath = scoreMath;
    }

    public Long getScoreMajor() {
        return scoreMajor;
    }

    public void setScoreMajor(Long scoreMajor) {
        this.scoreMajor = scoreMajor;
    }

    public Long getConnectId() {
        return connectId;
    }

    public void setConnectId(Long connectId) {
        this.connectId = connectId;
    }
}
