package com.ruoyi.user.domain.vo;

import com.ruoyi.user.domain.common.ScoreCommon;
import lombok.Data;

@Data
public class RecommendVo {
    String schoolName;

    ScoreCommon averageScore;

    Float handledPower;
}
