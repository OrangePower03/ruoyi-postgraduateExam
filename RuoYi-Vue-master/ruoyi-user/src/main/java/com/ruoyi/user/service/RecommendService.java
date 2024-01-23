package com.ruoyi.user.service;

import com.ruoyi.user.domain.DScore;
import com.ruoyi.user.domain.common.ScoreCommon;
import com.ruoyi.user.domain.dto.RecommendDto;
import com.ruoyi.user.domain.vo.RecommendVo;
import com.ruoyi.user.domain.vo.SchoolWithScoreVo;

import java.util.List;

/**
 * 算法接口，算法较为复杂，令起接口
 */
public interface RecommendService {
    List<RecommendVo> recommend(RecommendDto recommendDto);

    void WV(List<SchoolWithScoreVo> schools);

    void verify(RecommendDto recommendDto);

    void normalizeAlgorithm(List<SchoolWithScoreVo> schools);

    void DV(RecommendDto recommendDto, List<SchoolWithScoreVo> schools);

    void FWV(RecommendDto recommendDto, List<SchoolWithScoreVo> schools);

    List<SchoolWithScoreVo> getAllFloatSchool(RecommendDto recommendDto, boolean isOverA);

    String compareCountryScore(RecommendDto recommendDto);

    ScoreCommon getAreaTypeAverageScore(List<DScore> dScores, Long areaType);

    boolean doCompareCountryScore(RecommendDto recommendDto, ScoreCommon areaAAverageScore);

    List<RecommendVo> packaging(List<SchoolWithScoreVo> schools);

    void compressAlgorithm(List<SchoolWithScoreVo> schools, boolean areaIsSame);
}
