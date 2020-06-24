package com.bus.controller;


import com.bus.model.BusUser;
import com.bus.service.BusFinanceService;
import com.bus.utils.CommonConstant;
import com.bus.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Map;

/**
 * 预约订单controller
 */
@Controller
@RequestMapping(value = "/finance")
public class BusFinanceController {
    @Autowired
    private BusFinanceService busFinanceService;

    @Autowired
    private HttpSession session;

    /**
     * 结算单列表页面
     * @param map
     * @return
     */
    @RequestMapping(value="/getCompleteOrderList")
    public String getCompleteOrderList(ModelMap map, String name,String orderNo, Integer pageNo, Integer pageSize,Integer type){
        String tempName  = name;
        String tempOrder = orderNo;
        if (ObjectUtils.isEmpty(pageNo)) {
            pageNo = 1;
        }
        if (ObjectUtils.isEmpty(pageSize)) {
            pageSize = 10;
        }

        if (!ObjectUtils.isEmpty(name)) {
            name = "%"+name+"%";
        }
        if (!ObjectUtils.isEmpty(orderNo)) {
            orderNo = "%"+orderNo+"%";
        }
        Integer userId = null;
        BusUser user = (BusUser) session.getAttribute(CommonConstant.USER);
        if (user.getRole().equals(3)) {
            userId = user.getId();
        }
        Page<Map<String,Object>> page = busFinanceService.getCompleteOrderList(userId,name,orderNo,pageNo,pageSize);
        map.put("page",page);
        map.put("pageNo",pageNo);
        map.put("pageSize",pageSize);
        map.put("name",tempName);
        map.put("orderNo",tempOrder);
        map.put("page",page);
        map.put("type",type);
        return "finance/finance";
    }

    /**
     * 完成结算
     * @param map
     * @return
     */
    @RequestMapping(value="/doJieSuan")
    @ResponseBody
    public Object doJieSuan(ModelMap map,Integer id){
        if (ObjectUtils.isEmpty(id)) {
            return  "数据不存在";
        }
        String msg = busFinanceService.doJieSuan(id);
        return msg;
    }

    /**
     * 获取欠款
     * @param map
     * @return
     */
    @RequestMapping(value="/getQiKuanList")
    public String getQiKuanList(ModelMap map, String name,Integer pageNo, Integer pageSize,Integer type){
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
        Page<Map<String,Object>> page = busFinanceService.getQiKuanList(userId,name,pageNo,pageSize);
        map.put("page",page);
        map.put("pageNo",pageNo);
        map.put("pageSize",pageSize);
        map.put("name",tempName);
        map.put("page",page);
        map.put("type",type);
        return "finance/qikuan";
    }

    /**
     * 完成所有的欠款结算
     * @param map
     * @param id  用户id
     * @return
     */
    @RequestMapping(value="/doJieSuanAll")
    @ResponseBody
    public Object doJieSuanAll(ModelMap map,Integer id){
        if (ObjectUtils.isEmpty(id)) {
            return  "数据不存在";
        }
        String msg = busFinanceService.doJieSuanAll(id);
        return msg;
    }

    /**
     * 结算单列表页面
     * @param map
     * @return
     */
    @RequestMapping(value="/getYuShouKuanList")
    public String getYuShouKuanList(ModelMap map, String name,String orderNo, Integer pageNo, Integer pageSize){
        String tempName  = name;
        String tempOrder = orderNo;
        if (ObjectUtils.isEmpty(pageNo)) {
            pageNo = 1;
        }
        if (ObjectUtils.isEmpty(pageSize)) {
            pageSize = 10;
        }

        if (!ObjectUtils.isEmpty(name)) {
            name = "%"+name+"%";
        }
        if (!ObjectUtils.isEmpty(orderNo)) {
            orderNo = "%"+orderNo+"%";
        }
        Integer userId = null;
        BusUser user = (BusUser) session.getAttribute(CommonConstant.USER);
        if (user.getRole().equals(3)) {
            userId = user.getId();
        }
        Page<Map<String,Object>> page = busFinanceService.getYuShouKuanList(userId,name,orderNo,pageNo,pageSize);
        map.put("page",page);
        map.put("pageNo",pageNo);
        map.put("pageSize",pageSize);
        map.put("name",tempName);
        map.put("orderNo",tempOrder);
        map.put("page",page);
        return "finance/yushoukuan";
    }
}
