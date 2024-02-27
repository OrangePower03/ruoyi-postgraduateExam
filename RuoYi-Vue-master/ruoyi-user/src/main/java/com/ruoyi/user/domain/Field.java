package com.ruoyi.user.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 学科类别对象 wx_field
 *
 * @author wx
 * @date 2024-02-26
 */
public class Field extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 学科类别Id */
    private Long fieldId;

    /** 学科类别名称 */
    @Excel(name = "学科类别名称")
    private String fieldName;

    /** 学科类别代码 */
    @Excel(name = "学科类别代码")
    private String fieldCode;

    /** 所属门类 */
    @Excel(name = "所属门类")
    private Long parentId;

    /** 专业类型 */
    @Excel(name = "专业类型")
    private Long majorType;

    public void setFieldId(Long fieldId)
    {
        this.fieldId = fieldId;
    }

    public Long getFieldId()
    {
        return fieldId;
    }
    public void setFieldName(String fieldName)
    {
        this.fieldName = fieldName;
    }

    public String getFieldName()
    {
        return fieldName;
    }
    public void setFieldCode(String fieldCode)
    {
        this.fieldCode = fieldCode;
    }

    public String getFieldCode()
    {
        return fieldCode;
    }
    public void setParentId(Long parentId)
    {
        this.parentId = parentId;
    }

    public Long getParentId()
    {
        return parentId;
    }
    public void setMajorType(Long majorType)
    {
        this.majorType = majorType;
    }

    public Long getMajorType()
    {
        return majorType;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
                .append("fieldId", getFieldId())
                .append("fieldName", getFieldName())
                .append("fieldCode", getFieldCode())
                .append("parentId", getParentId())
                .append("majorType", getMajorType())
                .toString();
    }
}
