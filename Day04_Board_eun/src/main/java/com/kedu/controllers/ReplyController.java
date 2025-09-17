package com.kedu.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kedu.dto.ReplyDTO;
import com.kedu.services.ReplyService;

@Controller
@RequestMapping("/reply")
public class ReplyController {
	
	@Autowired
	private ReplyService replyService;
	
	@ResponseBody
	@RequestMapping("/insert")
	public ReplyDTO insert(ReplyDTO dto, HttpSession session) {
		String loginId = (String)session.getAttribute("loginId");
		int result = replyService.insert(dto, loginId);
		return replyService.getBySeq(result);
	}
	
	@ResponseBody
	@RequestMapping("/delete")
	public String deleteBySeq(int seq) throws Exception{
		replyService.deleteBySeq(seq);
		return "success";
	}
	
	@ResponseBody
	@RequestMapping("/update")
	public void updateBySeq(ReplyDTO dto) throws Exception{
		replyService.updateBySeq(dto);
	}
	
	@ExceptionHandler(Exception.class) // 예외계 Object 같은 느낌 모든 예외의 조상
	public String exceptionHandler(Exception e) {
		e.printStackTrace();
		return "redirect:/error";
	}
	
}