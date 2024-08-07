package com.ruoyi.user.mapper;

import java.util.List;

import com.ruoyi.user.domain.Connect;
import com.ruoyi.user.domain.Major;

/**
 * 【请填写功能名称】Mapper接口
 *
 * @date 2023-04-01
 */
public interface MajorMapper
{
    /**
     * 查询【请填写功能名称】
     *
     * @param majorId 【请填写功能名称】主键
     * @return 【请填写功能名称】
     */
    public Major selectWxMajorByMajorId(Long majorId);

    /**
     * 查询wx_mcd的详细
     *
     * @param connectId wx_mcd主键
     * @return 一条连表信息
     */
    public Connect selectWxConnectByConnectId(Long connectId);
    /**
     * 查询【请填写功能名称】列表
     *
     * @param wxMajor 【请填写功能名称】
     * @return 【请填写功能名称】集合
     */
    public List<Major> selectWxMajorList(Major wxMajor);

    /**
     * 查询纯专业列表
     *
     * @param wxMajor 【请填写功能名称】
     * @return 【请填写功能名称】集合
     */
    public List<Major> selectMajorList(Major wxMajor);

    /**
     * 新增【请填写功能名称】
     *
     * @param wxMajor 【请填写功能名称】
     * @return 结果
     */
    public int insertWxMajor(Major wxMajor);

    /**
     * 修改【请填写功能名称】
     *
     * @param wxMajor 【请填写功能名称】
     * @return 结果
     */
    public int updateWxMajor(Major wxMajor);

    /**
     * 删除【请填写功能名称】
     *
     * @param majorId 【请填写功能名称】主键
     * @return 结果
     */
    public int deleteWxMajorByMajorId(Long majorId);

    /**
     * 批量删除【请填写功能名称】
     *
     * @param majorIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteWxMajorByMajorIds(Long[] majorIds);

    /**
     * 新增【请填写功能名称】
     *
     * @param wxMcd 【请填写功能名称】
     * @return 结果
     */
    public int insertWxMcd(Connect wxMcd);

    /**
     * 修改【请填写功能名称】
     *
     * @param wxMcd 【请填写功能名称】
     * @return 结果
     */
    public int updateWxMcd(Connect wxMcd);

    /**
     * 删除【请填写功能名称】
     *
     * @param connectId 【请填写功能名称】主键
     * @return 结果
     */
    public int deleteWxMcdByConnectId(Long connectId);

    /**
     * 批量删除【请填写功能名称】
     *
     * @param connectIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteWxMcdByConnectIds(Long[] connectIds);
}
