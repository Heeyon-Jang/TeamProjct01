package com.awoo.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

public class LoginInterceptor implements HandlerInterceptor{

	// 로그인 검증
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		if(session.getAttribute("personalInfoVO") != null) {
			return true;
		}else {
			session.invalidate();
			response.sendRedirect(request.getContextPath()+"/");
			return false;
		}
	}

	
}
