package com.kedu.services;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kedu.dao.ReplyDAO;
import com.kedu.dto.ReplyDTO;

@Service
public class ReplyService {
	
	@Autowired
	private ReplyDAO replyDAO;
	
	public int insert(ReplyDTO dto, String loginId) {
		dto.setWriter(loginId);
		return replyDAO.insertReply(dto);
	}
	
	public List<ReplyDTO> getAllList(){
		return replyDAO.getAllList();
	}
	
	public List<ReplyDTO> getListBySeq(int parent_seq){
		return replyDAO.getListBySeq(parent_seq);
	}
	
	public ReplyDTO getBySeq(int seq) {
		return replyDAO.getBySeq(seq);
	}
	
	public int deleteBySeq(int seq) {
		return replyDAO.deleteBySeq(seq);
	}
	
	public int updateBySeq(ReplyDTO dto) {
		Map<String, Object> param = new HashMap<>();
		param.put("contents", dto.getContents());
		param.put("seq", dto.getSeq());
		
		return replyDAO.updateBySeq(param);
	}
}
