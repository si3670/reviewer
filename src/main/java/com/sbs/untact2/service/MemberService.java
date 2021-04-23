package com.sbs.untact2.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.untact2.dao.MemberDao;
import com.sbs.untact2.dto.Member;
import com.sbs.untact2.dto.ResultData;
import com.sbs.untact2.util.Util;

@Service
public class MemberService {
	@Autowired
	private MemberDao memberDao;

	public Member getMemberByLoginId(String loginId) {
		return memberDao.getMemberByLoginId(loginId);
	}

	public ResultData addMember(Map<String, Object> param) {
		memberDao.addMember(param);
		int id = Util.getAsInt(param.get("id"), 0);
		return new ResultData("P-1", "가입 성공", "id", id);
	}

	public Member getMemberById(int id) {
		return memberDao.getMemberById(id);
	}

	public Member getMemberByNameAndEmail(String name, String email) {
		return memberDao.getMemberByNameAndEmail(name, email);
	}

	public ResultData modifyMemberRd(Map<String, Object> param) {
		memberDao.modifyMemberRd(param);
		return new ResultData("P-1", "수정 성공");
	}

}
