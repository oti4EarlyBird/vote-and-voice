package com.vvs.platform.websocket;

import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
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

import com.fasterxml.jackson.databind.ObjectMapper;

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
		
		if (!sessions.contains(session)) {
	        sessions.add(session);
	    }
		//broadcast(roomId, "", session.getId(), "join");
		//broadcast(roomId, session.getId()+"님 입장", "system");
	}
	
	@OnMessage
	public void onMessage(String jsonMessage, Session session, @PathParam("roomId") String roomId) {
		// 클라이언트에서 보낸 메시지를 수신하고 파싱
		log.info("💬 메시지 수신 - roomId: {}, sessionId: {}, msg: {}", roomId, session.getId(), jsonMessage);
		
		try {
			ObjectMapper mapper = new ObjectMapper();
			Map<String, String> msgMap = mapper.readValue(jsonMessage, Map.class);
			
			String type = msgMap.getOrDefault("type", "chat");
			String sender = msgMap.get("sender");
			String message = msgMap.get("message");
			
			// 비로그인사용자 처리 : sender가 null이나 공백이면 sessionId의 4자리 이용
			if(sender == null || sender.trim().isEmpty()) {
				String sessionId = session.getId();
				sender = sessionId.length() >= 4? sessionId.substring(sessionId.length()-4): sessionId;
			}
			
			switch (type) {
	            case "join":
	                broadcast(roomId, "", sender, "join");
	                break;
	            case "chat":
	                broadcast(roomId, message, sender, "chat");
	                break;
	            default:
	                log.warn("알 수 없는 메시지 타입: {}", type);
	        }
			
			//broadcast(roomId, message, sender);
		}catch(Exception e) {
			log.error("메시지 파싱 오료 : {}", e.getMessage());
		}
	}
	
	@OnClose
	public void onClose(Session session, @PathParam("roomId") String roomId) {
		// Session session : 한 명의 사용자 연결 정보 
		log.info("🔴 클라이언트 퇴장 - roomId: {}, sessionId: {}", roomId, session.getId());
		
		// sessions : 같은 방의 사용자들 
		Set<Session> sessions = roomSessions.get(roomId);
		if(sessions != null) {
			sessions.remove(session);

			String sessionId = session.getId();
			String sender = sessionId.length() >= 4 ? sessionId.substring(sessionId.length() - 4) : sessionId;

			broadcast(roomId, "", sender, "leave");
			//broadcast(roomId, session.getId() + "님 퇴장", "system");
		}
	}
	
	@OnError
	public void onError(Session session, @PathParam("roomId") String roomId, Throwable throwable) {
		log.error("❌ 에러 발생 - roomId: {}, sessionId: {}, error: {}", roomId, session.getId(), throwable.getMessage());
		
		
	}
	
	public void broadcast(String roomId, String message, String sender, String type) {
		// 여러 세션에 JSON 메시지 전송 , 직렬화
		log.info("📤 전송되는 메시지 JSON: {}", message);
		
		Set<Session> sessions = roomSessions.get(roomId);
		
		if(sessions == null) return;
		
		try {
			ObjectMapper mapper = new ObjectMapper();
			Map<String, String> messageMap = new HashMap<>();
			messageMap.put("type", type);
			messageMap.put("sender", sender);
			messageMap.put("message", message);
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm a");
			String timeString = LocalTime.now().format(formatter);
			messageMap.put("timestamp", timeString);
			
			String jsonMessage = mapper.writeValueAsString(messageMap);
			log.info("전송메시지 : {}", jsonMessage);
			
			
			for(Session s : sessions) {
				s.getBasicRemote().sendText(jsonMessage);
			}
		}catch(Exception e) {
			log.error("메시지 전송 실패 : {}", e.getMessage());			
		}
	}
	
	
	
}
