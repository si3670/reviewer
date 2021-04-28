package com.sbs.untact2.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sbs.untact2.dto.Member;
import com.sbs.untact2.dto.ResultData;
import com.sbs.untact2.dto.Rq;
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
	public String doJoin(HttpServletRequest req, String loginId, String loginPw, String name, String nickname, String cellphoneNo, String email) {		
		Member oldMember = memberService.getMemberByLoginId(loginId);

		if (oldMember != null) {
			return Util.msgAndBack(req, "이미 사용 중인 아이디입니다.");
		}

		ResultData addMemberRd = memberService.addMember(loginId, loginPw, name, nickname, cellphoneNo, email);
		
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
	public String doLogin(HttpServletRequest req, HttpSession session, String loginId, String loginPw, String redirectUri) {
		if(Util.isEmpty(redirectUri)) {
			redirectUri = "/";
		}
		
		Member member = memberService.getMemberByLoginId(loginId);

		if (member == null) {
			return Util.msgAndBack(req, "존재하지 않는 아이디입니다.");
		}
		
		if(member.getLoginPw().equals(loginPw) == false) {
			return Util.msgAndBack(req, "loginPw을 확인해주세요.");
		}
		
		session.setAttribute("loginedMemberId", member.getId());
		
		String msg = "환영합니다.";
		return Util.msgAndReplace(req, msg, redirectUri);
	}
	
	@RequestMapping("/mpaUsr/member/doLogout")
	public String doLogout(HttpServletRequest req, HttpSession session) {		
		session.removeAttribute("loginedMemberId");

		return Util.msgAndReplace(req, "로그아웃 되었습니다.", "/");
	}
	
	//아이디, 비번 찾기
	@RequestMapping("/mpaUsr/member/findLoginInfo")
	public String showFindLoginInfo() {
		return "mpaUsr/member/findLoginInfo";
	}
	
	@RequestMapping("/mpaUsr/member/doFindLoginId")
	public String doFindLoginId(String name, String email, HttpServletRequest req, String redirectUri) {
		Member member = memberService.getMemberByNameAndEmail(name, email);
		
		if(member == null) {
			return Util.msgAndBack(req, "존재하지 않는 회원입니다.");
		}

		
		String msg = String.format("아이디는 %s 입니다.", member.getLoginId());

		return Util.msgAndReplace(req, msg, redirectUri);
	}
		
	@RequestMapping("/mpaUsr/member/doFindLoginPw")
	public String doFindLoginPw(String loginId, String email, HttpServletRequest req, String redirectUri) {
		Member member = memberService.getMemberByLoginId(loginId);
		
		if(member == null) {
			return Util.msgAndBack(req, "존재하지 않는 회원입니다.");
		}
		if(member.getEmail().equals(email) == false) {
			return Util.msgAndBack(req, "email이 올바르지 않습니다.");
		}

		
		memberService.sendTempLoginPwToEmail(member);
		
		String msg = String.format("임시 비밀번호를 해당 email로 발송하였습니다.");

		return Util.msgAndReplace(req, msg, redirectUri);
	}
	
	@RequestMapping("/mpaUsr/member/myPage")
	public String showMyPage() {		
		return "mpaUsr/member/myPage";
	}
	
	@RequestMapping("/mpaUsr/member/modify")
	public String showModify() {		
		return "mpaUsr/member/modify";
	}
	
	@RequestMapping("/mpaUsr/member/doModify")
	public String doModify(HttpServletRequest req,  String loginPw, String name, String
            nickname, String cellphoneNo, String email) {
		if(loginPw != null && loginPw.trim().length() == 0) {
			loginPw = null;
		}
		
		 int id = ((Rq)req.getAttribute("rq")).getLoginedMemberId();
		ResultData modifyrRd = memberService.modify(id, loginPw, name, nickname, cellphoneNo, email);
		
		if(modifyrRd.isFail()) {
			return Util.msgAndBack(req, modifyrRd.getMsg());
		}

		return Util.msgAndReplace(req,modifyrRd.getMsg(), "/");
	}


}
