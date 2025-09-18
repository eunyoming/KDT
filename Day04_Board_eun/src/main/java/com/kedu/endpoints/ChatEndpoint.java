package com.kedu.endpoints;

import java.sql.Timestamp;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;
import javax.websocket.EndpointConfig;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import com.google.gson.Gson;
import com.kedu.commons.SpringProvider;
import com.kedu.commons.WebSocketConfigurator;
import com.kedu.dto.ChatDTO;
import com.kedu.services.ChatService;

@ServerEndpoint(value = "/chat", configurator = WebSocketConfigurator.class)
public class ChatEndpoint {

	public static Set<Session> clients = Collections.synchronizedSet(new HashSet<>());
	public static Gson gson = new Gson();
	
	// DI를 못 쓰므로 DL 사용
	// Spring 인스턴스의 주소를 저장한 클래스에 참조해서 getBean하기
	private ChatService chatService = SpringProvider.ctx.getBean(ChatService.class);
	
	private HttpSession hSession;

	// 1. 접속시
	@OnOpen
	public void join(Session session, EndpointConfig config) {
		// 클라이언트 접속 세션 저장하기
		clients.add(session);
		// 접속한 클라이언트가 누군지 정보 가져오기
		this.hSession = (HttpSession)config.getUserProperties().get("hSession");
		
		// history를 담은 객체 담아오기
		List<ChatDTO> list = chatService.selectAll();
		
		// type 넣어주기
		Map<String, Object> map = new HashMap<>();
		map.put("type", "history");
		map.put("list", list);

		// 새로운 접속자한테 history 보내주기
		try {
			// 위 객체를 직렬화 해서 보냄
			session.getBasicRemote().sendText(gson.toJson(map));
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	// 2. 메세지 전송
	@OnMessage
	public void onMessage(String message) {
		// sender 알아오기
		String loginId = (String)this.hSession.getAttribute("loginId");
		
		// 현재 시간 생성
		Timestamp time = new Timestamp(System.currentTimeMillis());
		
		// ChatDTO 생성 (단일 채팅용)
	    ChatDTO dto = new ChatDTO(0, loginId, message, time);
	    
	    // 메세지 저장
		chatService.insert(dto);
		
		synchronized(clients) {
			for(Session client : clients) {
				try {
					client.getBasicRemote().sendText(gson.toJson(dto));
				}catch(Exception e) {
					e.printStackTrace();
				}
			}
		}
	}

	@OnClose // 접속 해제
	public void onClose(Session session) {
		clients.remove(session);
	}

	@OnError // 접속 에러
	public void onError(Session session, Throwable t) {
		clients.remove(session);
		t.printStackTrace();
	}


}
