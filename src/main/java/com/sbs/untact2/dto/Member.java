package com.sbs.untact2.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.sbs.untact2.service.MemberService;
import com.sbs.untact2.util.Util;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
public class Member {
	private int id;
	private String regDate;
	private String updateDate;
	private String loginId;
	private String loginPw;
	private int authLevel;
	private String name;
	private String nickname;
	private String email;
	private String cellphoneNo;
	private boolean delStatus;

	public String getAuthLevelName() {
		return MemberService.getAuthLevelName(this);
	}

	public String getAuthLevelNameColor() {
		return MemberService.getAuthLevelNameColor(this);
	}

	public String toJsonStr() {
		return Util.toJsonStr(this);
	}

	public String getProfileImgUri() {
		return "/common/genFile/file/member/" + id + "/extra/profileImg/1";
	}

	public String getProfileFallbackImgUri() {
		return "https://via.placeholder.com/70?text=^_^";
	}

	public String getProfileFallbackImgOnErrorHtmlAttr() {
		return "this.src = '" + getProfileFallbackImgUri() + "'";
	}

	public String getRemoveProfileImgIfNotExistsOnErrorHtmlAttr() {
		return "$(this).remove();";
	}

}
