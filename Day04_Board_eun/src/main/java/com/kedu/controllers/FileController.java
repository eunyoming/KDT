package com.kedu.controllers;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kedu.dto.FileDTO;
import com.kedu.services.FileService;

@Controller
@RequestMapping("/file")
public class FileController {
	
	@Autowired
	private FileService filesService;

//	@RequestMapping("/upload")
//	public String upload(String text, MultipartFile[] files, HttpSession session) throws Exception{
//		String realPath = session.getServletContext().getRealPath("upload");
//
//
//		for(MultipartFile file : files) {
//			// 파일이 비어있지 않다면
//			if(!file.isEmpty()) {
//				String oriName = file.getOriginalFilename();
//				// UUID : 유니크한 식별자 ID를 만들어내는 함수
//				String sysName = UUID.randomUUID() + "_" + oriName;
//
//				// upload 파일에 저장 ( 파일경로 + 파일명 )
//				file.transferTo(new File(realPath + "/" + sysName));
//				filesService.upload(text, realPath, oriName, file.getBytes());
//				// DB 작업
//				fileService.insert(new FileDTO(0, text, oriName, sysName, 0));
//			}	
//		}
//		return "redirect:/";
//	}
	
	@ResponseBody
	@RequestMapping("/list")
	public List<FileDTO> list() {
		return filesService.getAllList();
	}
	
	@RequestMapping("/download")
	public void download(HttpServletResponse resp, HttpSession session, String sysname, String oriname) throws Exception{
		String realPath = session.getServletContext().getRealPath("upload");
		File target = new File(realPath + "/" + sysname);
		
		// 인코딩
		oriname = new String(oriname.getBytes("utf8"), "ISO-8859-1");
		
		// HTTP 응답 헤더 설정 ( resp야 이건 파일 다운으로 처리해야 돼 )
		resp.setHeader("content-disposition", "attachment;filename=\""+oriname+"\"");
		
		// 데이터 통로 열고, 담아서 보내기.
		try(DataInputStream dis = new DataInputStream(new FileInputStream(target));
				DataOutputStream dos = new DataOutputStream(resp.getOutputStream());){
			byte[] fileContents = dis.readAllBytes();
			dos.write(fileContents);
			dos.flush();
		}
	}
	
	@ResponseBody
	@RequestMapping("/upload")
	public String upload(MultipartFile file, HttpSession session) throws Exception {
	    String realPath = session.getServletContext().getRealPath("upload");

	    File realPathDir = new File(realPath);
	    if (!realPathDir.exists()) realPathDir.mkdir();

	    // 원래 파일명, 시스템 파일명
	    String oriname = file.getOriginalFilename();
	    String sysname = System.currentTimeMillis() + "_" + oriname;

	    // 실제 저장
	    file.transferTo(new File(realPath, sysname));

	    // 파일 DB 저장
	    FileDTO dto = new FileDTO();
	    dto.setOriName(oriname);
	    dto.setSysName(sysname);
	    // writer, parent_seq는 상황에 맞게 추가
	    filesService.insert(dto);

	    // 이미지 URL 리턴 (브라우저에서 접근 가능해야 함)
	    return session.getServletContext().getContextPath() + "/upload/" + sysname;
	}
	
}
