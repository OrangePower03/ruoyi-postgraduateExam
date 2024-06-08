package com.ruoyi.common.core.domain.model;

/**
 * 用户注册对象
 */
public class RegisterBody extends LoginBody
{
    Long userId;

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }
}
