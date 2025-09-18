package com.kedu.commons;

import javax.servlet.http.HttpSession;
import javax.websocket.HandshakeResponse;
import javax.websocket.server.HandshakeRequest;
import javax.websocket.server.ServerEndpointConfig;
import javax.websocket.server.ServerEndpointConfig.Configurator;

public class WebSocketConfigurator extends Configurator{

	// Hanshake 수정하는 메서드 오버라이딩
	@Override
	public void modifyHandshake(ServerEndpointConfig sec, HandshakeRequest request, HandshakeResponse response) {
		HttpSession session = (HttpSession)request.getHttpSession();
		sec.getUserProperties().put("hSession", session);
		// Map으로 리턴하므로 put해서 값을 넣어줄 수 있음.
	}
}
