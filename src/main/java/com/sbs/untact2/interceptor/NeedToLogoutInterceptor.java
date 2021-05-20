package com.sbs.untact2.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.sbs.untact2.dto.Rq;
import com.sbs.untact2.util.Util;

import lombok.extern.slf4j.Slf4j;

@Component // 컴포넌트 이름 설정
@Slf4j
public class NeedToLogoutInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp, Object handler) throws Exception {
		//Rq 꺼내기
		Rq rq = (Rq)req.getAttribute("rq");
		
		//if 로그인 상태가 아니면
		 if (rq.isLogined()) {
			 String resultCode = "F-B";
	            String resultMsg = "로그아웃 후 이용해주세요.";

	            if ( rq.isAjax() ) {
	                resp.setContentType("application/json; charset=UTF-8");
	                resp.getWriter().append("{\"resultCode\":\"" + resultCode + "\",\"msg\":\"" + resultMsg + "\"}");
	            }
	            else {
	                resp.setContentType("text/html; charset=UTF-8");
	                resp.getWriter().append(Util.msgAndBack(resultMsg));
	            }
	            return false;

		 }
		return HandlerInterceptor.super.preHandle(req, resp, handler);
	}
}