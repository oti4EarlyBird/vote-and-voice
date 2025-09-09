package com.vvs.platform.controller.user;

import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Component
@RequestMapping("/user")
public class UserNoticeController {

	@RequestMapping("/notice")
	public ModelAndView notice() {
		ModelAndView mav = new ModelAndView();
		
		
		mav.setViewName("user/userNotice");
		
		return mav;
		
	}
	
	
}
