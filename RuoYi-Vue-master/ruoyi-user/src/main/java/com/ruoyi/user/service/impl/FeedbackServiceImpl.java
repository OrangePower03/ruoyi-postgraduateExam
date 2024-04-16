package com.ruoyi.user.service.impl;

import com.ruoyi.user.domain.Feedback;
import com.ruoyi.user.mapper.FeedbackMapper;
import com.ruoyi.user.service.IFeedbackService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 【请填写功能名称】Service业务层处理
 *
 * @date 2023-04-25
 */
@Service
public class FeedbackServiceImpl implements IFeedbackService
{
    @Autowired
    private FeedbackMapper wxFeedbackMapper;

    /**
     * 查询【请填写功能名称】
     *
     * @param userId 【请填写功能名称】主键
     * @return 【请填写功能名称】
     */
    @Override
    public Feedback selectWxFeedbackByUserId(Long userId)
    {
        return wxFeedbackMapper.selectWxFeedbackByUserId(userId);
    }

    /**
     * 查询【请填写功能名称】列表
     *
     * @param wxFeedback 【请填写功能名称】
     * @return 【请填写功能名称】
     */
    @Override
    public List<Feedback> selectWxFeedbackList(Feedback wxFeedback)
    {
        return wxFeedbackMapper.selectWxFeedbackList(wxFeedback);
    }

    /**
     * 新增【请填写功能名称】
     *
     * @param wxFeedback 【请填写功能名称】
     * @return 结果
     */
    @Override
    public int insertWxFeedback(Feedback wxFeedback)
    {
        return wxFeedbackMapper.insertWxFeedback(wxFeedback);
    }

    /**
     * 修改【请填写功能名称】
     *
     * @param wxFeedback 【请填写功能名称】
     * @return 结果
     */
    @Override
    public int updateWxFeedback(Feedback wxFeedback)
    {
        return wxFeedbackMapper.updateWxFeedback(wxFeedback);
    }

    /**
     * 批量删除【请填写功能名称】
     *
     * @param userIds 需要删除的【请填写功能名称】主键
     * @return 结果
     */
    @Override
    public int deleteWxFeedbackByUserIds(Long[] userIds)
    {
        return wxFeedbackMapper.deleteWxFeedbackByUserIds(userIds);
    }

    /**
     * 删除【请填写功能名称】信息
     *
     * @param userId 【请填写功能名称】主键
     * @return 结果
     */
    @Override
    public int deleteWxFeedbackByUserId(Long userId)
    {
        return wxFeedbackMapper.deleteWxFeedbackByUserId(userId);
    }
}
