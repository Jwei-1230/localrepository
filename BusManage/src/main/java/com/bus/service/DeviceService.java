package com.bus.service;

import com.bus.dao.BusDeviceMapper;
import com.bus.model.BusDevice;
import com.bus.model.BusDeviceOperate;
import com.bus.model.BusUser;
import com.bus.utils.CommonConstant;
import com.bus.utils.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ObjectUtils;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 汽车配件
 */
@Service
public class DeviceService {

    @Autowired
    private BusDeviceMapper busDeviceMapper;

    @Autowired
    private HttpSession session;

    /**
     * 分页查询
     * @param name 配件名称
     * @param pageNo 当前页
     * @param pageSize 每页大小
     * @return
     */
    public Page<Map<String, Object>> getBusDeviceList(String name, Integer pageNo, Integer pageSize) {
        PageHelper.startPage(pageNo, pageSize);
        List<Map<String, Object>> list = busDeviceMapper.getBusDeviceList(name);
        Page<Map<String, Object>> page = new Page<Map<String, Object>>();
        PageInfo<Map<String, Object>> info = new PageInfo<Map<String, Object>>(list);
        page.setPageNo(pageNo);
        page.setPageSize(pageSize);
        page.setResults(list);
        page.setTotalPage(info.getPages());
        page.setTotalRecord(info.getTotal());
        return page;
    }

    /**
     * 新增配件
     * @param device
     * @return
     */
    @Transactional
    public String addDevice(BusDevice device) {
        Integer count = busDeviceMapper.countDeviceByName(device.getName());
        if (!ObjectUtils.isEmpty(count) && count > 0) {
            return device.getName()+"已经存在，请更改名称";
        }
        busDeviceMapper.save(device);
        if (!ObjectUtils.isEmpty(device.getBalance()) && device.getBalance() > 0) {
            BusDeviceOperate busDeviceOperate = new BusDeviceOperate();
            busDeviceOperate.setBalanceAmount(0);
            busDeviceOperate.setCreateTime(new Date());
            busDeviceOperate.setCreateUser(device.getCreateUser());
            busDeviceOperate.setDeviceId(device.getId());
            busDeviceOperate.setRemark("初始入库");
            busDeviceOperate.setOperateAmount(device.getBalance());
            busDeviceOperate.setType(1);
            busDeviceMapper.saveOperate(busDeviceOperate);
        }
        return "新增配件成功";
    }

    /**
     * 配件操作记录
     * @param name
     * @param pageNo
     * @param pageSize
     * @return
     */
    public Page<Map<String, Object>> getDeviceOperateList(String name, Integer pageNo, Integer pageSize) {
        PageHelper.startPage(pageNo, pageSize);
        List<Map<String, Object>> list = busDeviceMapper.getDeviceOperateList(name);
        Page<Map<String, Object>> page = new Page<Map<String, Object>>();
        PageInfo<Map<String, Object>> info = new PageInfo<Map<String, Object>>(list);
        page.setPageNo(pageNo);
        page.setPageSize(pageSize);
        page.setResults(list);
        page.setTotalPage(info.getPages());
        page.setTotalRecord(info.getTotal());
        return page;
    }

    /**
     * 删除配件
     * @param id
     * @return
     */
    @Transactional
    public String deleteBusDevice(Integer id) {
        busDeviceMapper.delete(id);
        busDeviceMapper.deleteOperate(id);
        return "删除成功";
    }

    /**
     * 出入库操作
     * @param id
     * @param amount
     * @param type 1 入库 2出库
     * @return
     */
    @Transactional
    public String operateChuRuKu(Integer id, Integer amount,Integer type) {
       BusDevice device =  busDeviceMapper.get(id);
        BusUser user = (BusUser) session.getAttribute(CommonConstant.USER);
       if (ObjectUtils.isEmpty(device)) {
           return "设备数据不存在";
       }
       if (type == 2) {
           //出库操作,
           if (amount > device.getBalance()) {
               return "库存数量不足，无法出库";
           }
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
        busDeviceOperate.setCreateUser(user.getId());
        busDeviceOperate.setDeviceId(device.getId());
        busDeviceOperate.setRemark(type == 1 ? "手动入库":"手动出库");
        busDeviceOperate.setOperateAmount(amount);
        busDeviceOperate.setType(type);
        busDeviceMapper.saveOperate(busDeviceOperate);

        return type == 1 ? "入库成功":"出库成功";
    }


    public List<Map<String, Object>> getDeviceData() {
        return busDeviceMapper.getDeviceData();
    }

    public Page<Map<String, Object>> getDeviceSellList(Integer userId, String name, Integer pageNo, Integer pageSize) {
        PageHelper.startPage(pageNo, pageSize);
        List<Map<String, Object>> list = busDeviceMapper.getDeviceSellList(name,userId);
        Page<Map<String, Object>> page = new Page<Map<String, Object>>();
        PageInfo<Map<String, Object>> info = new PageInfo<Map<String, Object>>(list);
        page.setPageNo(pageNo);
        page.setPageSize(pageSize);
        page.setResults(list);
        page.setTotalPage(info.getPages());
        page.setTotalRecord(info.getTotal());
        return page;
    }
}
