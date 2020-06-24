package com.bus.controller;


import com.bus.model.BusInfo;
import com.bus.model.BusUser;
import com.bus.service.BusInfoService;
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
 * 用户车辆controller
 */
@Controller
@RequestMapping(value = "/bus")
public class BusInfoController {

    @Autowired
    private BusInfoService busInfoService;

    @Autowired
    private  HttpSession session;

    /**
     * 车辆列表页面
     * @param map
     * @param name 用户姓名
     * @param busName 车名称
     * @return
     */
    @RequestMapping(value="/getBusList")
    public String getBusList(ModelMap map,String name,String busName,Integer pageNo,Integer pageSize,Integer userId){
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
            userId = user.getId();
        }

        Page<Map<String,Object>> page = busInfoService.getBusList(name,userId,busName,pageNo,pageSize);
        map.put("page",page);
        map.put("pageNo",pageNo);
        map.put("pageSize",pageSize);
        map.put("name",tempName);
        map.put("busName",tempPhone);
        map.put("page",page);
        return "user/bus";
    }

    /**
     * 新增车辆
     * @param map
     * @return
     */
    @RequestMapping(value="/addBus")
    @ResponseBody
    public Object addBus(ModelMap map, BusInfo info){
        BusUser user = (BusUser) session.getAttribute(CommonConstant.USER);
        info.setDelFlag(0);
        info.setUserId(user.getId());
        info.setCreateTime(new Date());
        String msg = busInfoService.addBus(info);
        return msg;
    }

    /**
     * 更新车辆
     * @param info
     * @return
     */
    @RequestMapping(value="/updateBus")
    @ResponseBody
    public Object updateBus(ModelMap map,BusInfo info){
        String msg = busInfoService.updateBus(info);
        return msg;
    }

    /**
     * 删除车辆
     * @param map
     * @return
     */
    @RequestMapping(value="/deleteBus")
    @ResponseBody
    public Object deleteBus(ModelMap map,Integer id){
        if (ObjectUtils.isEmpty(id)) {
            return  "数据不存在";
        }
        String msg = busInfoService.deleteBus(id);
        return msg;
    }

    /**
     * 删除车辆
     * @param map
     * @return
     */
    @RequestMapping(value="/getBusByUserId")
    @ResponseBody
    public Object getBusByUserId(ModelMap map){
        BusUser user = (BusUser) session.getAttribute(CommonConstant.USER);
        List<Map<String,Object>> list =  busInfoService.getBusByUserId(user.getId());
        return list;
    }
}
