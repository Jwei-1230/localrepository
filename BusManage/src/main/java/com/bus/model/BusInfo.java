package com.bus.model;

import lombok.Data;

import java.util.Date;

/**
 * 用户车辆表
 */
@Data
public class BusInfo {
    /**
     * 主键
     */
    private Integer id;

    /**
     * 用户id
     */
    private Integer userId;
    /**
     * 车名称
     */
    private String name;
    /**
     * 车总价
     */
    private String total;
    /**
     * 购买时间
     */
    private String buyTime;
    /**
     * 0  未删除 1已删除
     */
    private Integer delFlag;

    /**
     * 创建时间
     */
    private Date createTime;
}
