package com.bus.dao;

import com.bus.model.BusOrder;
import com.bus.model.BusOrderDevice;
import com.bus.model.BusUser;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface BusOrderMapper {

    void save(BusOrder busOrder);

    void saveDevices(@Param("order") BusOrder busOrder, @Param("list") List<BusOrderDevice> busOrderDevices);

    /**
     * 获取结算单
     * @param name 客户名称
     * @param orderNo 订单号
     * @param userId 客户id
     * @return
     */
    List<Map<String, Object>> getCompleteOrderList(@Param("name") String name, @Param("orderNo")String orderNo, @Param("userId")Integer userId);

    void doJieSuan(@Param("id") Integer id);

    List<Map<String, Object>> getQiKuanList(@Param("name") String name, @Param("userId") Integer userId);

    void doJieSuanAll(@Param("id") Integer id);

    List<Map<String, Object>> getYuShouKuanList(@Param("name") String name, @Param("orderNo")String orderNo, @Param("userId")Integer userId);
}
