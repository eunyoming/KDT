package com.kedu.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.springframework.stereotype.Repository;

import com.kedu.dto.ReplyDTO;

@Repository
public class ReplyDAO {
	private static ReplyDAO instance;

	// DAO 생성 막기
	private ReplyDAO() {}

	// DAO getter
	public synchronized static ReplyDAO getInstance() {
		if(instance == null) {
			instance = new ReplyDAO();
		}
		return instance;
	}

	// Connection
	public Connection getConnection() throws Exception{
		Context ctx = new InitialContext();

		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}

	// insert
	public int insertReply(ReplyDTO dto) throws Exception{
		String sql = "insert into reply values(reply_seq.nextval, ?, ?, sysdate, ?)";

		try(Connection con = this.getConnection();
				PreparedStatement pst = con.prepareStatement(sql)){
			pst.setString(1, dto.getWriter());
			pst.setString(2, dto.getContents());
			pst.setInt(3, dto.getParent_seq());

			return pst.executeUpdate();
		}
	}

	// "select * from reply";
	public List<ReplyDTO> getAllList() throws Exception{
		String sql = "select * from reply";

		try(Connection con = this.getConnection();
				PreparedStatement pst = con.prepareStatement(sql);
				ResultSet rs = pst.executeQuery();){

			List<ReplyDTO> list = new ArrayList<>();
			while(rs.next()) {
				int seq = rs.getInt("seq");
				String writer = rs.getString("writer");
				String contents = rs.getString("contents");
				Timestamp write_date = rs.getTimestamp("write_date");
				int parent_seq = rs.getInt("parent_seq");

				ReplyDTO dto = new ReplyDTO(seq, writer, contents, write_date, parent_seq);
				list.add(dto);
			}
			return list;
		}
	}

	// select * from reply where parent_seq = ?
	public List<ReplyDTO> getListBySeq(int parent_seq) throws Exception{
		String sql = "select * from reply where parent_seq = ? order by seq desc";

		try(Connection con = this.getConnection();
				PreparedStatement pst = con.prepareStatement(sql);){
			pst.setInt(1, parent_seq);

			try(ResultSet rs = pst.executeQuery();){

				List<ReplyDTO> list = new ArrayList<>();

				while(rs.next()) {
					int seq = rs.getInt("seq");
					String writer = rs.getString("writer");
					String contents = rs.getString("contents");
					Timestamp write_date = rs.getTimestamp("write_date");
					parent_seq = rs.getInt("parent_seq");

					ReplyDTO dto = new ReplyDTO(seq, writer, contents, write_date, parent_seq);
					list.add(dto);
				}
				return list;
			}
		}
	}

	// delete
	public int deleteBySeq(int seq) throws Exception{
		String sql = "delete from reply where seq = ?";

		try(Connection con = this.getConnection();
				PreparedStatement pst = con.prepareStatement(sql)){
			pst.setInt(1, seq);

			return pst.executeUpdate();
		}
	}

	// update
		public int updateBySeq(String contents, int seq) throws Exception{
			String sql = "update reply set contents = ? where seq = ?";

			try(Connection con = this.getConnection();
					PreparedStatement pst = con.prepareStatement(sql)){
				pst.setString(1, contents);
				pst.setInt(2, seq);

				return pst.executeUpdate();
			}
		}
}
