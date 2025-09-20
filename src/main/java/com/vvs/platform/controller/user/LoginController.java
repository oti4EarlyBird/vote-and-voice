package com.vvs.platform.controller.user;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.vvs.platform.dto.user.LoginDTO;
import com.vvs.platform.service.user.LoginService;

@Controller
@RequestMapping("/user")
public class LoginController {

	@Autowired
    private LoginService loginService;
	
	// 로그인 페이지 표시용 GET 매핑 
    @GetMapping("/login")
    public String loginForm() {
        return "user/login";
    }

    @PostMapping("/login")
    public ModelAndView login(String userid, String password, HttpSession session) {
        ModelAndView mav = new ModelAndView();
        System.out.println("Controller received userid=" + userid + ", password length=" + (password==null?0:password.length()));
        LoginDTO user = loginService.login(userid, password);

        if (user != null) {
        	// 로그인 성공 → 세션에 유저 저장
            session.setAttribute("loginUser", user);
            mav.setViewName("user/index"); // 메인으로 이동
        } else {
            // 로그인 실패 → 로그인 페이지로 이동하면서 에러 메시지 전달
            mav.addObject("error", "아이디 또는 비밀번호가 잘못되었습니다.");
            mav.setViewName("user/login");
        }

        return mav;
    }
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate(); // 세션 전체 삭제
        return "/user/";  // 메인으로 이동
    }

}
