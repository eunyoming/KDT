package com.kedu.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kedu.dao.FileDAO;
import com.kedu.dto.FileDTO;

@Service
public class FileService {
	@Autowired
	private FileDAO filesDAO;
	
	public void insert(FileDTO dto) {
		filesDAO.insert(dto);
	}
	
	public List<FileDTO> getAllList() {
		return filesDAO.getAllList();
	}
	
}
