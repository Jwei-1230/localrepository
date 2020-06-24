package com.bus.dao;

import com.bus.model.BusMsg;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 留言
 */
public interface BusMsgMapper {

    /**
     * 分页查询留言
     * @param name 所有人名称
     * @param userId 用户Id
     * @param content 留言内容
     * @return
     */
    List<Map<String, Object>> getBusMsgList(@Param("name") String name, @Param("userId") Integer userId, @Param("content") String content);

    /**
     * 保存留言信息
     * @param msg
     */
    void save(BusMsg msg);

    /**
     * 删除留言
     * @param id
     */
    void delete(Integer id);

    /**
     * 更新留言
     * @param msg
     */
    void updateMsg(BusMsg msg);
}
