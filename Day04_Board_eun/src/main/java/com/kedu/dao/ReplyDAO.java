package com.kedu.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kedu.dto.ReplyDTO;

@Repository
public class ReplyDAO {
	
	@Autowired
	private SqlSessionTemplate mybatis;

	// insert
	public int insertReply(ReplyDTO dto) {
		mybatis.insert("Reply.insertReply", dto);
		return dto.getSeq();
	}

	// "select * from reply";
	public List<ReplyDTO> getAllList() {
		return mybatis.selectList("Reply.getAllList");
	}

	// select * from reply where parent_seq = ?
	public List<ReplyDTO> getListBySeq(int parent_seq) {
		return mybatis.selectList("Reply.getListBySeq", parent_seq);
	}
	
	public ReplyDTO getBySeq(int seq) {
		return mybatis.selectOne("Reply.getBySeq", seq);
	}
	// delete
	public int deleteBySeq(int seq) {
		return mybatis.delete("Reply.deleteBySeq", seq);
	}

	// update
		public int updateBySeq(Map<String, Object> param) {
			return mybatis.update("Reply.updateBySeq", param);
		}
}
