package com.ruoyi.user.service.impl;

import java.util.List;

import com.ruoyi.user.domain.Info;
import com.ruoyi.user.mapper.InfoMapper;
import com.ruoyi.user.service.IInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


/**
 * 招生信息Service业务层处理
 *
 * @date 2024-02-16
 */
@Service
public class InfoServiceImpl implements IInfoService
{
    @Autowired
    private InfoMapper infoMapper;

    /**
     * 查询招生信息
     *
     * @param infoId 招生信息主键
     * @return 招生信息
     */
    @Override
    public Info selectInfoByInfoId(Long infoId)
    {
        return infoMapper.selectInfoByInfoId(infoId);
    }

    /**
     * 查询招生信息列表
     *
     * @param info 招生信息
     * @return 招生信息
     */
    @Override
    public List<Info> selectInfoList(Info info)
    {
        return infoMapper.selectInfoList(info);
    }

    /**
     * 新增招生信息
     *
     * @param info 招生信息
     * @return 结果
     */
    @Override
    public int insertInfo(Info info)
    {
        return infoMapper.insertInfo(info);
    }

    /**
     * 修改招生信息
     *
     * @param info 招生信息
     * @return 结果
     */
    @Override
    public int updateInfo(Info info)
    {
        return infoMapper.updateInfo(info);
    }

    /**
     * 批量删除招生信息
     *
     * @param infoIds 需要删除的招生信息主键
     * @return 结果
     */
    @Override
    public int deleteInfoByInfoIds(Long[] infoIds)
    {
        return infoMapper.deleteInfoByInfoIds(infoIds);
    }

    /**
     * 删除招生信息信息
     *
     * @param infoId 招生信息主键
     * @return 结果
     */
    @Override
    public int deleteInfoByInfoId(Long infoId)
    {
        return infoMapper.deleteInfoByInfoId(infoId);
    }
}

