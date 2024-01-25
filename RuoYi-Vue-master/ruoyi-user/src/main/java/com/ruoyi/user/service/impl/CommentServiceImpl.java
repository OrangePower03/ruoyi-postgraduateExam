package com.ruoyi.user.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.user.mapper.CommentMapper;
import com.ruoyi.user.domain.Comment;
import com.ruoyi.user.service.ICommentService;

/**
 * 评论Service业务层处理
 *
 * @author wx
 * @date 2024-01-22
 */
@Service
public class CommentServiceImpl implements ICommentService
{
    @Autowired
    private CommentMapper commentMapper;

    /**
     * 查询评论
     *
     * @param commentId 评论主键
     * @return 评论
     */
    @Override
    public Comment selectCommentByCommentId(Long commentId)
    {
        return commentMapper.selectCommentByCommentId(commentId);
    }

    /**
     * 查询评论列表
     *
     * @param comment 评论
     * @return 评论
     */
    @Override
    public List<Comment> selectCommentList(Comment comment)
    {
        return commentMapper.selectCommentList(comment);
    }

    /**
     * 新增评论
     *
     * @param comment 评论
     * @return 结果
     */
    @Override
    public int insertComment(Comment comment)
    {
        return commentMapper.insertComment(comment);
    }

    /**
     * 修改评论
     *
     * @param comment 评论
     * @return 结果
     */
    @Override
    public int updateComment(Comment comment)
    {
        return commentMapper.updateComment(comment);
    }

    /**
     * 批量删除评论
     *
     * @param commentIds 需要删除的评论主键
     * @return 结果
     */
    @Override
    public int deleteCommentByCommentIds(Long[] commentIds)
    {
        return commentMapper.deleteCommentByCommentIds(commentIds);
    }

    /**
     * 删除评论信息
     *
     * @param commentId 评论主键
     * @return 结果
     */
    @Override
    public int deleteCommentByCommentId(Long commentId)
    {
        return commentMapper.deleteCommentByCommentId(commentId);
    }
}
