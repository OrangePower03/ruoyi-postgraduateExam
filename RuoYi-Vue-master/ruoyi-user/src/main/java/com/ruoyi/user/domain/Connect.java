package com.ruoyi.user.domain;

import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class Connect extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 连接编号 */
    private Long connectId;

    /** 专业编号 */
    @Excel(name = "专业编号")
    private Long majorId;

    /** 院系编号 */
    @Excel(name = "院系编号")
    private Long departmentId;

    public void setConnectId(Long connectId)
    {
        this.connectId = connectId;
    }

    public Long getConnectId()
    {
        return connectId;
    }
    public void setMajorId(Long majorId)
    {
        this.majorId = majorId;
    }

    public Long getMajorId()
    {
        return majorId;
    }
    public void setDepartmentId(Long departmentId)
    {
        this.departmentId = departmentId;
    }

    public Long getDepartmentId()
    {
        return departmentId;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("connectId", getConnectId())
                .append("majorId", getMajorId())
                .append("departmentId", getDepartmentId())
                .toString();
    }
}
