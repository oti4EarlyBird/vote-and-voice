package com.vvs.platform.controller.user;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


import com.vvs.platform.dto.user.KeywordDTO;
import com.vvs.platform.dto.user.KeywordsUpdateRequestDTO;
import com.vvs.platform.dto.user.LoginDTO;
import com.vvs.platform.service.user.UserAccountService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/user")
public class UserAccountController {

	@Autowired
	private UserAccountService accountService;
	
	@RequestMapping("/mypage")
	public ModelAndView userAccount(){
		ModelAndView mav = new ModelAndView();
		
		List<KeywordDTO> allKeywords = accountService.getAllKeywords();
		
		mav.addObject("allKeywords", allKeywords);
		mav.setViewName("user/userAccount");
		return mav;
	}
	
	
	@RequestMapping(value="/mypage/deleteAccount")
	@ResponseBody
	public String deleteAccount(HttpSession session, HttpServletResponse response) {
		try {	
			// 로그인한 사용자의 세션 정보 가져오기
			LoginDTO loginDTO = (LoginDTO) session.getAttribute("loginUser");
			// 계정 삭제
			boolean success = accountService.deleteAccount(loginDTO.getUserid());
			
			if(success) {
				session.invalidate(); // 세션 삭제
				
				// 쿠키 삭제 
				Cookie cookie = new Cookie("JSESSIONID", null);
				cookie.setPath("/platform");
				cookie.setMaxAge(0); // 즉시 만료
				response.addCookie(cookie);
				
				return "success";
			}else {
				return "fail";
			}
		}catch (Exception e) {
			log.error("계정 삭제 처리 중 예외 발생: {}", e.getMessage(), e);
			return "fail";
		}
	}
	
	
	@RequestMapping("/mypage/updateKeyword")
	public ResponseEntity<?> updateKeyword(@RequestBody KeywordsUpdateRequestDTO keywordReq, HttpSession session){
		LoginDTO loginDTO = (LoginDTO) session.getAttribute("loginUser");
		String userId = loginDTO.getUserid();
		System.out.println("keywordReq: " + keywordReq);
		boolean success = accountService.updateKeyword(userId, keywordReq.getKeywords());
		
		if (success) {
	        loginDTO.setInterestKeyword(keywordReq.getKeywords());
	        session.setAttribute("loginUser", loginDTO);

	        return ResponseEntity.ok("success");
	    } else {
	        return ResponseEntity.status(500).body("fail");
	    }
	}
	
	@RequestMapping("/mypage/userAccountKeywordCard")
	public String userAccountKeywordCard(Model model, HttpSession session) {
		LoginDTO loginDTO = (LoginDTO) session.getAttribute("loginUser");
		
		List<KeywordDTO> allKeywords = accountService.getAllKeywords();
		model.addAttribute("allKeywords", allKeywords);
		model.addAttribute("loginUser", loginDTO);
		
		return "/user/userAccountKeywordCard";
	}
	
	
	
	
}
