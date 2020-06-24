package com.bus.controller;


import com.bus.model.BusDevice;
import com.bus.model.BusUser;
import com.bus.service.DeviceService;
import com.bus.utils.CommonConstant;
import com.bus.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 汽车配件controller
 */
@Controller
@RequestMapping(value = "/device")
public class BusDeviceController {

    @Autowired
    private DeviceService deviceService;

    @Autowired
    private  HttpSession session;

    /**
     * 配件列表页面
     * @param map
     * @return
     */
    @RequestMapping(value="/getBusDeviceList")
    public String getBusDeviceList(ModelMap map,String name,Integer pageNo,Integer pageSize){
        String tempName  = name;
        if (ObjectUtils.isEmpty(pageNo)) {
            pageNo = 1;
        }
        if (ObjectUtils.isEmpty(pageSize)) {
            pageSize = 10;
        }

        if (!ObjectUtils.isEmpty(name)) {
            name = "%"+name+"%";
        }

        Page<Map<String,Object>> page = deviceService.getBusDeviceList(name,pageNo,pageSize);
        map.put("page",page);
        map.put("pageNo",pageNo);
        map.put("pageSize",pageSize);
        map.put("name",tempName);
        map.put("page",page);
        return "device/device";
    }

    /**
     * 新增配件
     * @param map
     * @return
     */
    @RequestMapping(value="/addDevice")
    @ResponseBody
    public Object addDevice(ModelMap map,String name,Integer balance,Integer price){
        BusDevice device  = new BusDevice();
        if (ObjectUtils.isEmpty(name)) {
            return  "请填写配件名称";
        }
        device.setBalance(ObjectUtils.isEmpty(balance) ? 0 :balance);
        device.setName(name);
        device.setCreateTime(new Date());
        device.setVersion(0);
        device.setPrice(price);
        BusUser user = (BusUser) session.getAttribute(CommonConstant.USER);
        device.setCreateUser(user.getId());
        String msg = deviceService.addDevice(device);
        return msg;
    }

    /**
     * 删除配件
     * @param map
     * @return
     */
    @RequestMapping(value="/deleteBusDevice")
    @ResponseBody
    public Object deleteBusDevice(ModelMap map,Integer id){
        if (ObjectUtils.isEmpty(id)) {
            return  "数据不存在";
        }
        String msg = deviceService.deleteBusDevice(id);
        return msg;
    }

    /**
     * 入库操作
     * @param map
     * @return
     */
    @RequestMapping(value="/ruKu")
    @ResponseBody
    public Object ruKu(ModelMap map,Integer id,Integer amount,Integer type){
        if (ObjectUtils.isEmpty(type)) {
            return  "未知操作类型";
        }
        if(ObjectUtils.isEmpty(amount) || amount <= 0) {
           return "操作数量非法";
        }
        if (ObjectUtils.isEmpty(id) ) {
            return  "数据不存在";
        }
        String msg = deviceService.operateChuRuKu(id,amount,type);
        return msg;
    }

    /**
     * 出库操作
     * @param map
     * @return
     */
    @RequestMapping(value="/chuKu")
    @ResponseBody
    public Object chuKu(ModelMap map,Integer id,Integer amount,Integer type){
        if (ObjectUtils.isEmpty(type)) {
            return  "未知操作类型";
        }
        if(ObjectUtils.isEmpty(amount) || amount <= 0) {
            return "操作数量非法";
        }
        if (ObjectUtils.isEmpty(id) ) {
            return  "数据不存在";
        }
        String msg = deviceService.operateChuRuKu(id,amount,type);
        return msg;
    }



    /**
     * 配件操作记录列表页面
     * @param map
     * @return
     */
    @RequestMapping(value="/getDeviceOperateList")
    public String getDeviceOperateList(ModelMap map,String name,Integer pageNo,Integer pageSize){
        String tempName  = name;
        if (ObjectUtils.isEmpty(pageNo)) {
            pageNo = 1;
        }
        if (ObjectUtils.isEmpty(pageSize)) {
            pageSize = 10;
        }

        if (!ObjectUtils.isEmpty(name)) {
            name = "%"+name+"%";
        }

        Page<Map<String,Object>> page = deviceService.getDeviceOperateList(name,pageNo,pageSize);
        map.put("page",page);
        map.put("pageNo",pageNo);
        map.put("pageSize",pageSize);
        map.put("name",tempName);
        map.put("page",page);
        return "device/deviceoperate";
    }

    /**
     * 获取汽车配件
     * @param map
     * @return
     */
    @RequestMapping(value="/getDeviceData")
    @ResponseBody
    public Object getDeviceData(ModelMap map){

        List<Map<String,Object>> list = deviceService.getDeviceData();
        return list;
    }

    /**
     * 配件列表页面
     * @param map
     * @return
     */
    @RequestMapping(value="/getDeviceSellList")
    public String getDeviceSellList(ModelMap map,String name,Integer pageNo,Integer pageSize){
        String tempName  = name;
        if (ObjectUtils.isEmpty(pageNo)) {
            pageNo = 1;
        }
        if (ObjectUtils.isEmpty(pageSize)) {
            pageSize = 10;
        }

        if (!ObjectUtils.isEmpty(name)) {
            name = "%"+name+"%";
        }

        Integer userId = null;
        BusUser user = (BusUser) session.getAttribute(CommonConstant.USER);
        if (user.getRole().equals(3)) {
            userId = user.getId();
        }
        Page<Map<String,Object>> page = deviceService.getDeviceSellList(userId,name,pageNo,pageSize);
        map.put("page",page);
        map.put("pageNo",pageNo);
        map.put("pageSize",pageSize);
        map.put("name",tempName);
        map.put("page",page);
        return "device/sell";
    }
}
