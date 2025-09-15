package com.kedu.dao;

import com.kedu.dto.BoardDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class BoardDAO {

    @Autowired
    private JdbcTemplate jdbc;

    //region insert
    public void posting(BoardDTO postInfo) {
        String sql = "INSERT INTO board(id, writer, title, contents) VALUES(board_seq.nextval, ?, ?, ?)";
        jdbc.update(sql, postInfo.getWriter(), postInfo.getTitle(), postInfo.getContents());
    }
    //endregion

    //region select
    public List<BoardDTO> getPostsPage(int curPage, int itemPerPage) {
        String sql = "SELECT * FROM (SELECT board.*, ROW_NUMBER() OVER(ORDER BY id DESC) rn FROM board) WHERE rn BETWEEN ? AND ?";
        return jdbc.query(sql, new BeanPropertyRowMapper<>(BoardDTO.class),
                curPage * itemPerPage - (itemPerPage - 1),
                curPage * itemPerPage);
    }

    public List<BoardDTO> getPostsPage(String searchOpt, String target, int curPage, int itemPerPage) {
        String sql = "SELECT * FROM (SELECT board.*, ROW_NUMBER() OVER(ORDER BY id DESC) rn FROM board WHERE " + searchOpt + " like ? ORDER BY id DESC) WHERE rn BETWEEN ? AND ?";
        return jdbc.query(sql, new BeanPropertyRowMapper<>(BoardDTO.class),
                "%" + target + "%",
                curPage * itemPerPage - (itemPerPage - 1),
                curPage * itemPerPage);
    }

    public int getMaxPage(int itemPerPage) {
        String sql = "SELECT count(*) FROM board";
        Integer itemCount = jdbc.queryForObject(sql, Integer.class);

        if(itemCount != null) {
           return (itemCount - 1) / itemPerPage + 1;
        } else {
            return 0;
        }
    }

    public int getMaxPage(String searchOpt, String search, int itemPerPage) {
        String sql = "SELECT count(*) FROM board WHERE " + searchOpt + " like ?";
        Integer itemCount = jdbc.queryForObject(sql, Integer.class, "%" + search + "%");

        if(itemCount != null) {
            return (itemCount - 1) / itemPerPage + 1;
        } else {
            return 0;
        }
    }

    public BoardDTO getPostById(int target) {
        String sql = "SELECT * FROM board WHERE id=?";
        return jdbc.queryForObject(sql, new BeanPropertyRowMapper<>(BoardDTO.class), target);
    }
    //endregion

    //region delete
    public void deletePostById(int target) {
        String sql = "DELETE FROM board WHERE id=?";
        jdbc.update(sql, target);
    }
    //endregion

    //region update
    public void updatePostById(BoardDTO target) {
        String sql = "UPDATE board SET title=?, contents=? WHERE id=?";
        jdbc.update(sql, target.getTitle(), target.getContents(), target.getId());
    }

    public void updatePostsViewCntById(int target) {
        String sql = "UPDATE board SET view_count = view_count+1 WHERE id=?";
        jdbc.update(sql, target);
    }
    //endregion
}
