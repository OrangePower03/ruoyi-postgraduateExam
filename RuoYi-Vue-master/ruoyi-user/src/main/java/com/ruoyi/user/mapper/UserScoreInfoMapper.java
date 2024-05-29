package com.ruoyi.user.mapper;

import java.util.List;
import com.ruoyi.user.domain.UserScoreInfo;

/**
 * 【请填写功能名称】Mapper接口
 *
 * @date 2023-04-26
 */
public interface UserScoreInfoMapper
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
    public List<UserScoreInfo> selectWxUserScoreinfoList(UserScoreInfo wxUserScoreinfo);

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
     * 删除【请填写功能名称】
     *
     * @param userId 【请填写功能名称】主键
     * @return 结果
     */
    public int deleteWxUserScoreInfoByUserId(Long userId);

    /**
     * 批量删除【请填写功能名称】
     *
     * @param userIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteWxUserScoreInfoByUserIds(Long[] userIds);

    String findAreaNameByUserId(Long userId);
}
