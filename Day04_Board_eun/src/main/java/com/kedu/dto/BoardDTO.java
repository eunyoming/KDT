package com.kedu.dto;

import java.sql.Timestamp;

public class BoardDTO {
	private int seq = 0;
	private String writer;
	private String title;
	private String contents;
	private Timestamp create_at;
	private int view_count = 0;
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public Timestamp getCreate_at() {
		return create_at;
	}
	public void setCreate_at(Timestamp create_at) {
		this.create_at = create_at;
	}
	public int getView_count() {
		return view_count;
	}
	public void setView_count(int view_count) {
		this.view_count = view_count;
	}
	public BoardDTO(int seq, String writer, String title, String contents, Timestamp create_at, int view_count) {
		super();
		this.seq = seq;
		this.writer = writer;
		this.title = title;
		this.contents = contents;
		this.create_at = create_at;
		this.view_count = view_count;
	}
	public BoardDTO() {
	}
	
}
