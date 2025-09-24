package com.vvs.platform.service.user;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vvs.platform.dao.user.UserChatDAO;
import com.vvs.platform.dto.user.ChatRoomDTO;

@Service
public class UserChatService {

	@Autowired
	private UserChatDAO chatDAO;
	
	// 채팅방 조회
	public List<ChatRoomDTO> getChatRoomList() {
		return chatDAO.selectAllChatRooms();
	}

	public int getNoticeTotalCount() {
		return chatDAO.getNoticeTotalCount();
	}

	public List<ChatRoomDTO> getChatRoomList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return chatDAO.selectAllChatRoomsMap(map);
	}

}
