package com.kedu.controllers;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.nio.charset.StandardCharsets;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kedu.dto.FileDTO;
import com.kedu.services.FileService;


@Controller
@RequestMapping("/file")
public class FileController {

    @Autowired
    private FileService fileService;

    @ResponseBody
    @RequestMapping("/list")
    public List<FileDTO> getList(int parentSeq) {
        return fileService.list(parentSeq);
    }

    @RequestMapping("/download")
    public void download(String oriName, String sysName, HttpSession session, HttpServletResponse response) throws Exception {
        String realPath = session.getServletContext().getRealPath("upload");
        File target = new File(realPath + "/" + sysName);

        oriName = new String(oriName.getBytes(StandardCharsets.UTF_8), StandardCharsets.ISO_8859_1);
        response.setHeader("content-disposition", "attachment;filename=\"" + oriName + "\"");

        try (DataInputStream dis = new DataInputStream(new FileInputStream(target));
             DataOutputStream dos = new DataOutputStream(response.getOutputStream())) {
            byte[] fileContents = dis.readAllBytes();
            dos.write(fileContents);
            dos.flush();
        }
    }
}
