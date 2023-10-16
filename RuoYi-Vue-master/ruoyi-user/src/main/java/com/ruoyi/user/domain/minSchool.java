package com.ruoyi.user.domain;

import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

public class minSchool extends BaseEntity {
    /** 学校的编号 */
    private Long schoolId;

    /** 学校的名字 */
    @Excel(name = "学校的名字")
    private String schoolName;

    public void setSchoolId(Long schoolId) {
        this.schoolId = schoolId;
    }

    public void setSchoolName(String schoolName) {
        this.schoolName = schoolName;
    }

    public Long getSchoolId() {
        return schoolId;
    }

    public String getSchoolName() {
        return schoolName;
    }

    @Override
    public String toString() {
        return "minSchool{" +
                "schoolId=" + schoolId +
                ", schoolName='" + schoolName + '\'' +
                '}';
    }
}
