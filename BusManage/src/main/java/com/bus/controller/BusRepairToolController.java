package com.bus.controller;


import com.bus.model.BusDevice;
import com.bus.model.BusRepairTool;
import com.bus.model.BusUser;
import com.bus.service.ToolService;
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
 * 汽车维修工具controller
 */
@Controller
@RequestMapping(value = "/tool")
public class BusRepairToolController {

    @Autowired
    private ToolService toolService;

    @Autowired
    private  HttpSession session;

    /**
     * 工具列表页面
     * @param map
     * @return
     */
    @RequestMapping(value="/getBusToolList")
    public String getBusToolList(ModelMap map,String name,Integer pageNo,Integer pageSize){
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

        Page<Map<String,Object>> page = toolService.getBusToolList(name,pageNo,pageSize);
        map.put("page",page);
        map.put("pageNo",pageNo);
        map.put("pageSize",pageSize);
        map.put("name",tempName);
        map.put("page",page);
        return "tool/tool";
    }

    /**
     * 新增工具
     * @param map
     * @return
     */
    @RequestMapping(value="/addTool")
    @ResponseBody
    public Object addTool(ModelMap map,String name,Integer balance){
        BusRepairTool tool  = new BusRepairTool();
        if (ObjectUtils.isEmpty(name)) {
            return  "请填写配件名称";
        }
        tool.setBalance(ObjectUtils.isEmpty(balance) ? 0 :balance);
        tool.setName(name);
        tool.setCreateTime(new Date());
        tool.setVersion(0);
        BusUser user = (BusUser) session.getAttribute(CommonConstant.USER);
        tool.setCreateUser(user.getId());
        String msg = toolService.addTool(tool);
        return msg;
    }

    /**
     * 删除工具
     * @param map
     * @return
     */
    @RequestMapping(value="/deleteBusTool")
    @ResponseBody
    public Object deleteBusTool(ModelMap map,Integer id){
        if (ObjectUtils.isEmpty(id)) {
            return  "数据不存在";
        }
        String msg = toolService.deleteBusTool(id);
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
        String msg = toolService.operateChuRuKu(id,amount,type);
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
        String msg = toolService.operateChuRuKu(id,amount,type);
        return msg;
    }



    /**
     * 工具操作记录列表页面
     * @param map
     * @return
     */
    @RequestMapping(value="/getToolOperateList")
    public String getToolOperateList(ModelMap map,String name,Integer pageNo,Integer pageSize){
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

        Page<Map<String,Object>> page = toolService.getToolOperateList(name,pageNo,pageSize);
        map.put("page",page);
        map.put("pageNo",pageNo);
        map.put("pageSize",pageSize);
        map.put("name",tempName);
        map.put("page",page);
        return "device/deviceoperate";
    }

    /**
     * 获取汽车维修工具
     * @param map
     * @return
     */
    @RequestMapping(value="/getToolData")
    @ResponseBody
    public Object getToolData(ModelMap map){

        List<Map<String,Object>> list = toolService.getToolData();
        return list;
    }


}
