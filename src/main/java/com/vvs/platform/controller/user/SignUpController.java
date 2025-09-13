package com.vvs.platform.controller.user;


import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.vvs.platform.dao.user.SignUpKeywordDAO;
import com.vvs.platform.dto.user.KeywordDTO;
import com.vvs.platform.dto.user.UserSignUpDTO;
import com.vvs.platform.service.user.SignUpService;

import lombok.extern.slf4j.Slf4j;


@Controller
@RequestMapping("/user")
@Slf4j
public class SignUpController {
	@Autowired
	private SignUpService signUpService;
	
	@Autowired
	private SignUpKeywordDAO signUpKeywordDAO;
   
    // 회원가입 폼(GET)
    @GetMapping("/signup")
    public ModelAndView showSignUpForm() {
    	log.info("회원가입 폼 페이지 요청");
    	ModelAndView mav = new ModelAndView("user/signup");
    	
    	try {
    		//전체 키워드 조회
    		List<KeywordDTO> keywordList = signUpKeywordDAO.getAllKeywords();
    		
    		//mav에 데이터 담기
    		mav.addObject("keywords", keywordList);
    		mav.addObject("usrDTO", new UserSignUpDTO()); //빈 DTO 전달
    		
    		log.info("키워드 {}개  로드 완료", keywordList.size());
    	} catch (Exception e) {
    		log.error("키워드 목록 조회 실해: {}", e.getMessage());
    		mav.addObject("errorMessage", "페이지 로딩 중 오류가 발생했습니다.");
    	}
        return mav;  // signup.jsp 로 이동
    }

    // 회원가입 처리(POST)
    @PostMapping("/signup")
    public ModelAndView processSignUp(
    		 @ModelAttribute UserSignUpDTO userSignUpDTO,
             @RequestParam(value = "selectedKeywords", required = false) List<Integer> selectedKeywordIds) {
         
         log.info("회원가입 처리 시작: {}", userSignUpDTO.getUserId());
         
         ModelAndView mav = new ModelAndView("user/signup");
         
         try {
             // 선택된 키워드 리스트 생성
             List<KeywordDTO> selectedKeywords = new ArrayList<>();
             if (selectedKeywordIds != null && !selectedKeywordIds.isEmpty()) {
                 for (Integer keywordId : selectedKeywordIds) {
                     KeywordDTO keyword = new KeywordDTO();
                     keyword.setKeywordId(keywordId);
                     keyword.setUserId(userSignUpDTO.getUserId()); // 사용자 ID 설정
                     selectedKeywords.add(keyword);
                 }
             }
             
             // 회원가입 처리
             String result = signUpService.registerUser(userSignUpDTO, selectedKeywords);
             
             // 성공 시
             mav.addObject("successMessage", result);
             mav.addObject("redirect", "/user/login"); // 리다이렉트 URL
             log.info("회원가입 성공: {}", userSignUpDTO.getUserId());
             
         } catch (IllegalArgumentException e) {
             // 검증 실패 (사용자 입력 오류)
             log.warn("회원가입 검증 실패: {} - {}", userSignUpDTO.getUserId(), e.getMessage());
             handleSignUpError(mav, userSignUpDTO, e.getMessage());
             
         } catch (Exception e) {
             // 시스템 오류
             log.error("회원가입 시스템 오류: {} - {}", userSignUpDTO.getUserId(), e.getMessage());
             handleSignUpError(mav, userSignUpDTO, "회원가입 처리 중 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
         }
         
         return mav;
     }
     
     //가입 실패 시 처리
     private void handleSignUpError(ModelAndView mav, UserSignUpDTO userSignUpDTO, String errorMessage) {
         try {
             // 키워드 목록 다시 로드
             List<KeywordDTO> keywordList = signUpKeywordDAO.getAllKeywords();
             mav.addObject("keywords", keywordList);
             
             // 사용자가 입력했던 데이터 유지 (비밀번호 제외)
             userSignUpDTO.setPwd("");
             userSignUpDTO.setPwdConfirm("");
             mav.addObject("userDTO", userSignUpDTO);
             
             // 에러 메시지
             mav.addObject("errorMessage", errorMessage);
             
         } catch (Exception e) {
             log.error("에러 처리 중 추가 오류 발생: {}", e.getMessage());
             mav.addObject("errorMessage", "시스템 오류가 발생했습니다.");
         }
     }
     
     //아이디 중복체크(AJAX)
     @PostMapping("/check-id")
     @ResponseBody
     public String checkIdDuplicate(@RequestParam String userId) {
         log.debug("아이디 중복 체크 요청: {}", userId);
         
         try {
             boolean isDuplicate = signUpService.checkUserIdDuplicate(userId);
             return isDuplicate ? "duplicate" : "available";
         } catch (Exception e) {
             log.error("아이디 중복 체크 오류: {}", e.getMessage());
             return "error";
         }
     }
     
     //이메일 중복체크(AJAX)
     @PostMapping("/check-email")
     @ResponseBody
     public String checkEmailDuplicate(@RequestParam String email) {
         log.debug("이메일 중복 체크 요청: {}", email);
         
         try {
             boolean isDuplicate = signUpService.checkEmailDuplicate(email);
             return isDuplicate ? "duplicate" : "available";
         } catch (Exception e) {
             log.error("이메일 중복 체크 오류: {}", e.getMessage());
             return "error";
         }
    }
}
