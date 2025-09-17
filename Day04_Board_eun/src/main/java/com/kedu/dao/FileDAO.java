package com.kedu.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kedu.dto.FileDTO;

@Repository
public class FileDAO {

	@Autowired
	private SqlSessionTemplate mybatis;

	// insert
	public int insert(FileDTO dto) throws Exception{
		String sql = "insert into files values(files_seq.nextval, ?, ?, ?, ?)";
		return mybatis.insert("Files.insert");
	}

	// select * from files
		public List<FileDTO> getAllList() throws Exception{
			String sql = "select * from files order by seq";

			try(Connection con = this.getConnection();
					PreparedStatement pst = con.prepareStatement(sql);
					ResultSet rs = pst.executeQuery();){

				List<FileDTO> list = new ArrayList<>();

				while(rs.next()) {
					int seq = rs.getInt("seq");
					String writer = rs.getString("writer");
					String oriName = rs.getString("oriName");
					String sysName = rs.getString("sysName");
					int parent_seq = rs.getInt("parent_seq");

					FileDTO dto = new FileDTO(seq, writer, oriName, sysName, parent_seq);
					list.add(dto);
				}
				return list;
			}
		}
}
