package com.vvs.platform.controller.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;

@Controller
@RequestMapping("/user")
public class SignUpController {

    // LoginController에서 공유한다고 가정
    private static final HashMap<String, String> users = LoginController.users;

    // 회원가입 폼(GET)
    @GetMapping("/signup")
    public ModelAndView showSignUpForm() {
        return new ModelAndView("signup"); // signup.jsp 로 이동
    }

    // 회원가입 처리(POST)
    @PostMapping("/signup")
    public ModelAndView processSignUp(
            @RequestParam("name") String name,
            @RequestParam("birth") String birth,
            @RequestParam("email") String email,
            @RequestParam("userid") String userid,
            @RequestParam("password") String password,
            @RequestParam("confirm") String confirm
    ) {
        ModelAndView mav = new ModelAndView();

        // 검증
        if (userid == null || userid.isEmpty() || password == null || password.isEmpty()) {
            mav.addObject("error", "아이디와 비밀번호를 모두 입력해주세요.");
            mav.setViewName("signup");
            return mav;
        }

        if (!password.equals(confirm)) {
            mav.addObject("error", "비밀번호와 확인이 일치하지 않습니다.");
            mav.setViewName("signup");
            return mav;
        }

        if (users.containsKey(userid)) {
            mav.addObject("error", "이미 존재하는 아이디입니다.");
            mav.setViewName("signup");
            return mav;
        }

        // 회원가입 성공 → 임시 HashMap에 저장
        users.put(userid, password);

        // 성공 후 로그인 페이지로 리다이렉트
        mav.setViewName("redirect:/user/login");
        return mav;
    }
}
