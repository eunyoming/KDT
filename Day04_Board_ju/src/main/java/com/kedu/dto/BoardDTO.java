package com.kedu.dto;

import java.sql.Timestamp;

public class BoardDTO {
	private long id;
	private String title;
	private String writer;
	private String contents;
	private long viewCount;
	private Timestamp writeDate;

	public BoardDTO(long id, String title, String writer, String contents, long viewCount, Timestamp writeDate) {
		super();
		this.id = id;
		this.title = title;
		this.writer = writer;
		this.contents = contents;
		this.viewCount = viewCount;
		this.writeDate = writeDate;
	}
	public BoardDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public long getViewCount() {
		return viewCount;
	}
	public void setViewCount(long viewCount) {
		this.viewCount = viewCount;
	}
	public Timestamp getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(Timestamp writeDate) {
		this.writeDate = writeDate;
	}
}

