package com.ruoyi.user.mapper;

import com.ruoyi.user.domain.Info;
import java.util.List;

/**
 * 招生信息Mapper接口
 *
 * @date 2024-02-16
 */
public interface InfoMapper
{
    /**
     * 查询招生信息
     *
     * @param infoId 招生信息主键
     * @return 招生信息
     */
    public Info selectInfoByInfoId(Long infoId);

    /**
     * 查询招生信息列表
     *
     * @param info 招生信息
     * @return 招生信息集合
     */
    public List<Info> selectInfoList(Info info);

    /**
     * 新增招生信息
     *
     * @param info 招生信息
     * @return 结果
     */
    public int insertInfo(Info info);

    /**
     * 修改招生信息
     *
     * @param info 招生信息
     * @return 结果
     */
    public int updateInfo(Info info);

    /**
     * 删除招生信息
     *
     * @param infoId 招生信息主键
     * @return 结果
     */
    public int deleteInfoByInfoId(Long infoId);

    /**
     * 批量删除招生信息
     *
     * @param infoIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteInfoByInfoIds(Long[] infoIds);
}

