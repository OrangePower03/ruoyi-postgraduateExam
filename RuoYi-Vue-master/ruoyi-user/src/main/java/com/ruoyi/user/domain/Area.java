package com.ruoyi.user.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 地区对象 wx_area
 *
 * @author wx
 * @date 2024-01-18
 */
public class Area extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 地区主键 */
    private Long areaId;

    /** 地区名称 */
    @Excel(name = "地区名称")
    private String areaName;

    /** 地区类型 */
    @Excel(name = "地区类型")
    private Long areaType;

    public void setAreaId(Long areaId)
    {
        this.areaId = areaId;
    }

    public Long getAreaId()
    {
        return areaId;
    }
    public void setAreaName(String areaName)
    {
        this.areaName = areaName;
    }

    public String getAreaName()
    {
        return areaName;
    }
    public void setAreaType(Long areaType)
    {
        this.areaType = areaType;
    }

    public Long getAreaType()
    {
        return areaType;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
                .append("areaId", getAreaId())
                .append("areaName", getAreaName())
                .append("areaType", getAreaType())
                .toString();
    }
}
