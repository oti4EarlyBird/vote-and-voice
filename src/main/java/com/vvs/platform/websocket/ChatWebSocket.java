package com.vvs.platform.websocket;

import java.util.Collections;
import java.util.Date;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PathVariable;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@ServerEndpoint(value="/chatt/{roomId}")
public class ChatWebSocket {

	// 채팅방별로 사용자 세션 저장
	private static final Map<String, Set<Session>> roomSessions = new ConcurrentHashMap<>();
	//private static Set<Session> clientSet = Collections.synchronizedSet(new HashSet<Session>());
	public ChatWebSocket() {
		System.out.println("ChatWebSocket 객체 생성");
		log.info("ChatWebSocket 객체 생성 -- 로그");
	}

	@OnOpen
	public void onOpen(@PathParam("roomId") String roomId, Session session) {
		log.info("클라이언트 입장 : roomId: {}, sessionId: {}", roomId, session.getId());
		Set<Session> sessions = roomSessions.computeIfAbsent(roomId, k -> Collections.synchronizedSet(new HashSet<Session>()));
		sessions.add(session);
		
		broadcast(roomId, "📥 사용자 입장: " + session.getId(), "system");
	}
	
	@OnMessage
	public void onMessage(String message, Session session, @PathParam("roomId") String roomId) {
		log.info("💬 메시지 수신 - roomId: {}, sessionId: {}, msg: {}", roomId, session.getId(), message);
		
		broadcast(roomId, message, "보내는 사람");
	}
	
	@OnClose
	public void onClose(Session session, @PathParam("roomId") String roomId) {
		// Session session : 한 명의 사용자 연결 정보 
		log.info("🔴 클라이언트 퇴장 - roomId: {}, sessionId: {}", roomId, session.getId());
		
		// sessions : 같은 방의 사용자들 
		Set<Session> sessions = roomSessions.get(roomId);
		if(sessions != null) {
			sessions.remove(session);
			broadcast(roomId, "🚪 사용자 퇴장: " + session.getId(), "system");
		}
	}
	
	@OnError
	public void onError(Session session, @PathParam("roomId") String roomId, Throwable throwable) {
		log.error("❌ 에러 발생 - roomId: {}, sessionId: {}, error: {}", roomId, session.getId(), throwable.getMessage());
		
		
	}
	
	public void broadcast(String roomId, String message, String sender) {
		Set<Session> sessions = roomSessions.get(roomId);
		
		if(sessions == null) return;
		String jsonMessage = String.format(
				"{\"sender\": \"%s\", \"message\": \"%s\", \"timestamp\": \"%s\"}"
				, sender
				, message.replace("\"", "\\\"")
				, new Date().toString());
	
		for(Session s : sessions) {
			try {
				s.getBasicRemote().sendText(jsonMessage);
			}catch(Exception e){
				log.error("메시지 전송 실패 : {}", e.getMessage());
			}
		}
	}
}
