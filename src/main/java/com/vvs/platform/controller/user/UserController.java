package com.vvs.platform.controller.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.vvs.platform.service.user.UserService;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@RequestMapping("/")
	public String index() {
		//ModelAndView
		return "user/index";
	}

}
