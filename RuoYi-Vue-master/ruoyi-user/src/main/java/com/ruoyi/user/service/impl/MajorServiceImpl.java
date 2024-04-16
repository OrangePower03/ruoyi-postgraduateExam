package com.ruoyi.user.service.impl;

import java.util.List;

import com.ruoyi.user.domain.Connect;
import com.ruoyi.user.domain.Major;
import com.ruoyi.user.mapper.MajorMapper;
import com.ruoyi.user.service.IMajorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 【请填写功能名称】Service业务层处理
 *
 * @date 2023-04-01
 */
@Service
public class MajorServiceImpl implements IMajorService
{
    @Autowired
    private MajorMapper wxMajorMapper;

    /**
     * 查询【请填写功能名称】
     *
     * @param majorId 【请填写功能名称】主键
     * @return 【请填写功能名称】
     */
    @Override
    public Major selectWxMajorByMajorId(Long majorId)
    {
        return wxMajorMapper.selectWxMajorByMajorId(majorId);
    }

    @Override
    public Connect selectWxConnectByConnectId(Long connectId) {
        return wxMajorMapper.selectWxConnectByConnectId(connectId);
    }

    /**
     * 查询【请填写功能名称】列表
     *
     * @param wxMajor 【请填写功能名称】
     * @return 【请填写功能名称】
     */
    @Override
    public List<Major> selectWxMajorList(Major wxMajor)
    {
        return wxMajorMapper.selectWxMajorList(wxMajor);
    }

    @Override
    public List<Major> selectMajorList(Major wxMajor) {
        return wxMajorMapper.selectMajorList(wxMajor);
    }

    /**
     * 新增【请填写功能名称】
     *
     * @param wxMajor 【请填写功能名称】
     * @return 结果
     */
    @Override
    public int insertWxMajor(Major wxMajor)
    {
        return wxMajorMapper.insertWxMajor(wxMajor);
    }

    /**
     * 修改【请填写功能名称】
     *
     * @param wxMajor 【请填写功能名称】
     * @return 结果
     */
    @Override
    public int updateWxMajor(Major wxMajor)
    {
        return wxMajorMapper.updateWxMajor(wxMajor);
    }

    /**
     * 批量删除【请填写功能名称】
     *
     * @param majorIds 需要删除的【请填写功能名称】主键
     * @return 结果
     */
    @Override
    public int deleteWxMajorByMajorIds(Long[] majorIds)
    {
        return wxMajorMapper.deleteWxMajorByMajorIds(majorIds);
    }

    /**
     * 删除【请填写功能名称】信息
     *
     * @param majorId 【请填写功能名称】主键
     * @return 结果
     */
    @Override
    public int deleteWxMajorByMajorId(Long majorId)
    {
        return wxMajorMapper.deleteWxMajorByMajorId(majorId);
    }

    /**
     * 新增【请填写功能名称】
     *
     * @param wxMcd 【请填写功能名称】
     * @return 结果
     */
    @Override
    public int insertWxMcd(Connect wxMcd)
    {
        return wxMajorMapper.insertWxMcd(wxMcd);
    }

    /**
     * 修改【请填写功能名称】
     *
     * @param wxMcd 【请填写功能名称】
     * @return 结果
     */
    @Override
    public int updateWxMcd(Connect wxMcd)
    {
        return wxMajorMapper.updateWxMcd(wxMcd);
    }

    /**
     * 批量删除【请填写功能名称】
     *
     * @param connectIds 需要删除的【请填写功能名称】主键
     * @return 结果
     */
    @Override
    public int deleteWxMcdByConnectIds(Long[] connectIds)
    {
        return wxMajorMapper.deleteWxMcdByConnectIds(connectIds);
    }

    /**
     * 删除【请填写功能名称】信息
     *
     * @param connectId 【请填写功能名称】主键
     * @return 结果
     */
    @Override
    public int deleteWxMcdByConnectId(Long connectId)
    {
        return wxMajorMapper.deleteWxMcdByConnectId(connectId);
    }
}
