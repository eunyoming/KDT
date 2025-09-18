package com.kedu.services;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.kedu.commons.Config;
import com.kedu.dao.BoardDAO;
import com.kedu.dao.FileDAO;
import com.kedu.dto.BoardDTO;
import com.kedu.dto.FileDTO;

@Service
public class BoardService {

	@Autowired
	private BoardDAO boardDAO;
	
	@Autowired
	private FileDAO fileDAO;

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
	
	@Transactional
	public void addBoard(String loginId, BoardDTO dto, String realPath, MultipartFile[] files) throws Exception{
		dto.setWriter(loginId);
		int seq = boardDAO.addBoard(dto);
		
		// upload 폴더 생성
		File realPathFile = new File(realPath);
		if(!realPathFile.exists()) {
			realPathFile.mkdir();
		}
		
		for(MultipartFile file: files) {
            if(!file.isEmpty()) {
               String oriName = file.getOriginalFilename();
               String sysName = UUID.randomUUID() + "_"+ oriName; //유니크한 식별자를 만들어내는 함수_oriName
               file.transferTo(new File(realPath+"/"+sysName)); //realpath에다가 sysName으로 저장
               
               //파일의 db 작업
               fileDAO.insert(new FileDTO(0, dto.getWriter(), oriName, sysName, seq));
            }
		}
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
