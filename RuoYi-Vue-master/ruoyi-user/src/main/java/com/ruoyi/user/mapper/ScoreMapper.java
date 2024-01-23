package com.ruoyi.user.mapper;

import java.util.List;

import com.ruoyi.user.domain.AllInfo;
import com.ruoyi.user.domain.Score;
import com.ruoyi.user.domain.common.ScoreWithSchoolName;
import org.apache.ibatis.annotations.Param;

/**
 * 【请填写功能名称】Mapper接口
 *
 * @author ruoyi
 * @date 2023-04-02
 */
public interface ScoreMapper
{
    /**
     * 查询【请填写功能名称】
     *
     * @param scoreId 【请填写功能名称】主键
     * @return 【请填写功能名称】
     */
    public Score selectWxScoreByScoreId(Long scoreId);

    /**
     * 查询【请填写功能名称】
     *
     * @param score 【请填写功能名称】主键
     * @return 【请填写功能名称】
     */
    public Score scoreJudge(Score score);

    /**
     * 查询【请填写功能名称】列表
     *
     * @param wxScore 【请填写功能名称】
     * @return 【请填写功能名称】集合
     */
    public List<Score> selectWxScoreList(Score wxScore);

    /**
     * 新增【请填写功能名称】
     *
     * @param wxScore 【请填写功能名称】
     * @return 结果
     */
    public int insertWxScore(Score wxScore);

    /**
     * 修改【请填写功能名称】
     *
     * @param wxScore 【请填写功能名称】
     * @return 结果
     */
    public int updateWxScore(Score wxScore);

    /**
     * 删除【请填写功能名称】
     *
     * @param scoreId 【请填写功能名称】主键
     * @return 结果
     */
    public int deleteWxScoreByScoreId(Long scoreId);

    /**
     * 批量删除【请填写功能名称】
     *
     * @param scoreIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteWxScoreByScoreIds(Long[] scoreIds);

    /**
     * 查询【请填写功能名称】
     *
     * @param allInfo 【请填写功能名称】主键
     * @return 【请填写功能名称】
     */
    public List<AllInfo> selectAllInfoList(AllInfo allInfo);

    List<Score> selectByMajorAndScoreAll(@Param("majorName") String majorName,
                                                       @Param("scoreAll") Long scoreAll,
                                                       @Param("floatScore") int floatScore,
                                                       @Param("first_year") int first_year);

    String getSchoolNameByScoreConnectId(Long connectId);
}
