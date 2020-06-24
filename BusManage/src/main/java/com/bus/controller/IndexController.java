package com.bus.controller;

import com.bus.utils.CommonConstant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import javax.servlet.http.HttpSession;

/**
 * 首页的controller
 */
@Controller
@RequestMapping(value = "/")
public class IndexController {

    @Autowired
    private HttpSession session;

    /**
     * 进入主页
     * @param map
     * @return
     */
    @RequestMapping(value="/")
    public String index(ModelMap map){
        Object obj = session.getAttribute(CommonConstant.USER);
        if (ObjectUtils.isEmpty(obj)) {
            return "login";
        }else{
            return "index";
        }
    }

    /**
     * 首页
     * @return
     */
    @RequestMapping(value="/main")
    public String main() {
        return "main";
    }

}
