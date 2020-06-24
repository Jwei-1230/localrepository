package com.bus.model;

import lombok.Data;

import java.util.Date;

/**
 * 完工后的结算单
 */
@Data
public class BusOrder {
    /**
     * 主键
     */
    private Integer id;

    /**
     * 用户id
     */
    private Integer userId;
    /**
     * 结算单号
     */
    private String orderNo;
    /**
     * 预约维修id
     */
    private Integer repairId;

    /**
     * 结算总价
     */
    private Integer total;
    /**
     * 1 未付款
     */
    private Integer status;
    /**
     * 创建时间
     */
    private Date createTime;
}
