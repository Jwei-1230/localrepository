package com.bus.dao;

import com.bus.model.BusRepairOrder;
import com.bus.model.BusRepairPaiJian;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface BusRepairOrderMapper {

    /**
     * 分页查询预约信息
     * @param name 所有人名称
     * @param role 预约信息角色
     * @param busName 车辆名称
     * @param type  有值表示查看维修派工信息
     * @return
     */
    List<Map<String, Object>> getBusOrderList(@Param("name") String name, @Param("role") Integer role, @Param("busName") String busName,@Param("userId") Integer userId,@Param("workerId")Integer workerId,@Param("type") Integer type);

    /**
     * 保存预约信息信息
     * @param order
     */
    void save(BusRepairOrder order);

    /**
     * 删除预约信息
     * @param id
     */
    void delete(Integer id);

    /**
     * 更新预约信息
     * @param order
     */
    void updateBusOrder(BusRepairOrder order);

    /**
     * 派遣员工
     * @param order
     */
    void updateBusOrderRepairUser(BusRepairOrder order);

    BusRepairOrder get(@Param("id") Integer id);

    /**
     * 派件记录
     * @param paiJian
     */
    void savePaiJian(BusRepairPaiJian paiJian);

    List<BusRepairPaiJian> getPaiJianByOrderIdAndWuliaoId(@Param("id") Integer id, @Param("wuId") Integer deviceId);

    void updatePaiJian(BusRepairPaiJian paiJian);

    void updateBusOrderStatus(BusRepairOrder order);

    List<BusRepairPaiJian> getPaijianByType(@Param("id") Integer id, @Param("type") int type);

    List<BusRepairPaiJian> getPaiJianById(@Param("id") Integer id);
}
