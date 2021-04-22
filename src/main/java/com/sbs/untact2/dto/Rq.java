package com.sbs.untact2.dto;

import javax.servlet.http.HttpServletRequest;

public class Rq {
	private Member loginedMember;

	public Rq(Member loginedMember) {
		this.loginedMember = loginedMember;
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
}
