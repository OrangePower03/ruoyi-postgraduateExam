package com.ruoyi.user.service;

import java.util.List;
import com.ruoyi.user.domain.Feedback;

/**
 * 【请填写功能名称】Service接口
 *
 * @author ruoyi
 * @date 2023-04-25
 */
public interface IFeedbackService
{
    /**
     * 查询【请填写功能名称】
     *
     * @param userId 【请填写功能名称】主键
     * @return 【请填写功能名称】
     */
    public Feedback selectWxFeedbackByUserId(Long userId);

    /**
     * 查询【请填写功能名称】列表
     *
     * @param wxFeedback 【请填写功能名称】
     * @return 【请填写功能名称】集合
     */
    public List<Feedback> selectWxFeedbackList(Feedback wxFeedback);

    /**
     * 新增【请填写功能名称】
     *
     * @param wxFeedback 【请填写功能名称】
     * @return 结果
     */
    public int insertWxFeedback(Feedback wxFeedback);

    /**
     * 修改【请填写功能名称】
     *
     * @param wxFeedback 【请填写功能名称】
     * @return 结果
     */
    public int updateWxFeedback(Feedback wxFeedback);

    /**
     * 批量删除【请填写功能名称】
     *
     * @param userIds 需要删除的【请填写功能名称】主键集合
     * @return 结果
     */
    public int deleteWxFeedbackByUserIds(Long[] userIds);

    /**
     * 删除【请填写功能名称】信息
     *
     * @param userId 【请填写功能名称】主键
     * @return 结果
     */
    public int deleteWxFeedbackByUserId(Long userId);
}
