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

import com.kedu.config.WebSocketConfigurator;

@ServerEndpoint(value = "/chat", configurator = WebSocketConfigurator.class)
// configurator를 내가 만든 class로 지정하면, 내가 설정한  handshake 설정으로 작동한다.
public class ChatEndpoint {

	// Session 보관
	// Set은 List와 달리 중복 허용을 안 함.
	// 그냥 만들면 각자 ChatEndpoint 인스턴스가 생성돼서 각자 저장되므로
	// 모든 사용자가 공유하게끔 static으로 생성
	public static Set<Session> clients = Collections.synchronizedSet(new HashSet<>());
	
	private HttpSession hSession;
	//최초 접속시 실행되는 메서드
	@OnOpen // 어노테이션이 중요. 메서드명은 상관 없음. 
	public void onConnection(Session session, EndpointConfig config) {
		// httpSession 아님. 웹소켓 Session임.
		clients.add(session);
		this.hSession = (HttpSession)config.getUserProperties().get("hSession");
		System.out.println(this.hSession.getAttribute("loginId"));
	}

	@OnMessage // 메세지 전송
	public void onMessage(String message) {
		// synchronized 블럭 = 동기화 블럭
		synchronized(clients) {
			for(Session client : clients) {
				// 여기서 생기는 예외는 throws 시키면 예외 생기는 순간 뒷 사람들은 메세지를 못 보낸다.
				try {
					client.getBasicRemote().sendText(message);
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
