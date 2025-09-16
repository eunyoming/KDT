package com.kedu.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kedu.dto.MembersDTO;

@Repository
public class MembersDAO {

	@Autowired
	private SqlSessionTemplate mybatis;

	// ID 중복검사
	public boolean isIdExist(String id) {
		return mybatis.selectOne("Join.isIdExist", id);
	}

	// insert
	public int insert(MembersDTO dto) {	
		return mybatis.insert("Join.insert", dto);
	}

	// login 성공여부
	public boolean checkLogin(Map<String, String> param) {
		int result = mybatis.selectOne("Join.checkLogin", param);
		return result > 0;
	}

	// 회원탈퇴
	public int deleteById(String id) {
		return mybatis.delete("Join.deleteById", id);
	}

	// 회원정보 가져오기
	public MembersDTO getMemberById(String loginId) {
		return mybatis.selectOne("Join.getMemberById", loginId);
	}

	// 수정
	public int updateById(MembersDTO dto) {
		return mybatis.update("Join.updateById", dto);
	}

}
