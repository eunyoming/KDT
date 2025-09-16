package com.kedu.services;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kedu.commons.Config;
import com.kedu.dao.BoardDAO;
import com.kedu.dto.BoardDTO;

@Service
public class BoardService {

	@Autowired
	private BoardDAO boardDAO;

	public List<BoardDTO> getSelectFromTo(int cpage){
		int recordCountPerPage = Config.RECORD_COUNT_PER_PAGE;

		int to = cpage * recordCountPerPage;
		int from = cpage * recordCountPerPage - (recordCountPerPage - 1);

		// 값 묶어서 보내기
		Map<String, Integer> param = new HashMap<>();
		param.put("from", from);
		param.put("to", to);

		return boardDAO.getSelectFromTo(param);
	}

	public int getRecordTotalCount() {
		return boardDAO.getRecordTotalCount();
	}

	public int addBoard(String loginId, BoardDTO dto) {
		dto.setWriter(loginId);
		return boardDAO.addBoard(dto);
	}

	public void updateViewCntBySeq(int target) {
		boardDAO.updateViewCntBySeq(target);
	}

	public BoardDTO getListBySeq(int seq) {
		return boardDAO.getListBySeq(seq);
	}

	public int updateBySeq(BoardDTO dto) {
		// 값 묶어서 보내기
		Map<String, Object> param = new HashMap<>();
		param.put("title", dto.getTitle());
		param.put("contents", dto.getContents());
		param.put("seq", dto.getSeq());
		
		return boardDAO.updateBySeq(param);
	}
	
	public int deleteBySeq(int seq) {
		return boardDAO.deleteBySeq(seq);
	}

}
