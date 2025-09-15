package com.vvs.platform.controller.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.vvs.platform.dao.user.UserSignUpDAO;
import com.vvs.platform.dto.user.UserSignUpDTO;
import com.vvs.platform.service.user.SignUpService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/user") 
@RequiredArgsConstructor
public class SignUpController {

    private final SignUpService userService;
    private final UserSignUpDAO userDAO;

    @GetMapping("/signup")
    public ModelAndView showSignUpForm() {
        ModelAndView mav = new ModelAndView("user/signup");
        mav.addObject("keywords", userDAO.getAllKeywords());
        return mav;
    }

    @PostMapping("/signup")
    public ModelAndView processSignUp(UserSignUpDTO userDTO) {
        ModelAndView mav = new ModelAndView("user/signup");
        try {
            userService.signUp(userDTO);
            mav.addObject("successMessage", "회원가입이 완료되었습니다!");
        } catch (Exception e) {
            mav.addObject("errorMessage", "회원가입 중 오류가 발생했습니다.");
        }
        mav.addObject("keywords", userDAO.getAllKeywords());
        return mav;
    }
}
