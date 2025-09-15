package com.kedu.dto;

import java.sql.Timestamp;

public class ReplyDTO {
	private int seq = 0;
	private String writer;
	private String contents;
	private Timestamp write_date;
	private int parent_seq = 0;
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
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public Timestamp getWrite_date() {
		return write_date;
	}
	public void setWriter_date(Timestamp write_date) {
		this.write_date = write_date;
	}
	public int getParent_seq() {
		return parent_seq;
	}
	public void setParent_seq(int parent_seq) {
		this.parent_seq = parent_seq;
	}
	public ReplyDTO() {
	}
	public ReplyDTO(int seq, String writer, String contents, Timestamp write_date, int parent_seq) {
		this.seq = seq;
		this.writer = writer;
		this.contents = contents;
		this.write_date = write_date;
		this.parent_seq = parent_seq;
	}


}
