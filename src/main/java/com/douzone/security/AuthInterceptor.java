package com.douzone.security;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.douzone.jblog.vo.UserVo;
import com.douzone.security.Auth.Role;

public class AuthInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		//1. Handler 종류 확인
		if(handler instanceof HandlerMethod == false) {
			return true;
		}
		
		//2. Casting
		HandlerMethod handlerMethod = (HandlerMethod)handler;
		
		//3. Method에 @Auth 받아오기
		Auth auth = handlerMethod.getMethodAnnotation(Auth.class);
		
		//4 Method에 @Auth가 안 붙어 있으면 class(type)의 @Auth 받아오기
		if(auth == null) {
			auth = handlerMethod.getMethod().getDeclaringClass().getAnnotation(Auth.class);
		}
		
		//5. Method에 @Auth가 안 붙어 있으면
		if(auth == null) {
			return true;
		}
		
		//Auth.Role role = auth.value();
		
		//6. @Auth 붙어 있기 때문에 로그인 여부(인증여부)를 확인해야 한다.
		HttpSession session = request.getSession();
		UserVo authUser = (session == null) ? null : (UserVo)session.getAttribute("authUser");
		
		if(authUser == null) {
			response.sendRedirect(request.getContextPath() + "/user/login");
			
			return false;
		}
		
		//7. Role 가져오기(권한, Authentication)
		Role role = auth.value();
		
		//8. User Role 접근이면 인증만 되어 있으면 허용
		if(role == Role.USER) {
			return true;
		}
		
		//9. ADMIN Role 접근
		if("ADMIN".equals("ADMIN") == false){ //"ADMIN".equals(authUser.getRole()) == false
			response.sendRedirect(request.getContextPath() + "/main");
			
			return false;
		}
		
		//5.1 Role 비교 작업
		/*
		if(!"ADMIN".equals(role)) {
			if(!authUser.getRole().equals("ADMIN")) {
				
				response.sendRedirect(request.getContextPath() + "/main");
				
				return false;
			}
		}
		*/
		
		//10. 접근 허용
		return true;
	}

	
}
