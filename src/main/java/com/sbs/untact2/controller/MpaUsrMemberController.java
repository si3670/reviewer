package com.sbs.untact2.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbs.untact2.dto.Member;
import com.sbs.untact2.dto.ResultData;
import com.sbs.untact2.service.MemberService;
import com.sbs.untact2.util.Util;

@Controller
public class MpaUsrMemberController {
	@Autowired
	private MemberService memberService;

	@RequestMapping("/mpaUsr/member/join")
	public String showJoin() {
		return "mpaUsr/member/join";
	}


	@RequestMapping("/mpaUsr/member/doJoin")
	public String doJoin(HttpServletRequest req, @RequestParam Map<String, Object> param) {
		if (param.get("loginId") == null) {
			return Util.msgAndBack(req, "loginId을 입력해주세요.");
		}
		
		Member oldMember = memberService.getMemberByLoginId((String)param.get("loginId"));

		if (oldMember != null) {
			return Util.msgAndBack(req, "이미 사용 중인 아이디입니다.");
		}

		if (param.get("loginPw") == null) {
			return Util.msgAndBack(req, "loginPw을 입력해주세요.");
		}
		if (param.get("name") == null) {
			return Util.msgAndBack(req, "name을 입력해주세요.");
		}
		if (param.get("nickname") == null) {
			return Util.msgAndBack(req, "nickname을 입력해주세요.");
		}
		if (param.get("cellphoneNo") == null) {
			return Util.msgAndBack(req, "cellphoneNo을 입력해주세요.");
		}
		if (param.get("email") == null) {
			return Util.msgAndBack(req, "email을 입력해주세요.");
		}
		ResultData addMemberRd = memberService.addMember(param);
		
		if(addMemberRd.isFail()) {
			return Util.msgAndBack(req, addMemberRd.getMsg());
		}

		return Util.msgAndReplace(req,addMemberRd.getMsg(), "/");
	}
	
	
	@RequestMapping("/mpaUsr/member/login")
	public String showLogin() {
		return "mpaUsr/member/login";
	}


	@RequestMapping("/mpaUsr/member/doLogin")
	public String doLogin(HttpServletRequest req, HttpSession session, String loginId, String loginPw, String replaceUrl) {
		Member member = memberService.getMemberByLoginId(loginId);

		if (member == null) {
			return Util.msgAndBack(req, "존재하지 않는 아이디입니다.");
		}
		
		if(member.getLoginPw().equals(loginPw) == false) {
			return Util.msgAndBack(req, "loginPw을 확인해주세요.");
		}
		
		session.setAttribute("loginedMemberId", member.getId());
		
		String msg = "환영합니다.";
		return Util.msgAndReplace(req, msg, replaceUrl);
	}
	
	@RequestMapping("/mpaUsr/member/doLogout")
	public String doLogout(HttpServletRequest req, HttpSession session) {		
		session.removeAttribute("loginedMemberId");

		return Util.msgAndReplace(req, "로그아웃 되었습니다.", "/");
	}

}
