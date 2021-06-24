package com.sbs.untact2.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import com.sbs.untact2.dto.Member;
import com.sbs.untact2.dto.ResultData;
import com.sbs.untact2.dto.Rq;
import com.sbs.untact2.service.GenFileService;
import com.sbs.untact2.service.MemberService;
import com.sbs.untact2.util.Util;

@Controller
public class MpaAdmMemberController {
	@Autowired
	private MemberService memberService;
	@Autowired
	private GenFileService genFileService;

	@RequestMapping("/mpaAdm/member/join")
	public String showJoin() {
		return "mpaAdm/member/join";
	}

	// 회원 리스트
	@RequestMapping("/mpaAdm/member/list")
	public String showList(HttpServletRequest req, @RequestParam(defaultValue = "1") int page, String searchKeyword,
			@RequestParam(defaultValue = "nameAndAuthLevelName") String searchKeywordType) {
		
		if (searchKeywordType != null) {
			searchKeywordType = searchKeywordType.trim();
		}
		if (searchKeywordType == null || searchKeywordType.length() == 0) {
			searchKeywordType = "nameAndAuthLevelName";
		}
		if (searchKeyword != null && searchKeyword.length() == 0) {
			searchKeyword = null;
		}
		if (searchKeyword != null) {
			searchKeyword = searchKeyword.trim();
		}
		if (searchKeyword == null) {
			searchKeywordType = null;
		}
		
		int totalCount = memberService.getMembersTotalCount(searchKeyword, searchKeywordType);

		req.setAttribute("totalCount", totalCount);

		int itemsInAPage = 5;
		int totalPage = (int) Math.ceil(totalCount / (double) itemsInAPage);

		req.setAttribute("page", page);
		req.setAttribute("totalPage", totalPage);

		List<Member> members = memberService.getForPrintMembers(page, itemsInAPage, searchKeyword,
				searchKeywordType);

		req.setAttribute("members", members);
		return "mpaAdm/member/list";
	}

	// MultipartRequest multipartRequest = 파일들 압축되어서 들어감
	@RequestMapping("/mpaAdm/member/doJoin")
	public String doJoin(HttpServletRequest req, String loginId, String loginPw, String name, String nickname,
			String cellphoneNo, String email, MultipartRequest multipartRequest) {

		Member oldMember = memberService.getMemberByLoginId(loginId);

		if (oldMember != null) {
			return Util.msgAndBack(req, "이미 사용 중인 아이디입니다.");
		}

		oldMember = memberService.getMemberByNameAndEmail(name, email);

		if (oldMember != null) {
			return Util.msgAndBack(req,
					String.format("%s님은 이미 %s 메일주소로 %s 에 가입하셨습니다.", name, email, oldMember.getRegDate()));
		}

		ResultData addMemberRd = memberService.addMember(loginId, loginPw, name, nickname, cellphoneNo, email);

		if (addMemberRd.isFail()) {
			return Util.msgAndBack(req, addMemberRd.getMsg());
		}

		// 회원이 만들어진 후 파일 작업 시작, relid가 정해져야 하기 때문

		int newMemberId = (int) addMemberRd.getBody().get("id");

		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();

		for (String fileInputName : fileMap.keySet()) {
			MultipartFile multipartFile = fileMap.get(fileInputName);

			// 파일이 비어있지 않을 때 save , multipartFile의 관련된 것은 newMemberId이란 사람이다
			if (multipartFile.isEmpty() == false) {
				genFileService.save(multipartFile, newMemberId);
			}
		}

		return Util.msgAndReplace(req, addMemberRd.getMsg(), "/");
	}

	@RequestMapping("/mpaAdm/member/getLoginIdDup")
	@ResponseBody
	public ResultData getLoginIdDup(HttpServletRequest req, String loginId) {
		Member member = memberService.getMemberByLoginId(loginId);

		if (member != null) {
			return new ResultData("F-1", "이미 사용 중인 아이디입니다.", "loginId", loginId);
		}

		return new ResultData("P-1", "사용가능한 로그인 아이디입니다.", "loginId", loginId);
	}

	@RequestMapping("/mpaAdm/member/login")
	public String showLogin() {
		return "mpaAdm/member/login";
	}

	@RequestMapping("/mpaAdm/member/doLogin")
	public String doLogin(HttpServletRequest req, HttpSession session, String loginId, String loginPw,
			String redirectUri) {
		if (Util.isEmpty(redirectUri)) {
			redirectUri = "/";
		}

		Member member = memberService.getMemberByLoginId(loginId);

		if (member == null) {
			return Util.msgAndBack(req, "존재하지 않는 아이디입니다.");
		}

		if (member.getLoginPw().equals(loginPw) == false) {
			return Util.msgAndBack(req, "loginPw을 확인해주세요.");
		}

		if (memberService.isAdmin(member) == false) {
			return Util.msgAndBack(req, "관리자 회원으로 로그인 해주세요.");
		}

		session.setAttribute("loginedMemberId", member.getId());
		session.setAttribute("loginedMemberJsonStr", member.toJsonStr());

		String msg = "관리자님 환영합니다.";

		boolean needToChangePassword = memberService.needToChangePassword(member.getId());

		if (needToChangePassword) {
			msg = "현재 비밀번호를 사용한지 " + memberService.getNeedToChangePasswordFreeDays() + "일이 지났습니다. 비밀번호를 변경해주세요.";
			redirectUri = "/mpaAdm/member/myPage";
		}

		boolean isUsingTempPassword = memberService.usingTempPassword(member.getId());

		if (isUsingTempPassword) {
			msg = "임시 비밀번호를 변경해주세요";
			redirectUri = "/mpaAdm/member/myPage";
		}

		return Util.msgAndReplace(req, msg, redirectUri);
	}

