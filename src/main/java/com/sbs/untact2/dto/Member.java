package com.sbs.untact2.dto;


import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.sbs.untact2.util.Util;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
public class Member{
	private int id;
	private String regDate;
	private String updateDate;
	private String loginId;
	private String loginPw;
	private String name;
	private String nickname;
	private String email;
	private String cellphoneNo;
	private boolean delStatus;

	public String getAuthLevelName() {
		return "일반회원";
	}

	public String toJsonStr() {
		return Util.toJsonStr(this); 
	}

}
