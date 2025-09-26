package com.vvs.platform.controller.user;

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
            session.setAttribute("loginUser", user);
            mav.setViewName("user/index");
        } else {
            mav.addObject("error", "아이디 또는 비밀번호가 잘못되었습니다.");
            mav.setViewName("user/login");
        }

        return mav;
    }
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate(); 
        return "/user/index";  
    }

}