	@RequestMapping("/mpaAdm/member/doLogout")
	public String doLogout(HttpServletRequest req, HttpSession session) {
		session.removeAttribute("loginedMemberId");
		session.removeAttribute("needToChangePassword");

		return Util.msgAndReplace(req, "로그아웃 되었습니다.", "/");
	}

	// 아이디, 비번 찾기
	@RequestMapping("/mpaAdm/member/findLoginInfo")
	public String showFindLoginInfo() {
		return "mpaAdm/member/findLoginInfo";
	}

	@RequestMapping("/mpaAdm/member/doFindLoginId")
	public String doFindLoginId(String name, String email, HttpServletRequest req, String redirectUri) {
		Member member = memberService.getMemberByNameAndEmail(name, email);

		if (member == null) {
			return Util.msgAndBack(req, "존재하지 않는 회원입니다.");
		}

		String msg = String.format("아이디는 %s 입니다.", member.getLoginId());

		return Util.msgAndReplace(req, msg, redirectUri);
	}

	@RequestMapping("/mpaAdm/member/doFindLoginPw")
	public String doFindLoginPw(String loginId, String email, HttpServletRequest req, String redirectUri) {
		if (Util.isEmpty(redirectUri)) {
			redirectUri = "/";
		}

		Member member = memberService.getMemberByLoginId(loginId);

		if (member == null) {
			return Util.msgAndBack(req, "일치하는 회원이 존재하지 않습니다.");
		}

		if (member.getLoginId().equals(loginId) == false) {
			return Util.msgAndBack(req, "일치하는 회원이 존재하지 않습니다.");
		}

		if (member.getEmail().equals(email) == false) {
			return Util.msgAndBack(req, "일치하는 회원이 존재하지 않습니다.");
		}

		ResultData notifyTempLoginPwByEmailRs = memberService.notifyTempLoginPwByEmail(member);

		return Util.msgAndReplace(req, notifyTempLoginPwByEmailRs.getMsg(), redirectUri);
	}

	@RequestMapping("/mpaAdm/member/myPage")
	public String showMyPage() {
		return "mpaAdm/member/myPage";
	}


	// checkPasswordAuthCode : 체크비밀번호인증코드
	@RequestMapping("/mpaAdm/member/modify")
	public String showModify(HttpServletRequest req, String checkPasswordAuthCode) {
		Member loginedMember = ((Rq) req.getAttribute("rq")).getLoginedMember();

		ResultData checkValidCheckPasswordAuthCodeResultData = memberService
				.checkValidCheckPasswordAuthCode(loginedMember.getId(), checkPasswordAuthCode);

		if (checkValidCheckPasswordAuthCodeResultData.isFail()) {
			return Util.msgAndBack(req, checkValidCheckPasswordAuthCodeResultData.getMsg());
		}

		return "mpaAdm/member/modify";
	}

	@RequestMapping("/mpaAdm/member/doModify")
	public String doModify(HttpServletRequest req, String loginPw, String name, String nickname, String cellphoneNo,
			String email, String checkPasswordAuthCode, MultipartRequest multipartRequest) {
		Member loginedMember = ((Rq) req.getAttribute("rq")).getLoginedMember();

		ResultData checkValidCheckPasswordAuthCodeResultData = memberService
				.checkValidCheckPasswordAuthCode(loginedMember.getId(), checkPasswordAuthCode);

		if (checkValidCheckPasswordAuthCodeResultData.isFail()) {
			return Util.msgAndBack(req, checkValidCheckPasswordAuthCodeResultData.getMsg());
		}

		if (loginPw != null && loginPw.trim().length() == 0) {
			loginPw = null;
		}

		int id = ((Rq) req.getAttribute("rq")).getLoginedMemberId();
		ResultData modifyrRd = memberService.modify(id, loginPw, name, nickname, cellphoneNo, email);

		if (modifyrRd.isFail()) {
			return Util.msgAndBack(req, modifyrRd.getMsg());
		}

		if (req.getParameter("deleteFile__member__0__extra__profileImg__1") != null) {
			genFileService.deleteGenFile("member", loginedMember.getId(), "extra", "profileImg", 1);
		}

		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();

		for (String fileInputName : fileMap.keySet()) {
			MultipartFile multipartFile = fileMap.get(fileInputName);

			if (multipartFile.isEmpty() == false) {
				genFileService.save(multipartFile, loginedMember.getId());
			}
		}

		if (loginPw != null) {
			req.getSession().removeAttribute("needToChangePassword");
		}

		return Util.msgAndReplace(req, modifyrRd.getMsg(), "/");
	}

	@RequestMapping("/mpaAdm/member/checkPassword")
	public String showCheckPassword() {
		return "mpaAdm/member/checkPassword";
	}

	@RequestMapping("/mpaAdm/member/doCheckPassword")
	public String doCheckPassword(HttpServletRequest req, String loginPw, String redirectUri) {
		Member loginedMember = ((Rq) req.getAttribute("rq")).getLoginedMember();

		if (loginedMember.getLoginPw().equals(loginPw) == false) {
			return Util.msgAndBack(req, "비밀번호가 일치하지 않습니다.");
		}

		// 회원 인증 됐으니 인증키 만들기
		String authCode = memberService.getCheckPasswordAuthCode(loginedMember.getId());

		redirectUri = Util.getNewUri(redirectUri, "checkPasswordAuthCode", authCode);

		return Util.msgAndReplace(req, "", redirectUri);
	}

}
