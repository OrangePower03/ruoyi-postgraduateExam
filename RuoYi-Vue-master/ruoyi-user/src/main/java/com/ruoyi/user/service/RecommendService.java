package com.ruoyi.user.service;

import com.ruoyi.user.domain.dto.RecommendDto;
import com.ruoyi.user.domain.vo.RecommendVo;

import java.util.List;

/**
 * 算法接口，算法较为复杂，令起接口
 */
public interface RecommendService {
    List<RecommendVo> recommend(RecommendDto recommendDto);
}
