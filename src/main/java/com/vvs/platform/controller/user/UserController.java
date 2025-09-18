package com.vvs.platform.controller.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.vvs.platform.service.BillService;
import com.vvs.platform.service.user.UserService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	BillService service;
	
	@RequestMapping("/")
	public String index() {
		//ModelAndView
		log.debug("debug 로그 테스트");
		//service.webcastvconf(); // API db 입력하느라;; 
		
		return "user/index";
	}
	

}
