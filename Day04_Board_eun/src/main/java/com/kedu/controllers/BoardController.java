package com.kedu.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kedu.commons.Config;
import com.kedu.dto.BoardDTO;
import com.kedu.dto.ReplyDTO;
import com.kedu.services.BoardService;
import com.kedu.services.ReplyService;

@Controller
@RequestMapping("/board")
public class BoardController {

	@Autowired
	private BoardService boardService;
	
	@Autowired
	private ReplyService replyService;
	
	@RequestMapping("/write")
	public String write() {
		return "board/write";
	}
	
	@RequestMapping("/list")
	public String list(Model m, @RequestParam(defaultValue = "1") int cpage) throws Exception{
		int recordCountPerPage = Config.RECORD_COUNT_PER_PAGE;
		int naviCountPerPage = Config.NAVI_COUNT_PER_PATE;
		
		List<BoardDTO> list = boardService.getSelectFromTo(cpage);
		m.addAttribute("list", list);
		m.addAttribute("currentPage", cpage);
		m.addAttribute("naviCountPerPage", naviCountPerPage);
		m.addAttribute("recordCountPerPage", recordCountPerPage);
		m.addAttribute("recordTotalCount", boardService.getRecordTotalCount());
		return "board/list";
	}
	
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public String insert(BoardDTO dto, HttpSession session, String text, MultipartFile[] files) throws Exception{
		String loginId = (String)session.getAttribute("loginId");
	
		String realPath =session.getServletContext().getRealPath("upload");
		
		boardService.addBoard(loginId, dto, realPath, files);
		return "redirect:/board/list";
	}
	
	@RequestMapping("/detail")
	public String detail(int seq, Model m) {
		// 조회수 증가
		boardService.updateViewCntBySeq(seq);
		BoardDTO dto = boardService.getListBySeq(seq);
		
		// 댓글 가져오기
		List<ReplyDTO> list = replyService.getListBySeq(seq);
		m.addAttribute("dto", dto);
		m.addAttribute("list", list);
		
		return "/board/detail";
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(BoardDTO dto) {
		boardService.updateBySeq(dto);
		return "redirect:/board/detail?seq=" + dto.getSeq();
	}
	
	@RequestMapping("/delete")
	public String delete(int seq) {
		// 조회수 증가
		boardService.deleteBySeq(seq);
		return "redirect:/board/list";
	}
	
	@ExceptionHandler(Exception.class) // 예외계 Object 같은 느낌 모든 예외의 조상
	public String exceptionHandler(Exception e) {
		e.printStackTrace();
		return "redirect:/error";
	}
}
