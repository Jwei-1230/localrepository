package com.bus.model;

import lombok.Data;

import java.util.Date;

/**
 * 用户留言
 */
@Data
public class BusMsg {
    /**
     * 主键
     */
    private Integer id;

    /**
     * 用户id
     */
    private Integer userId;
    /**
     * 留言内容
     */
    private String content;
    /**
     * 创建时间
     */
    private Date createTime;
}
