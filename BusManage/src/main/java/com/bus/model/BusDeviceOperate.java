package com.bus.model;

import lombok.Data;

import java.util.Date;

/**
 * 汽车配件操作
 */
@Data
public class BusDeviceOperate {
    /**
     * 主键
     */
    private Integer id;
    /**
     * 配件id
     */
    private Integer deviceId;
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
