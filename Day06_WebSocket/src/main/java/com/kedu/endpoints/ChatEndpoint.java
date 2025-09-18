package com.kedu.endpoints;

import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.http.HttpSession;
import javax.websocket.EndpointConfig;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import com.google.common.collect.EvictingQueue;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.kedu.config.WebSocketConfigurator;
import com.kedu.dto.ChatDTO;


// configurator를 내가 만든 class로 지정하면, 내가 설정한  handshake 설정으로 작동한다.
@ServerEndpoint(value = "/chat", configurator = WebSocketConfigurator.class)
public class ChatEndpoint {

	// Session 보관
	// Set은 List와 달리 중복 허용을 안 함.
	// 그냥 만들면 각자 ChatEndpoint 인스턴스가 생성돼서 각자 저장되므로
	// 모든 사용자가 공유하게끔 static으로 생성
	private static Set<Session> clients = Collections.synchronizedSet(new HashSet<>());
	private static EvictingQueue<String> history = EvictingQueue.create(300);
	// 나중에 타입은 ID, 메세지를 담는 DTO로 담아야 됨.
	private static Gson gson = new Gson();

	private HttpSession hSession;

	// 1. 최초 접속시 실행되는 메서드
	@OnOpen // 어노테이션이 중요. 메서드명은 상관 없음. 
	public void onConnection(Session session, EndpointConfig config) {
		// httpSession 아님. 웹소켓 Session임.
		clients.add(session);
		this.hSession = (HttpSession)config.getUserProperties().get("hSession");
		System.out.println(this.hSession.getAttribute("loginId"));
		
		// history를 담은 객체 만들기
		ChatDTO dto = new ChatDTO("history", ChatEndpoint.history);
		
//		// history 객체 만들기
//		JsonObject history = new JsonObject();
//		// type : history 속성 추가
//		history.addProperty("type", "history");
//		// contents : message 내용 추가
//		history.addProperty("contents", gson.toJson(ChatEndpoint.history));

		// 새로운 접속자한테 history 보내주기
		try {
			// 위 객체를 직렬화 해서 보냄
			session.getBasicRemote().sendText(gson.toJson(dto));
		}catch(Exception e) {

		}
	}

	// 2. 받은 메세지 모든 사용자한테 메세지 전송해주기
	@OnMessage // 메세지 전송
	public void onMessage(String message) {
		// 메세지 기록
		history.add(message);
		
		ChatDTO dto = new ChatDTO("chat", message);
		// synchronized 블럭 = 동기화 블럭
		synchronized(clients) {
			for(Session client : clients) {
				// 여기서 생기는 예외는 throws 시키면 예외 생기는 순간 뒷 사람들은 메세지를 못 보낸다.
				try {
					client.getBasicRemote().sendText(gson.toJson(dto));
				}catch(Exception e) {
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
