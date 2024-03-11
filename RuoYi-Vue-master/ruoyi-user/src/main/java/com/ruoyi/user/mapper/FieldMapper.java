package com.ruoyi.user.mapper;

import java.util.List;
import com.ruoyi.user.domain.Field;

/**
 * 学科类别Mapper接口
 *
 * @author wx
 * @date 2024-02-26
 */
public interface FieldMapper
{
    /**
     * 查询学科类别
     *
     * @param fieldId 学科类别主键
     * @return 学科类别
     */
    public Field selectFieldByFieldId(Long fieldId);

    /**
     * 查询学科类别列表
     *
     * @param field 学科类别
     * @return 学科类别集合
     */
    public List<Field> selectFieldList(Field field);

    /**
     * 新增学科类别
     *
     * @param field 学科类别
     * @return 结果
     */
    public int insertField(Field field);

    /**
     * 修改学科类别
     *
     * @param field 学科类别
     * @return 结果
     */
    public int updateField(Field field);

    /**
     * 删除学科类别
     *
     * @param fieldId 学科类别主键
     * @return 结果
     */
    public int deleteFieldByFieldId(Long fieldId);

    /**
     * 批量删除学科类别
     *
     * @param fieldIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteFieldByFieldIds(Long[] fieldIds);

    int getCount();
}
