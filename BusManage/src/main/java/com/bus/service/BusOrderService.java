package com.bus.service;

import com.bus.dao.BusDeviceMapper;
import com.bus.dao.BusOrderMapper;
import com.bus.dao.BusRepairOrderMapper;
import com.bus.dao.BusRepairToolMapper;
import com.bus.model.*;
import com.bus.utils.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ObjectUtils;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class BusOrderService {

    @Autowired
    private BusRepairOrderMapper busRepairOrderMapper;

    @Autowired
    private BusDeviceMapper busDeviceMapper;

    @Autowired
    private BusRepairToolMapper busRepairToolMapper;

    @Autowired
    private BusOrderMapper busOrderMapper;


    public Page<Map<String, Object>> getBusOrderList(Integer userId,Integer workerId,String name, Integer role, String busName, Integer pageNo, Integer pageSize,Integer type) {
        PageHelper.startPage(pageNo, pageSize);
        List<Map<String, Object>> list = busRepairOrderMapper.getBusOrderList(name,role,busName,userId,workerId,type);
        Page<Map<String, Object>> userPage = new Page<Map<String, Object>>();
        PageInfo<Map<String, Object>> info = new PageInfo<Map<String, Object>>(list);
        userPage.setPageNo(pageNo);
        userPage.setPageSize(pageSize);
        userPage.setResults(list);
        userPage.setTotalPage(info.getPages());
        userPage.setTotalRecord(info.getTotal());
        return userPage;
    }

    @Transactional(rollbackFor = Exception.class)
    public String addBusOrder(BusRepairOrder order) {
        busRepairOrderMapper.save(order);
        return "添加成功";
    }

    @Transactional(rollbackFor = Exception.class)
    public String deleteBusOrder(Integer id) {
        busRepairOrderMapper.delete(id);
        return "删除成功";
    }

    @Transactional(rollbackFor = Exception.class)
    public String updateBusOrder(BusRepairOrder order) {
        busRepairOrderMapper.updateBusOrder(order);
        return "更新成功";
    }

    @Transactional(rollbackFor = Exception.class)
    public String updateBusOrderRepairUser(BusRepairOrder order) {
        busRepairOrderMapper.updateBusOrderRepairUser(order);
        return "操作成功";
    }

    /**
     * 维修领用汽车配件
     * @param id
     * @param amount
     * @param deviceId
     * @return
     */
    @Transactional(rollbackFor = Exception.class)
    public String doLingYongDevice(Integer id, Integer amount, Integer deviceId) {
        BusRepairOrder order = busRepairOrderMapper.get(id);
        if (order.getDelFlag() == 1) {
            return "当前预约数据已经被删除";
        }
        BusDevice device = busDeviceMapper.get(deviceId);
        if (ObjectUtils.isEmpty(device)) {
            return  "该配件可能已被删除";
        }
        if (device.getBalance() < amount) {
            return device.getName()+"库存不足";
        }

        //领用配件
        Integer balance = device.getBalance();
        device.setBalance((balance - amount));
        Integer count = busDeviceMapper.update(device);
        if (count <= 0) {
            return "系统繁忙，请稍后重试";
        }

        BusDeviceOperate busDeviceOperate = new BusDeviceOperate();
        busDeviceOperate.setBalanceAmount(balance);
        busDeviceOperate.setCreateTime(new Date());
        busDeviceOperate.setCreateUser(order.getRepairUser());
        busDeviceOperate.setDeviceId(device.getId());
        busDeviceOperate.setRemark("客户维修领用出库");
        busDeviceOperate.setOperateAmount(amount);
        busDeviceOperate.setType(2);
        busDeviceMapper.saveOperate(busDeviceOperate);
        List<BusRepairPaiJian>  paiJians = busRepairOrderMapper.getPaiJianByOrderIdAndWuliaoId(order.getId(),deviceId);
        if (ObjectUtils.isEmpty(paiJians)) {
            BusRepairPaiJian paiJian = new BusRepairPaiJian();
            paiJian.setAmount(amount);
            paiJian.setCreateTime(new Date());
            paiJian.setRepairId(order.getId());
            paiJian.setRepairUser(order.getRepairUser());
            paiJian.setType(1);
            paiJian.setName(device.getName());
            paiJian.setPrice(device.getPrice());
            paiJian.setWuLiaoId(deviceId);
            busRepairOrderMapper.savePaiJian(paiJian);
        } else {
            BusRepairPaiJian paiJian = paiJians.get(0);
            paiJian.setAmount(paiJian.getAmount() + amount);
            busRepairOrderMapper.updatePaiJian(paiJian);
        }

        return "领取成功";
    }

    /**
     * 维修领用工具
     * @param id 预约数据id
     * @param amount 数量
     * @param toolId 工具id
     * @return
     */
    @Transactional(rollbackFor = Exception.class)
    public String doLingYongTool(Integer id, Integer amount, Integer toolId) {
        BusRepairOrder order = busRepairOrderMapper.get(id);
        if (order.getDelFlag() == 1) {
            return "当前预约数据已经被删除";
        }
        BusRepairTool tool = busRepairToolMapper.get(toolId);
        if (ObjectUtils.isEmpty(tool)) {
            return  "该工具可能已被删除";
        }
        if (tool.getBalance() < amount) {
            return tool.getName()+"库存不足";
        }

        //领用配件
        Integer balance = tool.getBalance();
        tool.setBalance((balance - amount));
        Integer count = busRepairToolMapper.update(tool);
        if (count <= 0) {
            return "系统繁忙，请稍后重试";
        }
        BusRepairToolOperate busRepairToolOperate = new BusRepairToolOperate();
        busRepairToolOperate.setBalanceAmount(balance);
        busRepairToolOperate.setCreateTime(new Date());
        busRepairToolOperate.setCreateUser(order.getRepairUser());
        busRepairToolOperate.setToolId(tool.getId());
        busRepairToolOperate.setRemark("维修领用出库");
        busRepairToolOperate.setOperateAmount(amount);
        busRepairToolOperate.setType(2);
        busRepairToolMapper.saveOperate(busRepairToolOperate);

        List<BusRepairPaiJian>  paiJians = busRepairOrderMapper.getPaiJianByOrderIdAndWuliaoId(order.getId(),toolId);
        if (ObjectUtils.isEmpty(paiJians)) {
            BusRepairPaiJian paiJian = new BusRepairPaiJian();
            paiJian.setAmount(amount);
            paiJian.setCreateTime(new Date());
            paiJian.setRepairId(order.getId());
            paiJian.setRepairUser(order.getRepairUser());
            paiJian.setType(2);
            paiJian.setPrice(0);
            paiJian.setName(tool.getName());
            paiJian.setWuLiaoId(toolId);
            busRepairOrderMapper.savePaiJian(paiJian);
        } else {
            BusRepairPaiJian paiJian = paiJians.get(0);
            paiJian.setAmount(paiJian.getAmount() + amount);
            busRepairOrderMapper.updatePaiJian(paiJian);
        }
        return "领取成功";
    }

    public List<BusRepairPaiJian> getPaiJianByType(Integer id, Integer type) {
        return busRepairOrderMapper.getPaijianByType(id,type);
    }

    /**
     * 完共操作
     * @param id
     * @param list
     * @return
     */
    @Transactional(propagation = Propagation.REQUIRED,rollbackFor = Exception.class)
    public String doComplete(Integer id, List<BusRepairPaiJian> list) {
        BusRepairOrder order = busRepairOrderMapper.get(id);
        if (order.getStatus() != 2) {
            return "当前预约数据状态错误，请刷新数据";
        }
        order.setStatus(3);

        busRepairOrderMapper.updateBusOrderStatus(order);

        List<BusOrderDevice> busOrderDevices = new ArrayList<BusOrderDevice>();
        Integer total = 0;
        for (BusRepairPaiJian pj:list) {
            List<BusRepairPaiJian>  paiJians = busRepairOrderMapper.getPaiJianById(pj.getId());
            if (ObjectUtils.isEmpty(paiJians)) {
                return "配件数据异常";
            }
            BusRepairPaiJian paiJian = paiJians.get(0);
            if (pj.getAmount() > paiJian.getAmount()) {
                return paiJian.getName()+"数量不得大于领用数量";
            } else {
                // 生成销售记录
                if (pj.getAmount() > 0) {
                    BusOrderDevice busOrderDevice = new BusOrderDevice();
                    busOrderDevice.setAmount(pj.getAmount());
                    busOrderDevice.setCreateTime(new Date());
                    busOrderDevice.setName(paiJian.getName());
                    busOrderDevice.setPrice(paiJian.getPrice());
                    busOrderDevice.setUserId(order.getUserId());
                    busOrderDevices.add(busOrderDevice);
                    total += busOrderDevice.getAmount() * busOrderDevice.getPrice();
                }

                if (pj.getAmount() < paiJian.getAmount()) {
                    //入库操作
                    Integer type =1;
                    Integer amount = paiJian.getAmount() - pj.getAmount();
                    BusDevice device =  busDeviceMapper.get(paiJian.getWuLiaoId());
                    if (ObjectUtils.isEmpty(device)) {
                        continue;
                    }
                    Integer balance = device.getBalance();
                    device.setBalance(type == 1 ? (balance + amount) : (balance - amount));
                    Integer count = busDeviceMapper.update(device);
                    if (count <= 0) {
                        return "系统繁忙，请稍后重试";
                    }

                    BusDeviceOperate busDeviceOperate = new BusDeviceOperate();
                    busDeviceOperate.setBalanceAmount(balance);
                    busDeviceOperate.setCreateTime(new Date());
                    busDeviceOperate.setCreateUser(order.getRepairUser());
                    busDeviceOperate.setDeviceId(device.getId());
                    busDeviceOperate.setRemark(type == 1 ? "维修完工配件入库":"手动出库");
                    busDeviceOperate.setOperateAmount(amount);
                    busDeviceOperate.setType(type);
                    busDeviceMapper.saveOperate(busDeviceOperate);
                }
            }
        }

        BusOrder busOrder = new BusOrder();
        busOrder.setCreateTime(new Date());
        busOrder.setOrderNo(System.currentTimeMillis()+"");
        busOrder.setRepairId(order.getId());
        busOrder.setStatus(1);
        busOrder.setTotal(total);
        busOrder.setUserId(order.getUserId());
        busOrderMapper.save(busOrder);
        busOrderMapper.saveDevices(busOrder,busOrderDevices);

        //获取所有的工具
        List<BusRepairPaiJian> paiJians = busRepairOrderMapper.getPaijianByType(order.getId(),2);
        if (!ObjectUtils.isEmpty(paiJians)) {
            //工具入库
            for(BusRepairPaiJian paiJian:paiJians) {
                Integer type = 1;
                Integer amount = paiJian.getAmount();
                BusRepairTool tool =  busRepairToolMapper.get(paiJian.getWuLiaoId());
                if (ObjectUtils.isEmpty(tool)) {
                    continue;
                }
                Integer balance = tool.getBalance();
                tool.setBalance(type == 1 ? (balance + amount) : (balance - amount));
                Integer count = busRepairToolMapper.update(tool);
                if (count <= 0) {
                    return "系统繁忙，请稍后重试";
                }
                BusRepairToolOperate busRepairToolOperate = new BusRepairToolOperate();
                busRepairToolOperate.setBalanceAmount(balance);
                busRepairToolOperate.setCreateTime(new Date());
                busRepairToolOperate.setCreateUser(order.getRepairUser());
                busRepairToolOperate.setToolId(tool.getId());
                busRepairToolOperate.setRemark(type == 1 ? "维修完工工具入库":"手动出库");
                busRepairToolOperate.setOperateAmount(amount);
                busRepairToolOperate.setType(type);
                busRepairToolMapper.saveOperate(busRepairToolOperate);
            }

        }
        return "操作成功";
    }
}
