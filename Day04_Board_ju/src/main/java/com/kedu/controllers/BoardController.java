package com.kedu.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.Gson;
import com.kedu.dao.BoardDAO;
import com.kedu.dao.ReplyDAO;
import com.kedu.dto.BoardDTO;

@Controller
@RequestMapping("/board")
public class BoardController {

    @Autowired
    private BoardDAO boardDAO;
    
    @Autowired
    private ReplyDAO replyDAO;

    @Autowired
    private Gson gson;

    @RequestMapping("/list")
    public String list(Model model,
                       @RequestParam(required = false, defaultValue = "") String searchOpt,
                       @RequestParam(required = false) String search,
                       @RequestParam(required = false, defaultValue = "1") int page) {
        List<BoardDTO> postsList;
        int maxPage = boardDAO.getMaxPage(10);

        if (search != null) {
            if (!search.isEmpty()) {
                postsList = boardDAO.getPostsPage(searchOpt, search, page, 10);
                maxPage = boardDAO.getMaxPage(searchOpt, search, 10);
            } else {
                postsList = boardDAO.getPostsPage(page, 10);
            }
        } else {
            postsList = boardDAO.getPostsPage(page, 10);
        }

        model.addAttribute("curPage", page);
        model.addAttribute("list", gson.toJson(postsList));
        model.addAttribute("naviPerPage", 5);
        model.addAttribute("itemPerPage", 10);
        model.addAttribute("maxPage", maxPage);

        return "board/boardList";
    }

    @RequestMapping("/postingform")
    public String postingForm() {
        return "board/posting";
    }

    @RequestMapping("/posting")
    public String posting(HttpSession session, String title, String contents) {
    	String loginId = (String)session.getAttribute("loginId");
        boardDAO.posting(new BoardDTO (0, title, loginId, contents, 0, null));
        return "redirect:/board/list";
    }

    @RequestMapping("/item")
    public String item(int id, Model model) {
        boardDAO.updatePostsViewCntById(id);
        model.addAttribute("post", boardDAO.getPostById(id));
        model.addAttribute("reply", gson.toJson(replyDAO.getReplyList(id)));
        return "board/boardItem";
    }

    @RequestMapping("/delete")
    public String delete(HttpSession session, int id, String writer) {
        if (session.getAttribute("loginId").equals(writer)) {
            boardDAO.deletePostById(id);
        }
        return "redirect:/board/list";
    }

    @RequestMapping("/update")
    public String update(HttpSession session, int id, String title, String contents) {
    	String loginId = (String)session.getAttribute("loginId");
        if (boardDAO.getPostById(id).getWriter().equals(loginId)) {
            boardDAO.updatePostById(new BoardDTO (0, title, loginId, contents, 0, null));
        }
        return "redirect:/board/item?id=" + id;
    }
}
