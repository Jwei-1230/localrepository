package com.bus.controller;


import com.bus.model.BusRepairOrder;
import com.bus.model.BusRepairPaiJian;
import com.bus.model.BusUser;
import com.bus.service.BusOrderService;
import com.bus.utils.CommonConstant;
import com.bus.utils.Page;
import com.google.gson.Gson;
import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 预约订单controller
 */
@Controller
@RequestMapping(value = "/order")
public class BusOrderController {

    @Autowired
    private BusOrderService busOrderService;

    @Autowired
    private  HttpSession session;

    /**
     * 预约列表页面
     * @param map
     * @param name 用户姓名
     * @param busName 车名称
     * @return
     */
    @RequestMapping(value="/getBusOrderList")
    public String getBusOrderList(ModelMap map,String name,String busName,Integer pageNo,Integer pageSize,Integer role,Integer type){
        String tempName  = name;
        String tempPhone = busName;
        if (ObjectUtils.isEmpty(pageNo)) {
            pageNo = 1;
        }
        if (ObjectUtils.isEmpty(pageSize)) {
            pageSize = 10;
        }

        if (!ObjectUtils.isEmpty(name)) {
            name = "%"+name+"%";
        }

        if (!ObjectUtils.isEmpty(busName)) {
            busName = "%"+busName+"%";
        }

        BusUser user = (BusUser) session.getAttribute(CommonConstant.USER);
        if (!user.getRole().equals(1)) {
            role = user.getRole();
        }
        Integer userId = null;
        Integer workerId = null;
        switch (user.getRole()) {
            case 1:
                break;
            case 2://维修工人
                workerId = user.getId();
                break;
            case 3://客户
                userId = user.getId();
                break;
        }


        Page<Map<String,Object>> page = busOrderService.getBusOrderList(userId,workerId,name,role,busName,pageNo,pageSize,type);
        map.put("page",page);
        map.put("pageNo",pageNo);
        map.put("pageSize",pageSize);
        map.put("name",tempName);
        map.put("busName",tempPhone);
        map.put("page",page);
        map.put("type",type);
        return "order/order";
    }

    /**
     * 新增预约
     * @param map
     * @return
     */
    @RequestMapping(value="/addBusOrder")
    @ResponseBody
    public Object addBusOrder(ModelMap map, BusRepairOrder order){
        BusUser user = (BusUser) session.getAttribute(CommonConstant.USER);
        order.setDelFlag(0);
        order.setUserId(user.getId());
        order.setCreateTime(new Date());
        order.setStatus(1);
        order.setPayStatus(1);
        String msg = busOrderService.addBusOrder(order);
        return msg;
    }

    /**
     * 更新预约
     * @param order
     * @return
     */
    @RequestMapping(value="/updateBusOrder")
    @ResponseBody
    public Object updateBusOrder(ModelMap map,BusRepairOrder order){
        String msg = busOrderService.updateBusOrder(order);
        return msg;
    }

    /**
     * 派遣
     * @param order
     * @return
     */
    @RequestMapping(value="/updateBusOrderRepairUser")
    @ResponseBody
    public Object updateBusOrderRepairUser(ModelMap map,BusRepairOrder order){
        String msg = busOrderService.updateBusOrderRepairUser(order);
        return msg;
    }



    /**
     * 删除预约
     * @param map
     * @return
     */
    @RequestMapping(value="/deleteBusOrder")
    @ResponseBody
    public Object deleteBusOrder(ModelMap map,Integer id){
        if (ObjectUtils.isEmpty(id)) {
            return  "数据不存在";
        }
        String msg = busOrderService.deleteBusOrder(id);
        return msg;
    }

    /**
     * 维修领用汽车配件
     * @param map
     * @return
     */
    @RequestMapping(value="/doLingYongDevice")
    @ResponseBody
    public Object doLingYongDevice(ModelMap map,Integer id,Integer amount,Integer deviceId){
        String msg = busOrderService.doLingYongDevice(id,amount,deviceId);
        return msg;
    }

    /**
     * 维修领用工具
     * @param map
     * @return
     */
    @RequestMapping(value="/doLingYongTool")
    @ResponseBody
    public Object doLingYongTool(ModelMap map,Integer id,Integer amount,Integer toolId){
        String msg = busOrderService.doLingYongTool(id,amount,toolId);
        return msg;
    }

    @RequestMapping(value="/getPaiJianByType")
    @ResponseBody
    public Object getPaiJianByType(ModelMap map,Integer id,Integer type){

        List<BusRepairPaiJian> paiJians = busOrderService.getPaiJianByType(id,type);
        return paiJians;
    }

    @RequestMapping(value="/doComplete")
    @ResponseBody
    public Object doComplete(ModelMap map,Integer id,String p){
        com.google.gson.Gson gson = new Gson();
        PaiJian paiJian = gson.fromJson(p, PaiJian.class);
        String msg = busOrderService.doComplete(id,paiJian.getList());
        return msg;
    }

    @Data
    class PaiJian {
        private List<BusRepairPaiJian> list = new ArrayList<BusRepairPaiJian>();
    }


}
