package com.ruoyi.user.utils;

import com.alibaba.dashscope.aigc.generation.Generation;
import com.alibaba.dashscope.aigc.generation.GenerationResult;
import com.alibaba.dashscope.aigc.generation.models.QwenParam;
import com.alibaba.dashscope.common.Message;
import com.alibaba.dashscope.common.MessageManager;
import com.alibaba.dashscope.common.Role;
import com.alibaba.dashscope.exception.InputRequiredException;
import com.alibaba.dashscope.exception.NoApiKeyException;

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
            return standardizing(result.getOutput().getChoices().get(0).getMessage().getContent());
        } catch (NoApiKeyException | InputRequiredException e) {
            throw new RuntimeException(e);
        }
    }

    private static String standardizing(String content) {
        String[] ss = content.split("\n");
        StringBuilder sb=new StringBuilder();
        for(int i=1;i<ss.length;i++)
            if(!"".equals(ss[i]))
                sb.append(ss[i]).append("\n");
        return sb.toString();
    }
}
