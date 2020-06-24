package com.bus.dao;

import com.bus.model.BusInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface BusInfoMapper {

    /**
     * 分页查询车辆
     * @param name 所有人名称
     * @param role 车辆角色
     * @param busName 车辆名称
     * @return
     */
    List<Map<String, Object>> getBusList(@Param("name") String name, @Param("userId") Integer userId, @Param("busName") String busName);

    /**
     * 保存车辆信息
     * @param info
     */
    void save(BusInfo info);

    /**
     * 删除车辆
     * @param id
     */
    void delete(Integer id);

    /**
     * 更新车辆
     * @param info
     */
    void updateBus(BusInfo info);

    /**
     * 获取用户的车
     * @param userId
     * @return
     */
    List<Map<String, Object>> getBusByUserId(@Param("userId") Integer userId);
}
