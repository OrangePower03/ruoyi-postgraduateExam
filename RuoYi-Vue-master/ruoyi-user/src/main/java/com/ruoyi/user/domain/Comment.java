package com.ruoyi.user.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 评论对象 wx_comment
 *
 * @author wx
 * @date 2024-01-22
 */
public class Comment extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 评论Id */
    private Long commentId;

    /** 评论内容 */
    @Excel(name = "评论内容")
    private String commentContent;

    /** 教师id */
    @Excel(name = "教师id")
    private Long teacherId;

    /** 评论时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "评论时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date commentDate;

    /** 评论人 */
    @Excel(name = "评论人")
    private String userName;

    public void setCommentId(Long commentId)
    {
        this.commentId = commentId;
    }

    public Long getCommentId()
    {
        return commentId;
    }
    public void setCommentContent(String commentContent)
    {
        this.commentContent = commentContent;
    }

    public String getCommentContent()
    {
        return commentContent;
    }
    public void setTeacherId(Long teacherId)
    {
        this.teacherId = teacherId;
    }

    public Long getTeacherId()
    {
        return teacherId;
    }
    public void setCommentDate(Date commentDate)
    {
        this.commentDate = commentDate;
    }

    public Date getCommentDate()
    {
        return commentDate;
    }

    public void setUserName(String userName)
    {
        this.userName = userName;
    }

    public String getUserName()
    {
        return userName;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
                .append("commentId", getCommentId())
                .append("commentContent", getCommentContent())
                .append("teacherId", getTeacherId())
                .append("commentDate", getCommentDate())
                .append("userName", getUserName())
                .toString();
    }
}
