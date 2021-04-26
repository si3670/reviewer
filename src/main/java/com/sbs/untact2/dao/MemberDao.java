package com.sbs.untact2.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sbs.untact2.dto.Member;

@Mapper
public interface MemberDao {

	Member getMemberByLoginId(@Param("loginId") String loginId);

	int getLastInsertId();
	
	Member getMemberById(@Param("id") int id);

	Member getMemberByNameAndEmail(@Param("name") String name, @Param("email") String email);

	void modifyMemberRd(Map<String, Object> param);

	void modify(Map<String, Object> param);

	void modify(@Param("id") int id, @Param("loginPw") String loginPw, @Param("name") String name,
			@Param("nickname") String nickname, @Param("cellphoneNo") String cellphoneNo, @Param("email") String email);

	void addMember(@Param("loginId") String loginId, @Param("loginPw") String loginPw, @Param("name") String name,
			@Param("nickname") String nickname, @Param("cellphoneNo") String cellphoneNo, @Param("email") String email);

}
