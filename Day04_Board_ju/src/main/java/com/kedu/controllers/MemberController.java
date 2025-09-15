package com.kedu.controllers;

import com.kedu.dao.MemberDAO;
import com.kedu.dto.MemberDTO;
import com.kedu.utils.CustomEncrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/member")
public class MemberController {

    @Autowired
    private MemberDAO dao;

    @RequestMapping("/toregistry")
    public String registryForm() {
        return "member/registerForm";
    }

    @PostMapping("/register")
    public String registry(MemberDTO dto) {
        dto.setPw(CustomEncrypt.encrypt(dto.getPw()));
        dao.insertMember(dto);
        return "redirect:/";
    }

    @ResponseBody
    @RequestMapping("/idduplcheck")
    public boolean idDuplCheck(String id) {
        return dao.idDuplcheck(id);
    }

    @RequestMapping("/login")
    public String login(String id, String pw, HttpSession session) {
        if (dao.login(id, CustomEncrypt.encrypt(pw))) {
            session.setAttribute("loginId", id);
        }
        return "redirect:/";
    }

    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        session.removeAttribute("loginId");
        return "redirect:/";
    }

    @RequestMapping("/update")
    public String update(HttpSession session, MemberDTO dto) {
        dto.setId((String) session.getAttribute("loginId"));
        dao.updateMemberInfo(dto);
        return "redirect:/member/mypage";
    }

    @RequestMapping("/mypage")
    public String mypage(HttpSession session, Model model) {
        model.addAttribute("myInfo", dao.getMemberInfoById((String) session.getAttribute("loginId")));
        return "member/mypage";
    }

    @RequestMapping("/withdraw")
    public String withdraw(HttpSession session) {
        dao.withdraw((String)session.getAttribute("loginId"));
        return "redirect:/";
    }
}
