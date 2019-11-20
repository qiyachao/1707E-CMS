package com.bw.cms.utils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class MyInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		//自定义拦截规则
		//拦截规则: 1.如果sesssion有 管理员的session.就放行.否则就拦截
		//getSession(false).false:如果request没有session反会null.true:如果没有则创建session.默认true
		HttpSession session = request.getSession(false);
		if(null!=session) {
			//从session 获取admin的对象.如果有则放行
			Object object = session.getAttribute("user");
			if(null!=object)
				return true;//放行
		}
		request.setAttribute("message", "请重新登录后再试");
		request.getRequestDispatcher("/WEB-INF/views/passport/login.jsp").forward(request, response);

		return false;
	}
}
