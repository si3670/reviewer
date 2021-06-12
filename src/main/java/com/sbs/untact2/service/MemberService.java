package com.sbs.untact2.service;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.sbs.untact2.dao.MemberDao;
import com.sbs.untact2.dto.Member;
import com.sbs.untact2.dto.ResultData;
import com.sbs.untact2.util.Util;

@Service
public class MemberService {
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private MailService mailService;
	@Autowired
	private AttrService attrService;

	@Value("${custom.siteName}")
	private String siteName;
	@Value("${custom.siteMainUri}")
	private String siteMainUri;
	@Value("${custom.siteLoginUri}")
	private String siteLoginUri;
	@Value("${custom.needToChangePasswordFreeDays}")
	private int needToChangePasswordFreeDays;

	public Member getMemberByLoginId(String loginId) {
		return memberDao.getMemberByLoginId(loginId);
	}
	
	public Member getMemberByNameAndEmail(String name, String email) {
		return memberDao.getMemberByNameAndEmail(name, email);
	}
	
	private void sendJoinCompleteMail(String email) {
		String mailTitle = String.format("[%s] 가입이 완료되었습니다.", siteName);

		StringBuilder mailBodySb = new StringBuilder();
		mailBodySb.append("<h1>가입이 완료되었습니다.</h1>");
		mailBodySb.append(String.format("<a href=\"%s\" target=\"_blank\">로그인 하러가기</a>", siteLoginUri));

		mailService.send(email, mailTitle, mailBodySb.toString());
	}
	
	public ResultData addMember(String loginId, String loginPw, String name, String nickname, String cellphoneNo,
			String email) {
		memberDao.addMember(loginId, loginPw, name, nickname, cellphoneNo, email);
		int id = memberDao.getLastInsertId();

		sendJoinCompleteMail(email);

		setNeedToChangePasswordLater(id);

		return new ResultData("P-1", "회원가입이 완료되었습니다.", "id", id);
	}

	
	public Member getMemberById(int id) {
		return memberDao.getMemberById(id);
	}

	
	public ResultData notifyTempLoginPwByEmail(Member actor) {
		String title = "[" + siteName + "] 임시 패스워드 발송";
		String tempPassword = Util.getTempPassword(6);
		String body = "<h1>임시 패스워드 : " + tempPassword + "</h1>";
		body += String.format("<a href=\"%s\" target=\"_blank\">로그인 하러가기</a>", siteLoginUri);

		ResultData sendResultData = mailService.send(actor.getEmail(), title, body);

		if (sendResultData.isFail()) {
			return sendResultData;
		}

		tempPassword = Util.sha256(tempPassword);

		setTempPassword(actor, tempPassword);

		return new ResultData("S-1", "계정의 이메일주소로 임시 패스워드가 발송되었습니다.");
	}
	
	//비밀번호 변경 필요
	private void setTempPassword(Member actor, String tempPassword) {
		attrService.setValue("member", actor.getId(), "extra", "useTempPassword", "1", null);
		memberDao.modify(actor.getId(), tempPassword, null, null, null, null);
	}
	
	private void setNeedToChangePasswordLater(int actorId) {
		int days = getNeedToChangePasswordFreeDays();
		attrService.setValue("member", actorId, "extra", "needToChangePassword", "0",
				Util.getDateStrLater(60 * 60 * 24 * days));

	}
	


	public ResultData checkValidCheckPasswordAuthCode(int actorId, String checkPasswordAuthCode) {
		if (attrService.getValue("member__" + actorId + "__extra__checkPasswordAuthCode")
				.equals(checkPasswordAuthCode)) {
			return new ResultData("S-1", "유효한 키 입니다.");
		}

		return new ResultData("F-1", "유효하지 않은 키 입니다.");
	}
	
	public ResultData modify(int id, String loginPw, String name, String nickname, String cellphoneNo, String email) {
		memberDao.modify(id, loginPw, name, nickname, cellphoneNo, email);

		if (loginPw != null) {
			System.out.println("실행됨");
			setNeedToChangePasswordLater(id);
			attrService.remove("member", id, "extra", "useTempPassword");
		}

		return new ResultData("P-1", "수정이 완료되었습니다.", "id", id);
	}


	public String getCheckPasswordAuthCode(int actorId) {
		String attrName = "member__" + actorId + "__extra__checkPasswordAuthCode";
		String authCode = UUID.randomUUID().toString();
		String expireDate = Util.getDateStrLater(60 * 60);

		attrService.setValue(attrName, authCode, expireDate);

		return authCode;
	}


	// 비번바꿔야하는지 물어보기
	// needToChangePassword 값이 0이면 안바꿔도 됌
	public boolean needToChangePassword(int actorId) {
		return attrService.getValue("member", actorId, "extra", "needToChangePassword").equals("0") == false;
	}
	
	public int getNeedToChangePasswordFreeDays() {
		return needToChangePasswordFreeDays;
	}
	
	public boolean usingTempPassword(int actorId) {
		return attrService.getValue("member", actorId, "extra", "useTempPassword").equals("1");
	}
	


	public static String getAuthLevelName(Member member) {
		switch (member.getAuthLevel()) {
		case 7:
			return "관리자";
		case 3:
			return "일반";
		default:
			return "유형정보없음";
		}
	}

	public static String getAuthLevelNameColor(Member member) {
		switch (member.getAuthLevel()) {
		case 7:
			return "red";
		case 3:
			return "gray";
		default:
			return "";
		}
	}

	public boolean isAdmin(Member actor) {
		if (actor == null) {
			return false;
		}
		return actor.getAuthLevel() == 7;
	}

	public ResultData deleteMemberByLoginId(String loginId) {
		Member member = getMemberByLoginId(loginId);

		if (isEmpty(member)) {
			return new ResultData("F-1", "존재하지 않는 회원입니다.", "loginId", loginId);
		}

		memberDao.deleteMemberByLoginId(loginId);
		return new ResultData("S-1", "탈퇴되었습니다.", "loginId", loginId);
	}

	// member이 null, delstatus가 1인 경우 수정,삭제됨
	private boolean isEmpty(Member member) {
		if (member == null) {
			return true;
		} else if (member.isDelStatus()) {
			return true;
		}
		return false;
	}

	public List<Member> getForPrintMembers( int page, int itemsInAPage, String searchKeyword,
			String searchKeywordType) {
		int limitStart = (page - 1) * itemsInAPage;
		int limitTake = itemsInAPage;
		return memberDao.getForPrintMembers(limitStart, limitTake, searchKeyword, searchKeywordType);
	}

	public int getMembersTotalCount(String searchKeyword, String searchKeywordType) {
		return memberDao.getMembersTotalCount(searchKeyword, searchKeywordType);
	}

}
