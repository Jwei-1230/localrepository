package com.bus.controller;

import com.bus.model.BusUser;
import com.bus.service.BusUserService;
import com.bus.utils.CommonConstant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * 登陆的controller
 */
@Controller
@RequestMapping(value = "/login")
public class LoginController {

    @Autowired
    private HttpSession session;
    @Autowired
    private BusUserService busUserService;
    @Autowired
    private HttpServletRequest request;

    /**
     * 进入登陆页面
     * @param map
     * @return
     */
    @RequestMapping(value="/login")
    public String login(ModelMap map){
        Object obj = session.getAttribute(CommonConstant.USER);
        if (ObjectUtils.isEmpty(obj)) {
            return "login";
        }else{
            return "redirect:/index";
        }
    }

    /**
     * 执行登陆
     * @param userName 用户名
     * @param passWord 密码
     * @return
     */
    @RequestMapping(value="/doLogin")
    public String doLogin(String userName,String passWord){

        List<BusUser> users = busUserService.getUserByUserName(userName);
        if (ObjectUtils.isEmpty(users) || users.size() != 1) {
            request.setAttribute("msg","用户名/密码不正确");
            return "login";
        }

        BusUser acc = users.get(0);
        if (!acc.getPassWord().equals(passWord)) {
            request.setAttribute("msg","用户名/密码不正确");
            return "login";
        }

        session.setAttribute(CommonConstant.USER,acc);
        return "redirect:/";
    }

    /**
     * 退出登陆
     * @return
     */
    @RequestMapping(value="/doLogOut")
    public String doLogOut(){
        session.removeAttribute(CommonConstant.USER);
        return "redirect:/";
    }

}
