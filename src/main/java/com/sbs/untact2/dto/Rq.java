package com.sbs.untact2.dto;

import com.sbs.untact2.util.Util;

public class Rq {
	private String currentUrl;
	private String currentUri;
	private Member loginedMember;

	public Rq(Member loginedMember, String currentUri) {
		this.loginedMember = loginedMember;
		// test
		this.currentUrl = currentUri.split("\\?")[0];
		// test?ab=c3&&bb=2
		this.currentUri = currentUri;
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
