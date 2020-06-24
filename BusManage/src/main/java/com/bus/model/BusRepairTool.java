package com.bus.model;

import lombok.Data;

import java.util.Date;

/**
 * 汽车维修工具
 */
@Data
public class BusRepairTool {
    /**
     * 主键
     */
    private Integer id;
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
