package com.kedu.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kedu.dto.ContactsDTO;

@Repository
public class ContactsDAO {

	@Autowired
	private SqlSessionTemplate mybatis;

	public int insert(ContactsDTO dto) {
		return mybatis.insert("Contacts.insert", dto);
	}

	public List<ContactsDTO> getAllList() {
		return mybatis.selectList("Contacts.getAllList");
	}

	public int deleteBySeq(int seq) {
		String sql = "delete from contacts where seq = ?";

		return mybatis.delete("Contacts.deleteBySeq", seq);
	}

	public int updateBySeq(ContactsDTO dto) {
		String sql = "update contacts set name = ?, phone = ? where seq = ?";

		return mybatis.update("Contacts.updateBySeq", dto);
	}

}
