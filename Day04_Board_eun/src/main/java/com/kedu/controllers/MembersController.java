package com.kedu.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kedu.dto.MembersDTO;
import com.kedu.services.MembersService;

@Controller
@RequestMapping("/members")
public class MembersController {

	@Autowired
	private MembersService membersService;
	
	@RequestMapping("/join")
	public String toJoin() {
		return "members/joinform";
	}

	// 로그인 시도
	@RequestMapping("/login")
	public String login(String loginId, String loginPw, HttpSession session) throws Exception{

		boolean checkLogin = membersService.checkLogin(loginId, loginPw);

		if(checkLogin) {
			// 세션에 id 저장
			session.setAttribute("loginId", loginId);
		}

		return "redirect:/";
	}
	
	// 로그아웃
	@RequestMapping("/logout")
	public String logout(HttpSession session) throws Exception{
		session.invalidate();
		return "redirect:/";
	}

	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public String insert(MembersDTO dto, HttpSession session) throws Exception{	
		
		membersService.insert(dto);

		return "redirect:/";
	}

	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String deleteById(HttpSession session) throws Exception{
		String loginId = (String)session.getAttribute("loginId");
		
		int result = membersService.deleteById(loginId);
		if(result != 0) {
			session.invalidate();
		}
		return "redirect:/";
	}
	
	// 마이페이지 이동
	@RequestMapping("/mypage")
	public String toMypage() {
		return "members/mypage";
	}
	
	// 마이페이지 값 주기
	@ResponseBody
	@RequestMapping("/mypage_data")
	public MembersDTO getMemberById(HttpSession session) throws Exception{
		String loginId = (String)session.getAttribute("loginId");
		return membersService.getMemberById(loginId);
	}

	// 수정 페이지로 이동
	@RequestMapping("/mypage_update")
	public String toMypageUpdate() {
		return "members/mypage_update";
	}
		
	// 수정 페이지로 값 주기
	@ResponseBody
	@RequestMapping("/mypage_update_data")
	public MembersDTO updatePage(HttpSession session) {
		String loginId = (String)session.getAttribute("loginId");
		return membersService.getMemberById(loginId);
	}

	// 수정하기 눌렀을 때
	@RequestMapping("/update")
	public String updateById(HttpSession session, MembersDTO dto) throws Exception{
		String loginId = (String)session.getAttribute("loginId");
		membersService.updateById(loginId, dto);

		return "redirect:/members/mypage";
	}

	// id 중복 체크 요청
	@ResponseBody
	@RequestMapping("/isIdExist")
	public boolean isIdExist(String id) {
	    return membersService.isIdExist(id);
	}

	@ExceptionHandler(Exception.class) // 예외계 Object 같은 느낌 모든 예외의 조상
	public String exceptionHandler(Exception e) {
		e.printStackTrace();
		return "redirect:/error";
	}
}
