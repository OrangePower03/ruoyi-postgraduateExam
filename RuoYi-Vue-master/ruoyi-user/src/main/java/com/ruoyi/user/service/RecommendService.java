package com.ruoyi.user.service;

import com.ruoyi.common.utils.AssertUtils;
import com.ruoyi.user.domain.dto.RecommendDto;
import com.ruoyi.user.domain.vo.AnalysisResultVo;
import com.ruoyi.user.domain.vo.RecommendVo;
import reactor.util.annotation.NonNull;

import java.util.ArrayList;
import java.util.List;

/**
 * 算法接口，算法较为复杂，令起接口
 */
public interface RecommendService {
    @NonNull List<RecommendVo> recommend(RecommendDto recommendDto);

    void analyseFromAI(List<String> problems, Long userId, List<String> schoolNames);

    default List<String> createQuestions(String major, List<String> schools) {
        AssertUtils.nonNull(major, "分析问题生成中，专业不能为空");
        AssertUtils.nonEmpty(schools, "分析问题生成中，学校列表不能为空");
        List<String> questions=new ArrayList<>();
        for(String school : schools) {
            StringBuilder sb = new StringBuilder();
            sb.append("我是")
                    .append(major)
                    .append("专业考生，我的意向院校是:")
                    .append(school)
                    .append("\n");
            sb.append("麻烦您介绍一下该院校优势并从学术研究、教学质量、人才培养、校园文化等分析一下");
            questions.add(sb.toString());
        }
        return questions;
    }
}
