package com.bus.model;

import lombok.Data;

import java.util.Date;

/**
 * 维修派件
 */
@Data
public class BusRepairPaiJian {
    private Integer id;
    /**
     * 预约id
     */
    private Integer repairId;
    /**
     * 物料id 配件 或 工具
     */
    private Integer wuLiaoId;

    /**
     * 配件单价
     */
    private Integer price;

    /**
     * 配件名称
     */
    private String name;

    /**
     * 数量
     */
    private Integer amount;
    /**
     * 维修人员
     */
    private Integer repairUser;
    /**
     * type 1 配件  2工具
     */
    private Integer type;
    /**
     * 时间
     */
    private Date createTime;
}
