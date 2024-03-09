package com.ruoyi.user.domain.dto;

import com.ruoyi.user.domain.common.ScoreCommon;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = true)
public class RecommendDto extends ScoreCommon {
    String majorName;
    String area;
}
