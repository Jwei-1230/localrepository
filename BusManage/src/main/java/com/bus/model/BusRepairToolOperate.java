package com.bus.model;

import lombok.Data;

import java.util.Date;

/**
 * 维修工具操作
 */
@Data
public class BusRepairToolOperate {
    /**
     * 主键
     */
    private Integer id;
    /**
     * 工具id
     */
    private Integer toolId;
    /**
     * 操作类型 1入库 2出库
     */
    private Integer type;
    /**
     * 操作备注
     */
    private String remark;

    /**
     * 操作数量
     */
    private Integer operateAmount;

    /**
     * 操作前剩余数量
     */
    private Integer balanceAmount;

    /**
     * 操作人
     */
    private Integer createUser;
    /**
     * 操作时间
     */
    private Date createTime;
}
