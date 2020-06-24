package com.bus.dao;

import com.bus.model.BusDevice;
import com.bus.model.BusDeviceOperate;
import com.bus.model.BusUser;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface BusDeviceMapper {
    /**
     * 获取配件分页信息
     * @param name
     * @return
     */
    List<Map<String,Object>> getBusDeviceList(@Param("name") String name);

    /**
     * 统计指定名称的配件数量
     * @param name
     * @return
     */
    Integer countDeviceByName(@Param("name") String name);

    /**
     * 保存配件
     * @param device
     */
    void save(BusDevice device);

    /**
     * 保存配件操作记录
     * @param busDeviceOperate
     */
    void saveOperate(BusDeviceOperate busDeviceOperate);

    /**
     * 获取配件操作记录分页信息
     * @param name
     * @return
     */
    List<Map<String,Object>> getDeviceOperateList(@Param("name") String name);

    void delete(Integer id);
    void deleteOperate(Integer id);

    /**
     * 获取设备
     * @param id
     * @return
     */
    BusDevice get(@Param("id") Integer id);

    Integer update(BusDevice device);

    List<Map<String, Object>> getDeviceData();

    List<Map<String, Object>> getDeviceSellList(@Param("name") String name, @Param("userId") Integer userId);
}
