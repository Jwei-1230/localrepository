package com.bus.dao;

import com.bus.model.BusRepairTool;
import com.bus.model.BusRepairToolOperate;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface BusRepairToolMapper {
    /**
     * 获取工具分页信息
     * @param name
     * @return
     */
    List<Map<String,Object>> getBusToolList(@Param("name") String name);

    /**
     * 统计指定名称的工具数量
     * @param name
     * @return
     */
    Integer countToolByName(@Param("name") String name);

    /**
     * 保存工具
     * @param tool
     */
    void save(BusRepairTool tool);

    /**
     * 保存工具操作记录
     * @param busRepairToolOperate
     */
    void saveOperate(BusRepairToolOperate busRepairToolOperate);

    /**
     * 获取工具操作记录分页信息
     * @param name
     * @return
     */
    List<Map<String,Object>> getToolOperateList(@Param("name") String name);

    void delete(Integer id);
    void deleteOperate(Integer id);

    /**
     * 获取设备
     * @param id
     * @return
     */
    BusRepairTool get(@Param("id") Integer id);

    Integer update(BusRepairTool tool);

    List<Map<String, Object>> getToolData();
}
