package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.FileDTO;

@Repository
public class FileDAO {
	
	@Autowired
	private JdbcTemplate jdbc;
	
	public int insert(FileDTO dto) {
		String sql = "insert into files values(files_seq.nextval, ?, ?, ?, 0)";
		return jdbc.update(sql, dto.getWriter(), dto.getOriName(), dto.getSysName());
	}
	
	public List<FileDTO> getAllFiles(){
		String sql = "select * from files";
		return jdbc.query(sql, new BeanPropertyRowMapper<>(FileDTO.class));
	}
}
