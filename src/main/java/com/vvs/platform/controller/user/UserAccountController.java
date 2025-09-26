package com.vvs.platform.controller.user;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


import com.vvs.platform.dto.user.KeywordDTO;
import com.vvs.platform.dto.user.KeywordsUpdateRequestDTO;
import com.vvs.platform.dto.user.LoginDTO;
import com.vvs.platform.dto.user.UserDTO;
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

	@PostMapping("/mypage/updateProfile")
	@ResponseBody
	public ResponseEntity<String> updateProfile (@RequestBody UserDTO userDTO, HttpSession session){
		try {
			log.info("프로필 업데이트 요청 : {}", userDTO);
			LoginDTO loginDTO = (LoginDTO) session.getAttribute("loginUser");
			if (loginDTO.getUserid().equals(userDTO.getId())) {
				loginDTO.setName(userDTO.getName());
				loginDTO.setPassword(userDTO.getPassword());
				loginDTO.setEmail(userDTO.getEmail());
	            List<String> existingInterestKeyword = loginDTO.getInterestKeyword();
	            loginDTO.setInterestKeyword(existingInterestKeyword);

				accountService.updateProfile(loginDTO);	
	
				LoginDTO updateUser = accountService.getUserById(loginDTO.getUserid());
			
				// 관심키워드를 세션을 안넣어줘서 날라감;;
				List<String> keywords = accountService.getUserKeyword(loginDTO.getUserid()); // 관심 키워드 조회
				updateUser.setInterestKeyword(keywords);
				
		        session.setAttribute("loginUser", updateUser);
				return ResponseEntity.ok("success");
			}else {
				log.error("프로필 업데이트 실패");
				return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("fail");
			}
		} catch (Exception e) {
			log.error("프로필 업데이트 실패");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("fail");
		}
	}

	@GetMapping("/mypage/userAccountProfileCard")
	public String userAccountProfileCard(HttpSession session, Model model) {
		LoginDTO loginDTO = (LoginDTO) session.getAttribute("loginUser");
		
		model.addAttribute("loginUser", loginDTO);
		return "/user/userAccountProfileCard";
	}
	

	@RequestMapping(value="/mypage/deleteAccount")
	@ResponseBody
	public String deleteAccount(HttpSession session, HttpServletResponse response) {
		try {	

			LoginDTO loginDTO = (LoginDTO) session.getAttribute("loginUser");

			boolean success = accountService.deleteAccount(loginDTO.getUserid());
			
			if(success) {
				session.invalidate(); // 세션 삭제
	
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
