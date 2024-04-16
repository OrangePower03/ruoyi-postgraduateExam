package com.ruoyi.user.service.impl;

import java.util.List;

import com.ruoyi.user.domain.UserScoreInfo;
import com.ruoyi.user.mapper.UserScoreInfoMapper;
import com.ruoyi.user.service.IUserScoreInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 【请填写功能名称】Service业务层处理
 *
 * @date 2023-04-26
 */
@Service
public class UserScoreInfoServiceImpl implements IUserScoreInfoService
{
    @Autowired
    private UserScoreInfoMapper wxUserScoreinfoMapper;

    /**
     * 查询【请填写功能名称】
     *
     * @param userId 【请填写功能名称】主键
     * @return 【请填写功能名称】
     */
    @Override
    public UserScoreInfo selectWxUserScoreInfoByUserId(Long userId)
    {
        return wxUserScoreinfoMapper.selectWxUserScoreInfoByUserId(userId);
    }

    /**
     * 查询【请填写功能名称】列表
     *
     * @param wxUserScoreinfo 【请填写功能名称】
     * @return 【请填写功能名称】
     */
    @Override
    public List<UserScoreInfo> selectWxUserScoreInfoList(UserScoreInfo wxUserScoreinfo)
    {
        return wxUserScoreinfoMapper.selectWxUserScoreinfoList(wxUserScoreinfo);
    }

    /**
     * 新增【请填写功能名称】
     *
     * @param wxUserScoreinfo 【请填写功能名称】
     * @return 结果
     */
    @Override
    public int insertWxUserScoreInfo(UserScoreInfo wxUserScoreinfo)
    {
        return wxUserScoreinfoMapper.insertWxUserScoreInfo(wxUserScoreinfo);
    }

    /**
     * 修改【请填写功能名称】
     *
     * @param wxUserScoreinfo 【请填写功能名称】
     * @return 结果
     */
    @Override
    public int updateWxUserScoreInfo(UserScoreInfo wxUserScoreinfo)
    {
        return wxUserScoreinfoMapper.updateWxUserScoreInfo(wxUserScoreinfo);
    }

    /**
     * 批量删除【请填写功能名称】
     *
     * @param userIds 需要删除的【请填写功能名称】主键
     * @return 结果
     */
    @Override
    public int deleteWxUserScoreInfoByUserIds(Long[] userIds)
    {
        return wxUserScoreinfoMapper.deleteWxUserScoreInfoByUserIds(userIds);
    }

    /**
     * 删除【请填写功能名称】信息
     *
     * @param userId 【请填写功能名称】主键
     * @return 结果
     */
    @Override
    public int deleteWxUserScoreInfoByUserId(Long userId)
    {
        return wxUserScoreinfoMapper.deleteWxUserScoreInfoByUserId(userId);
    }
}
