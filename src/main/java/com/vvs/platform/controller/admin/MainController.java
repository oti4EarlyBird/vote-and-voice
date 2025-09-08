package com.vvs.platform.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class MainController {
	@GetMapping("/main")
	public String index() {
		System.out.println("MainController: 홈 페이지 요청이 처리되었습니다.");
		return "admin/index";
	}
}