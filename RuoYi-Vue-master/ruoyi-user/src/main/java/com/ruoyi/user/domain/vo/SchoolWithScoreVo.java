package com.ruoyi.user.domain.vo;

import com.ruoyi.user.domain.School;
import com.ruoyi.user.domain.common.ScoreCommon;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 伴随着平均复试线的学校vo
 * 被继承只是简单的增加属性
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class SchoolWithScoreVo extends ScoreCommon implements Comparable<SchoolWithScoreVo>{
    School school=new School();

    Float QS;
    Float RK;
    Float area;

    Float fwv;
    Float dv;
    Float unhandledPower;
    Float handledPower;

    @Override
    public int compareTo(SchoolWithScoreVo other) {
        return (other.unhandledPower > this.unhandledPower) ? 1 : -1;
    }
}
