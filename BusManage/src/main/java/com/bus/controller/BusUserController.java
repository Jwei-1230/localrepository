package com.bus.controller;


import com.bus.model.BusUser;
import com.bus.service.BusUserService;
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
 * 系统用户controller
 */
@Controller
@RequestMapping(value = "/user")
public class BusUserController {

    @Autowired
    private BusUserService busUserService;

    @Autowired
    private  HttpSession session;

    /**
     * 用户列表页面
     * @param map
     * @param name 用户姓名
     * @param phone 联系方式
     * @param type
     * @return
     */
    @RequestMapping(value="/getBusUserList")
    public String getBusUserList(ModelMap map,String name,String phone,Integer pageNo,Integer pageSize,Integer type){
        String tempName  = name;
        String tempPhone = phone;
        if (ObjectUtils.isEmpty(pageNo)) {
            pageNo = 1;
        }
        if (ObjectUtils.isEmpty(pageSize)) {
            pageSize = 10;
        }

        if (!ObjectUtils.isEmpty(name)) {
            name = "%"+name+"%";
        }

        if (!ObjectUtils.isEmpty(phone)) {
            phone = "%"+phone+"%";
        }

        BusUser user = (BusUser) session.getAttribute(CommonConstant.USER);
        Integer userId = null;
        if (!user.getRole().equals(1)) {
            userId = user.getId();
        }

        Page<Map<String,Object>> page = busUserService.getBusUserList(name,userId,phone,pageNo,pageSize);
        map.put("page",page);
        map.put("pageNo",pageNo);
        map.put("pageSize",pageSize);
        map.put("name",tempName);
        map.put("phone",tempPhone);
        map.put("page",page);
        map.put("type",type);
        return "user/user";
    }

    /**
     * 新增用户
     * @param map
     * @return
     */
    @RequestMapping(value="/addUser")
    @ResponseBody
    public Object addUser(ModelMap map,BusUser user){
        user.setDelFlag(0);
        user.setCreateTime(new Date());
        String msg = busUserService.addUser(user);
        return msg;
    }

    /**
     * 更新用户
     * @param user
     * @param oldPwd  旧密码
     * @return
     */
    @RequestMapping(value="/updateUser")
    @ResponseBody
    public Object updateUser(ModelMap map,BusUser user,String oldPwd){
        BusUser ses = (BusUser) session.getAttribute(CommonConstant.USER);
        if (!ses.getRole().equals(1) && ObjectUtils.isEmpty(oldPwd) && !ObjectUtils.isEmpty(user.getPassWord())) {
            return "请输入原密码";
        }
        if (!ses.getRole().equals(1)&&!oldPwd.equals(ses.getPassWord())) {
            return "您原始密码输入不正确";
        }
        String msg = busUserService.updateUser(user);
        return msg;
    }

    /**
     * 删除用户
     * @param map
     * @return
     */
    @RequestMapping(value="/deleteBusUser")
    @ResponseBody
    public Object deleteBusUser(ModelMap map,Integer id){
        if (ObjectUtils.isEmpty(id)) {
            return  "数据不存在";
        }
        String msg = busUserService.deleteBusUser(id);
        return msg;
    }

    /**
     * 获取指定角色用户数据
     * @param role 1管理员 2维修工 3用户
     * @return
     */
    @RequestMapping(value="/getUserByRole")
    @ResponseBody
    public Object getUserByRole(ModelMap map,Integer role){
        List<Map<String,Object>> list = busUserService.getUserByRole(role);
        return list;
    }

}
