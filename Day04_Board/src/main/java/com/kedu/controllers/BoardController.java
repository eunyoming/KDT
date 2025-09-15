package com.kedu.controllers;

import com.google.gson.Gson;
import com.kedu.dao.BoardDAO;
import com.kedu.dto.BoardDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/board")
public class BoardController {

    @Autowired
    private BoardDAO boardDAO;

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
        boardDAO.posting(BoardDTO.builder()
                .writer((String) session.getAttribute("loginId"))
                .title(title)
                .contents(contents)
                .build());
        return "redirect:/board/list";
    }

    @RequestMapping("/item")
    public String item(int id, Model model) {
        boardDAO.updatePostsViewCntById(id);
        model.addAttribute("post", boardDAO.getPostById(id));
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
        if (boardDAO.getPostById(id).getWriter().equals(session.getAttribute("loginId"))) {
            boardDAO.updatePostById(BoardDTO.builder()
                    .id(id)
                    .title(title)
                    .contents(contents)
                    .build());
        }
        return "redirect:/board/item?id=" + id;
    }
}
