package com.vvs.platform.dao.user;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.vvs.platform.dto.user.ChatRoomDTO;

@Mapper
public interface UserChatDAO {

	// 채팅방 생성
	int insertChatRoom(ChatRoomDTO chatRoomDTO);
	
	// 채팅방 전체 목록 select 
	List<ChatRoomDTO> selectAllChatRooms();

	// 채팅방 개수
	int getNoticeTotalCount();

	List<ChatRoomDTO> selectAllChatRoomsMap(Map<String, Object> map);

}
