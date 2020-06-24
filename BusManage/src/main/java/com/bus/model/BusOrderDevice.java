package com.bus.model;

import lombok.Data;

import java.util.Date;

@Data
public class BusOrderDevice {
    /**
     * 主键
     */
    private Integer id;

    private Integer userId;
    /**
     * 订单id
     */
    private Integer orderId;
    /**
     * 配件名称
     */
    private String name;
    /**
     * 配件价格
     */
    private Integer price;
    /**
     * 配件数量
     */
    private Integer amount;
    /**
     * 时间
     */
    private Date createTime;
}
