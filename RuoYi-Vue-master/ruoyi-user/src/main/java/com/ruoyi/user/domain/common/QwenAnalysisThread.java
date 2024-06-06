package com.ruoyi.user.domain.common;

import com.ruoyi.common.constant.CacheConstants;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.utils.spring.SpringUtils;
import com.ruoyi.user.domain.vo.AnalysisResultVo;
import com.ruoyi.user.utils.QwenPlusUtils;
import lombok.NoArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.swing.*;

/**
 * author: cq
 * 大模型询问线程类
 */
@Component
@NoArgsConstructor
public class QwenAnalysisThread implements Runnable {
    String question; // 询问大模型的问题
    Long userId;
    String schoolName;

    public QwenAnalysisThread(String question, Long userId, String schoolName) {
        this.question = question;
        this.userId = userId;
        this.schoolName = schoolName;
    }

    @Override
    public void run() {
        String answer = QwenPlusUtils.call(question);
        AnalysisResultVo analysisResult = new AnalysisResultVo(answer);
        RedisCache redisCache = SpringUtils.getBean(RedisCache.class);
        redisCache.setCacheMapValue(CacheConstants.QWEN_PLUS_KEY + userId, schoolName, analysisResult);
        redisCache.expire(CacheConstants.QWEN_PLUS_KEY + userId, CacheConstants.QWEN_PLUS_KEY_EXPIRE_TIME);
    }


}
