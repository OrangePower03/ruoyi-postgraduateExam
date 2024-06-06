package com.ruoyi.user.domain.dto;

import com.ruoyi.common.utils.StringUtils;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Data
@Deprecated
public class AnalysisBody {
    String major;
    List<String> schools;

    public List<String> getAnalysisDetail() {
        List<String> problems=new ArrayList<>();
        for(String school : schools) {
            StringBuilder sb = new StringBuilder();
            //                .append("专业考生，今年考研预估能考")
            //                .append(score)
            //                .append("分，我的意向院校的排名如下\n");
            sb.append("我是")
                    .append(major)
                    .append("专业考生，我的意向院校是:")
                    .append(school)
                    .append("\n");
            sb.append("麻烦您介绍一下该院校优势并从学术研究、教学质量、人才培养、校园文化等分析一下");
            problems.add(sb.toString());
        }
        return problems;
    }

    public boolean verify() {
        if(StringUtils.isEmpty(major)) return false;
        return StringUtils.isNotEmpty(schools);
    }
}