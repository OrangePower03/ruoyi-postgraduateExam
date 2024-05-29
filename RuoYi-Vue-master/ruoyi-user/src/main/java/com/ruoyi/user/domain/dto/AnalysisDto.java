package com.ruoyi.user.domain.dto;

import com.ruoyi.common.utils.StringUtils;
import lombok.Data;

import java.util.List;

@Data
public class AnalysisDto {
    int score;
    String major;
    List<String> schools;

    public String getAnalysisDetail() {
        StringBuilder sb=new StringBuilder();
        sb.append("我是")
                .append(major)
                .append("专业考生，今年考研预估能考")
                .append(score)
                .append("分，我的意向院校的排名如下\n");
        for(String school : schools) {
            sb.append(school).append("、");
        }
        sb.append("\n");
//        sb.append("请您帮我分析一下它们对应的优势和您的意见");
        sb.append("麻烦您从学术研究、教学质量、人才培养、校园文化等分析一下并给出您的意见");
        return sb.toString();
    }

    public boolean verify() {
        if(StringUtils.isEmpty(major)) return false;
        return StringUtils.isNotEmpty(schools);
    }
}