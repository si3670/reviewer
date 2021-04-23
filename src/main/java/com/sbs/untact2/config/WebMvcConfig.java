package com.sbs.untact2.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.sbs.untact2.interceptor.BeforeActionInterceptor;
import com.sbs.untact2.interceptor.NeedToLoginInterceptor;
import com.sbs.untact2.interceptor.NeedToLogoutInterceptor;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {
	// beforeActionInterceptor 인터셉터 불러오기
	@Autowired
	BeforeActionInterceptor beforeActionInterceptor;

	@Autowired
	NeedToLoginInterceptor needToLoginInterceptor;

	@Autowired
	NeedToLogoutInterceptor needToLogoutInterceptor;

	// 이 함수는 인터셉터를 적용하는 역할을 합니다.
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		// beforeActionInterceptor 인터셉터가 모든 액션 실행전에 실행되도록 처리
		registry.addInterceptor(beforeActionInterceptor).addPathPatterns("/**").excludePathPatterns("/resource/**")
				.excludePathPatterns("/error");

		// needtologin인터셉터에게 확인하도록 넘기기
		// 로그인 없이도 접속할수 있는 url 전부 기술 exclude
		// 로그인 있어야만 접속할수 있는 url 전부 기술 add
		registry.addInterceptor(needToLoginInterceptor).addPathPatterns("/mpaUsr/article/write")
				.addPathPatterns("/mpaUsr/article/dowrite").addPathPatterns("/mpaUsr/article/doDelete")
				.addPathPatterns("/mpaUsr/article/modify").addPathPatterns("/mpaUsr/article/doModify")
				.addPathPatterns("/mpaUsr/member/doMyPage").addPathPatterns("/mpaUsr/member/myPage");

		// needtologout인터셉터에게 확인하도록 넘기기
		registry.addInterceptor(needToLogoutInterceptor).addPathPatterns("/mpaUsr/member/login")
				.addPathPatterns("/mpaUsr/member/doLogin").addPathPatterns("/mpaUsr/member/join")
				.addPathPatterns("/mpaUsr/member/doJoin").addPathPatterns("/mpaUsr/member/findLoginInfo")
				.addPathPatterns("/mpaUsr/member/doFindLoginId").addPathPatterns("/mpaUsr/member/doFindLoginPw");
	}
}