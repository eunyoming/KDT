package com.kedu.services;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kedu.dao.MessagesDAO;
import com.kedu.dto.MessagesDTO;

// 컴포넌트로 인스턴스화 필요
// 웹과 관련없는 root-context에서 스캔 돌리기
// Transaction
// 1. 원자성
// 2. 일관성
// 3. 독립성
// 4. 지속성
@Service
public class MessagesService {
	
	@Autowired
	private MessagesDAO dao;
	
	@Transactional
	public int insert(MessagesDTO dto) {
		dao.insert(dto);
		dao.deleteBySeq(3);
		return 0;
	}
	
	public List<MessagesDTO> selectAll(){
		return dao.selectAll();
	}
	
	public int deleteBySeq(int seq) {
		return dao.deleteBySeq(seq);
	}
	
	public int updateBySeq(MessagesDTO dto) {
		return dao.updateBySeq(dto);
	}
	
	public List<MessagesDTO> selectBy(String column, String keyword){
		Map<String, String> param = new HashMap<>();
		param.put("column", column);
		param.put("keyword", keyword);
		return dao.selectBy(param);
	}
	
	public List<MessagesDTO> searchtByMultiple(String sender, String message){
		Map<String, String> param = new HashMap<>();
		param.put("sender", sender);
		param.put("message", message);
		return dao.searchtByMultiple(param);
	}
	
	public MessagesDTO selectBySeq(int seq) {
		return dao.selectBySeq(seq);
	}
	
	public int selectCount() {
		return dao.selectCount();
	}
}
