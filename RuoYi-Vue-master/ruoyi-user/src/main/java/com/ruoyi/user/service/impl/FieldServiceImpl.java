package com.ruoyi.user.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.user.mapper.FieldMapper;
import com.ruoyi.user.domain.Field;
import com.ruoyi.user.service.IFieldService;

/**
 * 学科类别Service业务层处理
 *
 * @author wx
 * @date 2024-02-26
 */
@Service
public class FieldServiceImpl implements IFieldService
{
    @Autowired
    private FieldMapper fieldMapper;

    /**
     * 查询学科类别
     *
     * @param fieldId 学科类别主键
     * @return 学科类别
     */
    @Override
    public Field selectFieldByFieldId(Long fieldId)
    {
        return fieldMapper.selectFieldByFieldId(fieldId);
    }

    /**
     * 查询学科类别列表
     *
     * @param field 学科类别
     * @return 学科类别
     */
    @Override
    public List<Field> selectFieldList(Field field)
    {
        return fieldMapper.selectFieldList(field);
    }

    /**
     * 新增学科类别
     *
     * @param field 学科类别
     * @return 结果
     */
    @Override
    public int insertField(Field field)
    {
        return fieldMapper.insertField(field);
    }

    /**
     * 修改学科类别
     *
     * @param field 学科类别
     * @return 结果
     */
    @Override
    public int updateField(Field field)
    {
        return fieldMapper.updateField(field);
    }

    /**
     * 批量删除学科类别
     *
     * @param fieldIds 需要删除的学科类别主键
     * @return 结果
     */
    @Override
    public int deleteFieldByFieldIds(Long[] fieldIds)
    {
        return fieldMapper.deleteFieldByFieldIds(fieldIds);
    }

    /**
     * 删除学科类别信息
     *
     * @param fieldId 学科类别主键
     * @return 结果
     */
    @Override
    public int deleteFieldByFieldId(Long fieldId)
    {
        return fieldMapper.deleteFieldByFieldId(fieldId);
    }
}
