package com.ruoyi.user.utils;

import com.alibaba.dashscope.aigc.generation.Generation;
import com.alibaba.dashscope.aigc.generation.GenerationResult;
import com.alibaba.dashscope.aigc.generation.models.QwenParam;
import com.alibaba.dashscope.common.Message;
import com.alibaba.dashscope.common.MessageManager;
import com.alibaba.dashscope.common.Role;
import com.alibaba.dashscope.exception.InputRequiredException;
import com.alibaba.dashscope.exception.NoApiKeyException;
import com.ruoyi.common.utils.AssertUtils;
import com.ruoyi.user.domain.vo.AnalysisResultVo;

import java.util.ArrayList;
import java.util.List;

@SuppressWarnings("deprecation")
public class QwenPlusUtils {
    public static String call(String msg) {
        MessageManager msgManager = new MessageManager(10);
        Message systemMsg = Message.builder()
                .role(Role.SYSTEM.getValue())
                .content("You are a helpful assistant.")
                .build();
        Message userMsg = Message.builder()
                .role(Role.USER.getValue())
                .content(msg)
                .build();
        msgManager.add(systemMsg);
        msgManager.add(userMsg);
        QwenParam param = QwenParam.builder()
                .model(Generation.Models.QWEN_PLUS)
                .messages(msgManager.get())
                .resultFormat(QwenParam.ResultFormat.MESSAGE)
                .build();
        try {
            GenerationResult result = new Generation().call(param);
            return result.getOutput().getChoices().get(0).getMessage().getContent();
        } catch (NoApiKeyException | InputRequiredException e) {
            throw new RuntimeException(e);
        }
    }
}
