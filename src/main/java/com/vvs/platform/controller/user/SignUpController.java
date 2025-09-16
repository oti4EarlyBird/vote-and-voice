package com.vvs.platform.controller.user;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.vvs.platform.dao.user.UserSignUpDAO;
import com.vvs.platform.dto.user.UserSignUpDTO;
import com.vvs.platform.service.user.EmailSendService;
import com.vvs.platform.service.user.SignUpService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/user") 
@RequiredArgsConstructor
@Slf4j 
public class SignUpController {

    private final SignUpService userService;
    private final UserSignUpDAO userDAO;
    private final EmailSendService emailSendService;
    
    @GetMapping("/signup")
    public ModelAndView showSignUpForm() {
        ModelAndView mav = new ModelAndView("user/signup");
        mav.addObject("keywords", userDAO.getAllKeywords());
        return mav;
    }
    // 이메일 인증 요청
    @PostMapping("/sendEmailCode")
    @ResponseBody
    public String sendEmailCode(String email, HttpSession session) {
        try {
            String code = emailSendService.sendAuthCode(email);
            session.setAttribute("emailAuthCode", code); // 세션에 코드 저장
            session.setAttribute("emailAuthTarget", email);
            return "success";
        } catch (Exception e) {
            return "fail";
        }
    }

    // 이메일 인증 코드 확인
    @PostMapping("/verifyEmailCode")
    @ResponseBody
    public String verifyEmailCode(String email, String code, HttpSession session) {
        String sessionCode = (String) session.getAttribute("emailAuthCode");
        String sessionEmail = (String) session.getAttribute("emailAuthTarget");
        
        System.out.println("Session email: " + session.getAttribute("emailAuthTarget"));
        System.out.println("Session code: " + session.getAttribute("emailAuthCode"));
        System.out.println("Input email: " + email + ", code: " + code);

        if (sessionCode != null && sessionEmail != null 
            && sessionCode.equals(code) && sessionEmail.equals(email)) {
            session.setAttribute("emailVerified", true); // 인증 완료 표시
            return "success";
        }
        return "fail";
    }
    
    @PostMapping("/signup")
    public ModelAndView processSignUp(UserSignUpDTO userDTO, HttpSession session) {
    	log.info("회원가입 요청: {}", userDTO);
        ModelAndView mav = new ModelAndView("user/signup");
        try {
        	Boolean verified = (Boolean) session.getAttribute("emailVerified");
        	if(verified == null || !verified) {
        		mav.addObject("errorMessage", "이메일 인증을 완료해야 가입이 가능합니다.");
        	}
        	else {
        		userService.signUp(userDTO);
                mav.addObject("successMessage", "회원가입이 완료되었습니다!");
                session.removeAttribute("emailVerified");
                session.removeAttribute("emailAuthCode");
                session.removeAttribute("emailAuthTarget");
        	}
            
        } catch (Exception e) {
            mav.addObject("errorMessage", "회원가입 중 오류가 발생했습니다.");
            e.printStackTrace();
        }
        mav.addObject("keywords", userDAO.getAllKeywords());
        return mav;
    } 
    
}
