package com.ruoyi.user.service;

import java.util.List;
import com.ruoyi.user.domain.UserScoreInfo;

/**
 * 【请填写功能名称】Service接口
 *
 * @date 2023-04-26
 */
public interface IUserScoreInfoService
{
    /**
     * 查询【请填写功能名称】
     *
     * @param userId 【请填写功能名称】主键
     * @return 【请填写功能名称】
     */
    public UserScoreInfo selectWxUserScoreInfoByUserId(Long userId);

    /**
     * 查询【请填写功能名称】列表
     *
     * @param wxUserScoreinfo 【请填写功能名称】
     * @return 【请填写功能名称】集合
     */
    public List<UserScoreInfo> selectWxUserScoreInfoList(UserScoreInfo wxUserScoreinfo);

    /**
     * 新增【请填写功能名称】
     *
     * @param wxUserScoreinfo 【请填写功能名称】
     * @return 结果
     */
    public int insertWxUserScoreInfo(UserScoreInfo wxUserScoreinfo);

    /**
     * 修改【请填写功能名称】
     *
     * @param wxUserScoreinfo 【请填写功能名称】
     * @return 结果
     */
    public int updateWxUserScoreInfo(UserScoreInfo wxUserScoreinfo);

    /**
     * 批量删除【请填写功能名称】
     *
     * @param userIds 需要删除的【请填写功能名称】主键集合
     * @return 结果
     */
    public int deleteWxUserScoreInfoByUserIds(Long[] userIds);

    /**
     * 删除【请填写功能名称】信息
     *
     * @param userId 【请填写功能名称】主键
     * @return 结果
     */
    public int deleteWxUserScoreInfoByUserId(Long userId);
}
