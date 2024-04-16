package com.ruoyi.user.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 【请填写功能名称】对象 wx_feedback
 *
 * @date 2023-04-25
 */
public class Feedback extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 用户编号 */
    private Long userId;

    /** 满意程度 */
    @Excel(name = "满意星级")
    private Long satisfaction;

    /** 调剂情况 */
    @Excel(name = "调剂情况")
    private String action;

    /** 您的建议 */
    @Excel(name = "用户建议")
    private String suggest;

    public void setUserId(Long userId)
    {
        this.userId = userId;
    }

    public Long getUserId()
    {
        return userId;
    }
    public void setSatisfaction(Long satisfaction)
    {
        this.satisfaction = satisfaction;
    }

    public Long getSatisfaction()
    {
        return satisfaction;
    }
    public void setAction(String action)
    {
        this.action = action;
    }

    public String getAction()
    {
        return action;
    }
    public void setSuggest(String suggest)
    {
        this.suggest = suggest;
    }

    public String getSuggest()
    {
        return suggest;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
                .append("userId", getUserId())
                .append("satisfaction", getSatisfaction())
                .append("action", getAction())
                .append("suggest", getSuggest())
                .toString();
    }
}
