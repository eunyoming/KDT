package com.kedu.dao;

import com.kedu.dto.MemberDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDAO {

    @Autowired
    private JdbcTemplate jdbc;

    //region insert
    public void insertMember(MemberDTO member) {
        String sql = "INSERT INTO members(id, pw, name, phone, email, zipcode, address1, address2) VALUES(?, ?, ?, ?, ?, ?, ?, ?)";
        jdbc.update(sql,
                member.getId(),
                member.getPw(),
                member.getName(),
                member.getPhone(),
                member.getEmail(),
                member.getZipcode(),
                member.getAddress1(),
                member.getAddress2());
    }
    //endregion

    //region select
    public boolean idDuplcheck(String id) {
        String sql = "SELECT count(*) FROM members WHERE id = ?";
        return jdbc.queryForObject(sql, Integer.class, id) > 0;
    }

    public boolean login(String id, String pw) {
        String sql = "SELECT count(*) FROM members WHERE id = ? AND pw = ?";
        return jdbc.queryForObject(sql, Integer.class, id, pw) > 0;
    }

    public MemberDTO getMemberInfoById(String targetId) {
        String sql = "SELECT * FROM members WHERE id = ?";
        return jdbc.queryForObject(sql, new BeanPropertyRowMapper<>(MemberDTO.class), targetId);
    }
    //endregion

    //region delete
    public void withdraw(String targetId) {
        String sql = "DELETE FROM members WHERE id = ?";
        jdbc.update(sql, targetId);
    }
    //endregion

    //region update
    public void updateMemberInfo(MemberDTO modifiedInfo) {
        String sql = "UPDATE members SET phone = ?, email = ?, zipcode = ?, address1 = ?, address2 = ? WHERE id = ?";
        jdbc.update(sql,
                modifiedInfo.getPhone(),
                modifiedInfo.getEmail(),
                modifiedInfo.getZipcode(),
                modifiedInfo.getAddress1(),
                modifiedInfo.getAddress1(),
                modifiedInfo.getId());
    }
    //endregion
}
