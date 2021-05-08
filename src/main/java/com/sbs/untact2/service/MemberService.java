package com.sbs.untact2.service;

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

	public Member getMemberByLoginId(String loginId) {
		return memberDao.getMemberByLoginId(loginId);
	}

	public ResultData addMember(String loginId, String loginPw, String name, String nickname, String cellphoneNo,
			String email) {
		memberDao.addMember(loginId, loginPw, name, nickname, cellphoneNo, email);
		int id = memberDao.getLastInsertId();

		sendJoinCompleteMail(email);

		return new ResultData("P-1", "가입 성공", "id", id);
	}

	private void sendJoinCompleteMail(String email) {
		String mailTitle = String.format("[%s] 가입이 완료되었습니다.", siteName);

		StringBuilder mailBodySb = new StringBuilder();
		mailBodySb.append("<h1>가입이 완료되었습니다.</h1>");
		mailBodySb.append(String.format("<a href=\"%s\" target=\"_blank\">로그인 하러가기</a>", siteLoginUri));

		mailService.send(email, mailTitle, mailBodySb.toString());
	}

	public Member getMemberById(int id) {
		return memberDao.getMemberById(id);
	}

	public Member getMemberByNameAndEmail(String name, String email) {
		return memberDao.getMemberByNameAndEmail(name, email);
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

	private void setTempPassword(Member actor, String tempPassword) {
		attrService.setValue("member", actor.getId(), "extra", "useTempPassword", "1", null);
		memberDao.modify(actor.getId(), tempPassword, null, null, null, null);
	}

	public ResultData modify(int id, String loginPw, String name, String nickname, String cellphoneNo, String email) {
		memberDao.modify(id, loginPw, name, nickname, cellphoneNo, email);

		if (loginPw != null) {
			attrService.remove("member", id, "extra", "useTempPassword");
		}

		return new ResultData("P-1", "수정 성공", "id", id);
	}

	public String getCheckPasswordAuthCode(int actorId) {
		String attrName = "member__" + actorId + "__extra__checkPasswordAuthCode";
		String authCode = UUID.randomUUID().toString();
		String expireDate = Util.getDateStrLater(60 * 60);

		attrService.setValue(attrName, authCode, expireDate);

		return authCode;
	}

	public ResultData checkValidCheckPasswordAuthCode(int actorId, String checkPasswordAuthCode) {
		if (attrService.getValue("member__" + actorId + "__extra__checkPasswordAuthCode")
				.equals(checkPasswordAuthCode)) {
			return new ResultData("S-1", "유효한 키 입니다.");
		}

		return new ResultData("F-1", "유효하지 않은 키 입니다.");
	}

	public boolean isUsingTempPassword(int actorId) {
		return attrService.getValue("member", actorId, "extra", "useTempPassword").equals("1");
	}

}
