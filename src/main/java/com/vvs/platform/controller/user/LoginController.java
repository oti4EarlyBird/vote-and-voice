package com.vvs.platform.controller.user;

import java.util.HashMap;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

@Controller
@SessionAttributes("userid")
@RequestMapping("/user")
public class LoginController {
    
    // 임시 계정 데이터 (DB 대신)
    public static HashMap<String, String> users = new HashMap<>();
    static {
        users.put("test", "1234"); // 아이디:test, 비번:1234
        users.put("admin", "admin"); // 추가 테스트 계정
    }
    
    // GET 요청 → 로그인 폼
    @GetMapping("/login")
    public ModelAndView showLoginForm() {
        return new ModelAndView("user/login");
    }
    
    // POST 요청 → 로그인 처리
    @PostMapping("/login")
    public ModelAndView processLogin(@RequestParam("userid") String userid,
            @RequestParam("password") String password, Model model) {

        
        ModelAndView mav = new ModelAndView();
        
        if (userid != null && password != null &&
            users.containsKey(userid) && users.get(userid).equals(password)) {
            
            // 로그인 성공
            mav.addObject("userid", userid);
            mav.setViewName("redirect:/main");
            
        } else {
            // 로그인 실패 → 에러 메시지 전달
            mav.addObject("error", "아이디 또는 비밀번호가 틀렸습니다.");
            mav.setViewName("user/login"); // redirect 제거하고 직접 뷰로 이동
        }
        
        return mav;
    }
    
    // 로그아웃
    @GetMapping("/logout")
    public String logout(SessionStatus sessionStatus) {
        sessionStatus.setComplete(); // 세션에서 userid 제거
        return "redirect:/user/login";
    }
    
}