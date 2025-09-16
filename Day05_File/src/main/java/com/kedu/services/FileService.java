package com.kedu.services;

import java.io.File;
import java.io.FileOutputStream;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kedu.dao.FileDAO;
import com.kedu.dto.FileDTO;

@Service
public class FileService {
	
	@Autowired
	private FileDAO fileDAO;
	
	public List<FileDTO> getAllFiles(){
		return fileDAO.getAllFiles();
	}
	
	public int insert(FileDTO dto) {
		return fileDAO.insert(dto);
	}
	
	public void upload(String text, String realPath, String oriName, byte[] fileContents) throws Exception{
		
		File realPathFile = new File(realPath);
		if(!realPathFile.exists()) {
			realPathFile.mkdir();
		}
		
		String sysName = UUID.randomUUID() + "_" + oriName;
		try(FileOutputStream fos = new FileOutputStream(realPath);){
			fos.write(fileContents);
			fos.flush();
		}
		fileDAO.insert(new FileDTO(0, text, oriName, sysName, 0));
	}
}
