package com.ruoyi.user.domain.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AnalysisResultVo implements Serializable {

    private static final long serialVersionUID = 115616851354L;

    // 分析结果
    String intro;
    String analysis;

    public AnalysisResultVo(String result) {
        int last = result.lastIndexOf("\n");
        intro = result.substring(0, last);
        analysis = result.substring(last);
    }
}
