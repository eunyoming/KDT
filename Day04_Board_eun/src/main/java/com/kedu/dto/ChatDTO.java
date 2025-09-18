package com.kedu.dto;

import java.sql.Timestamp;

public class ChatDTO {
	private int seq;
	private String sender;
	private String content;
	private Timestamp time;

	public ChatDTO() {}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getSender() {
		return sender;
	}

	public void setSender(String sender) {
		this.sender = sender;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Timestamp getTime() {
		return time;
	}

	public void setTime(Timestamp time) {
		this.time = time;
	}
	
	// 채팅 한개용
	public ChatDTO(int seq, String sender, String content, Timestamp time) {
		super();
		this.seq = seq;
		this.sender = sender;
		this.content = content;
		this.time = time;
	}
}
