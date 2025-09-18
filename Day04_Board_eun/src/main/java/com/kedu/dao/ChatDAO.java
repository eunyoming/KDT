package com.kedu.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kedu.dto.ChatDTO;

@Repository
public class ChatDAO {
	
	@Autowired
	private SqlSessionTemplate mybatis;
	
	public int insert(ChatDTO dto) {
		return mybatis.insert("Chat.insert", dto);
	}
	
	public List<ChatDTO> selectAll(){
		return mybatis.selectList("Chat.selectAll");
	}
}
