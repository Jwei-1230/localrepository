package com.bus.model;

import lombok.Data;

import java.util.Date;

/**
 * 汽车配件
 */
@Data
public class BusDevice {
    /**
     * 主键
     */
    private Integer id;

    /**
     * 出售单价
     */
    private Integer price;

    /**
     * 剩余数量
     */
    private Integer balance = 0;
    /**
     * 版本号
     */
    private Integer version;
    /**
     * 配件名称
     */
    private String name;

    /**
     * 创建人
     */
    private Integer createUser;

    /**
     * 创建时间
     */
    private Date createTime;
}
