package com.vvs.platform.controller.user;

import java.util.List;

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
		
		List<ChatRoomDTO> chatRooms = chatService.getChatRoomList();
		mav.addObject("chatRooms", chatRooms);
		
		
		mav.setViewName("user/chatList");
		return mav;
	}
	
	
	
	@RequestMapping("/chat/room/{chatRoomId}")
	public ModelAndView chatRoom(@PathVariable("chatRoomId") Long chatRoomId, HttpSession session) {

		LoginDTO loginDTO = (LoginDTO) session.getAttribute("loginUser");
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("chatRoomId",chatRoomId);
		mav.addObject("loginUser",loginDTO);
		
		mav.setViewName("user/chatRoom");
		return mav;
	}
}
