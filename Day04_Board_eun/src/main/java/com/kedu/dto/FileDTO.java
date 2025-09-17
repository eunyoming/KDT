package com.kedu.dto;

public class FileDTO {
	private int seq = 0;
	private String writer;
	private String oriName;
	private String sysName;
	private int parent_seq;
	
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
	public String getOriName() {
		return oriName;
	}
	public void setOriName(String oriName) {
		this.oriName = oriName;
	}
	public String getSysName() {
		return sysName;
	}
	public void setSysName(String sysName) {
		this.sysName = sysName;
	}
	public int getParent_seq() {
		return parent_seq;
	}
	public void setParent_seq(int parent_seq) {
		this.parent_seq = parent_seq;
	}
	public FileDTO(int seq, String writer, String oriName, String sysName, int parent_seq) {
		this.seq = seq;
		this.writer = writer;
		this.oriName = oriName;
		this.sysName = sysName;
		this.parent_seq = parent_seq;
	}
	public FileDTO() {
	}

}
