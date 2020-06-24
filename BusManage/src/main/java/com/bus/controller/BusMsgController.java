package com.bus.controller;


import com.bus.model.BusMsg;
import com.bus.model.BusUser;
import com.bus.service.BusMsgService;
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
import java.util.Map;

/**
 * 留言留言controller
 */
@Controller
@RequestMapping(value = "/msg")
public class BusMsgController {

    @Autowired
    private BusMsgService busMsgService;

    @Autowired
    private  HttpSession session;

    /**
     * 留言列表页面
     * @param map
     * @param name 留言姓名
     * @param content 留言内容
     * @return
     */
    @RequestMapping(value="/getBusMsgList")
    public String getBusMsgList(ModelMap map,String name,String content,Integer pageNo,Integer pageSize,Integer userId){
        String tempName  = name;
        String tempContent = content;
        if (ObjectUtils.isEmpty(pageNo)) {
            pageNo = 1;
        }
        if (ObjectUtils.isEmpty(pageSize)) {
            pageSize = 10;
        }

        if (!ObjectUtils.isEmpty(name)) {
            name = "%"+name+"%";
        }

        if (!ObjectUtils.isEmpty(content)) {
            content = "%"+content+"%";
        }

        BusUser user = (BusUser) session.getAttribute(CommonConstant.USER);
        if (!user.getRole().equals(1)) {
            userId = user.getId();
        }

        Page<Map<String,Object>> page = busMsgService.getBusMsgList(name,userId,content,pageNo,pageSize);
        map.put("page",page);
        map.put("pageNo",pageNo);
        map.put("pageSize",pageSize);
        map.put("name",tempName);
        map.put("content",tempContent);
        map.put("page",page);
        return "user/msg";
    }

    /**
     * 新增留言
     * @param map
     * @return
     */
    @RequestMapping(value="/addMsg")
    @ResponseBody
    public Object addMsg(ModelMap map, BusMsg msg){
        BusUser user = (BusUser) session.getAttribute(CommonConstant.USER);
        msg.setUserId(user.getId());
        msg.setCreateTime(new Date());
        String msgg = busMsgService.addMsg(msg);
        return msgg;
    }

    /**
     * 更新留言
     * @param msg
     * @return
     */
    @RequestMapping(value="/updateMsg")
    @ResponseBody
    public Object updateMsg(ModelMap map,BusMsg msg){
        String msgg = busMsgService.updateMsg(msg);
        return msgg;
    }

    /**
     * 删除留言
     * @param map
     * @return
     */
    @RequestMapping(value="/deleteMsg")
    @ResponseBody
    public Object deleteMsg(ModelMap map,Integer id){
        if (ObjectUtils.isEmpty(id)) {
            return  "数据不存在";
        }
        String msg = busMsgService.deleteMsg(id);
        return msg;
    }

}
