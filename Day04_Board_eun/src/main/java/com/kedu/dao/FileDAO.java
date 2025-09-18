package com.kedu.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kedu.dto.FileDTO;

@Repository
public class FileDAO {

	@Autowired
	private SqlSessionTemplate mybatis;

	// insert
	public int insert(FileDTO dto) {
		return mybatis.insert("Files.insert", dto);
	}

	// select * from files
	public List<FileDTO> getAllList() {
		return mybatis.selectList("File.getAllList");
	}

}
