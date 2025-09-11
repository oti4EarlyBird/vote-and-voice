package com.vvs.platform.controller.user;

import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Component
@RequestMapping("/user")
public class UserNoticeController {

	// 공지사항 목록
	@RequestMapping("/notice")
	public ModelAndView notice(@RequestParam(value= "page", defaultValue="1") int page) {
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("user/userNotice");
		
		return mav;
	}
	
	// 공지사항 상세보기
	@RequestMapping(value="/notice/detail/{noticeSeq}")
	public ModelAndView noticeDetail(@PathVariable("noticeSeq") int noticeSeq) {
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("user/userNoticeDetail");
		return mav;
	}
	
	
}
