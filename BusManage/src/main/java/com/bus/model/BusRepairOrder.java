package com.bus.model;

import lombok.Data;

import java.util.Date;

@Data
public class BusRepairOrder {

    /**
     * 主键
     */
    private Integer id;
    /**
     * 用户id
     */
    private Integer userId;
    /**
     * 用户预算
     */
    private Integer ysAmount;
    /**
     * 用户的车
     */
    private Integer busId;
    /**
     * 维修工
     */
    private Integer repairUser;
    /**
     * 维修状态 1预约中
     */
    private Integer status;
    /**
     * 付款状态 1 未付款
     */
    private Integer payStatus;
    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 0 未删除 1已删除
     */
    private Integer delFlag;

    private Integer sjAmount;
    /**
     * 备注
     */
    private String remark;
}
