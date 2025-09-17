package com.kedu.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kedu.dao.FileDAO;

@Service
public class FileService {
	@Autowired
	private FileDAO filesDAO;
}
