package com.bus.config;

import com.bus.model.BusUser;
import com.bus.utils.CommonConstant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.lang.Nullable;
import org.springframework.util.ObjectUtils;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Configuration
public class LoginInterceptor implements HandlerInterceptor {

    @Autowired
    private HttpSession session;

    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        Object user = session.getAttribute(CommonConstant.USER);
        System.out.println(request.getRequestURL());
        if (ObjectUtils.isEmpty(user)) {
            response.sendRedirect(request.getContextPath()+"/login/login");
            return false;
            /*BusUser temp = new BusUser();
            temp.setId(1);
            temp.setRole(1);
            temp.setRealName("管理员");
            session.setAttribute(CommonConstant.USER,temp);*/
        }
        return true;
    }

    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, @Nullable ModelAndView modelAndView) throws Exception {
    }

    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, @Nullable Exception ex) throws Exception {
    }
}
