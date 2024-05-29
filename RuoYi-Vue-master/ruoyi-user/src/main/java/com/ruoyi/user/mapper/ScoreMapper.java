package com.ruoyi.user.mapper;

import java.util.List;
import java.util.Set;

import com.ruoyi.common.annotation.SystemTestCode;
import com.ruoyi.user.domain.AllInfo;
import com.ruoyi.user.domain.Score;
import com.ruoyi.user.domain.UserScoreInfo;
import org.apache.ibatis.annotations.Param;

/**
 * 【请填写功能名称】Mapper接口
 *
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

    public List<Score> selectThreeRetestLine(Score score);

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

    @Deprecated
    List<Score> selectByMajorAndScoreAll(@Param("majorName") String majorName,
                                         @Param("scoreAll") Long scoreAll,
                                         @Param("floatScore") int floatScore,
                                         @Param("first_year") int first_year);

    Long getSchoolIdByConnectId(Long connectId);

    List<Long> getConnectIdByMajorName(@Param("majorName") String majorName,
                                       @Param("scoreAll") Long scoreAll,
                                       @Param("floatScore") int floatScore,
                                       @Param("first_year") int first_year);

    @Deprecated
    List<Score> selectByMajorAndSchoolIdAndScoreAll(@Param("majorName") String majorName,
                                                  @Param("schoolIds") List<Long> schoolIds,
                                                  @Param("scoreAll") Long scoreAll,
                                                  @Param("floatScore") int floatScore,
                                                  @Param("first_year") int first_year);

    List<Score> selectByMajorAndSchoolId(@Param("majorName") String majorName,
                                         @Param("schoolIds") List<Long> schoolIds,
                                         @Param("first_year") int first_year);

    @SystemTestCode
    String getSchoolNameByScoreConnectId(@Param("connectId") Long connectId);

    List<Long> getSchoolIdByScoreConnectId(@Param("connectIds") List<Long> connectIds);

    UserScoreInfo getUserScore(Long userId);
}
