package com.vvs.platform.controller.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.vvs.platform.dto.admin.PageDTO;
import com.vvs.platform.dto.user.ChatRoomDTO;
import com.vvs.platform.dto.user.LoginDTO;
import com.vvs.platform.service.user.UserChatService;

@Controller
@RequestMapping("/user")
public class UserChatController {
	@Autowired
	private UserChatService chatService;
	
	@RequestMapping("/chat")
	public ModelAndView chatList(@RequestParam(value="page", defaultValue="1") int page) {
		ModelAndView mav = new ModelAndView();
		
		//페이징
		PageDTO pageDTO = new PageDTO(page, 5);
		Map<String, Object> map = new HashMap<>();
		//map.put("category", category);	
		
		// 총 게시글 수 
		int totalCnt = chatService.getNoticeTotalCount();
		pageDTO.setTotalCnt(totalCnt);
		map.put("offset", pageDTO.getStartList());
		map.put("limit", pageDTO.getListSize());

		
		
		// 채팅방 목록 조회 
//		List<ChatRoomDTO> chatRooms = chatService.getChatRoomList();
		List<ChatRoomDTO> chatRooms = chatService.getChatRoomList(map);

		mav.addObject("pageDTO", pageDTO);
		mav.addObject("chatRooms", chatRooms);
		mav.setViewName("user/chatList");
		return mav;
	}
	
	
	
	@RequestMapping("/chat/room/{chatRoomId}")
	public ModelAndView chatRoom(@PathVariable("chatRoomId") Long chatRoomId, HttpSession session) {
		// 로그인사용자 세션
		LoginDTO loginDTO = (LoginDTO) session.getAttribute("loginUser");
		
		// 디베에서 채팅방 정보 조회 후 전달 
		ModelAndView mav = new ModelAndView();
		mav.addObject("chatRoomId",chatRoomId);
		mav.addObject("loginUser",loginDTO);
		
		mav.setViewName("user/chatRoom");
		return mav;
	}
}
