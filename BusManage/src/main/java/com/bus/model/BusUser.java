package com.bus.model;

import lombok.Data;

import java.util.Date;

/**
 * 系统用户表
 */
@Data
public class BusUser {
    /**
     * 主键
     */
    private Integer id;
    /**
     * 用户名
     */
    private String userName;
    /**
     * 密码
     */
    private String passWord;
    /**
     * 真实名称
     */
    private String realName;

    /**
     * 用户角色 1 管理员 2修理工 3 客户
     */
    private Integer role;

    /**
     * 用户联系电话
     */
    private String phone;

    /**
     * 用户地址信息
     */
    private String address;

    /**
     * 0  未删除 1已删除
     */
    private Integer delFlag;

    /**
     * 创建时间
     */
    private Date createTime;
}
