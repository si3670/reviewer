package com.sbs.untact2.dto;

import java.util.Map;

import com.sbs.untact2.util.Util;

import lombok.Getter;

public class Rq {
	@Getter
	private boolean isAjax;
	@Getter
	private boolean isAdmin;
	private String currentUrl;
	@Getter
	private String currentUri;
	private Member loginedMember;
	private Map<String, String> paramMap;
	@Getter
	private boolean needToChangePassword;

	public Rq(boolean isAjax, boolean isAdmin, Member loginedMember, String currentUri, Map<String, String> paramMap,
			boolean needToChangePassword) {
		this.isAjax = isAjax;
		this.isAdmin = isAdmin;
		this.loginedMember = loginedMember;

		// test
		this.currentUrl = currentUri.split("\\?")[0];
		// test?ab=c3&&bb=2
		this.currentUri = currentUri;

		this.paramMap = paramMap;
		this.needToChangePassword = needToChangePassword;
	}

	public String getParamJsonStr() {
		return Util.toJsonStr(paramMap);
	}

	public boolean isNotAdmin() {
		return isAdmin == false;
	}

	public boolean isLogined() {
		return loginedMember != null;
	}

	public boolean isNotLogined() {
		return isLogined() == false;
	}

	public int getLoginedMemberId() {
		if (isNotLogined())
			return 0;
		return loginedMember.getId();
	}

	public Member getLoginedMember() {
		return loginedMember;
	}

	public String getLoginedMemberNickname() {
		if (isNotLogined())
			return "";

		return loginedMember.getNickname();
	}

	public String getEncodedcurrentUri() {
		return Util.getUriEncoded(getcurrentUri());
	}

	public String getcurrentUri() {
		return currentUri;
	}

	public String getLoginPageUri() {
		String afterLoginUri;

		if (isLoginPage()) {
			afterLoginUri = "";
		} else {
			afterLoginUri = getEncodedcurrentUri();
		}

		return "../member/login?afterLoginUri=" + afterLoginUri;
	}

	private boolean isLoginPage() {
		return currentUrl.equals("/mpaUsr/member/login");
	}

}
