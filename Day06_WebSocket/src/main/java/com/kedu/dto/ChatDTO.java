package com.kedu.dto;

public class ChatDTO {
	private String type;
	private Object data;
	
	public ChatDTO() {
	}

	public ChatDTO(String type, Object data) {
		super();
		this.type = type;
		this.data = data;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Object getData() {
		return data;
	}

	public void setData(Object data) {
		this.data = data;
	}
}