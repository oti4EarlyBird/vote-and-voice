package com.vvs.platform.service.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vvs.platform.dao.user.LoginDAO;
import com.vvs.platform.dao.user.UserAccountDAO;
import com.vvs.platform.dao.user.UserSignUpDAO;
import com.vvs.platform.dto.user.KeywordDTO;
import com.vvs.platform.dto.user.KeywordsUpdateRequestDTO;
import com.vvs.platform.dto.user.LoginDTO;

@Service
public class UserAccountService {
	@Autowired
	private UserSignUpDAO userDAO;
	@Autowired
	private UserAccountDAO accountDAO;
	@Autowired
	private LoginDAO loginDAO;
	
	public List<KeywordDTO> getAllKeywords() {
		return userDAO.getAllKeywords();
	}

	
	// 계정 삭제
	public boolean deleteAccount(String userid) {
		return accountDAO.deleteAccount(userid);
	}

	public boolean updateKeyword(String userId, List<String> keywordNames) {
		// 기존 키워드 선택한것 삭제
		accountDAO.deleteUserKeyword(userId);
		
		try {
			
			// 새로운 키워드 저장 
			// 1. 키워드명 -> 키워드 Id(seq) 변환
			List<Integer> keywordSeq =  accountDAO.findKeywordSeqByKeywordName(keywordNames);
			// 2. 새 키워드 삽입
			for(Integer seq : keywordSeq) {
				userDAO.insertUserKeyword(userId, seq);
			}	
			if(keywordSeq != null)System.out.println("UserAccountService : 키워드 재 등록 성공 ");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return true;
	}

	// 프로필 수정 - 세션재등록을 위한 회원정보 가져오기
	public LoginDTO getUserById(String userid) {
		return loginDAO.login(userid);
	}
	// 프로필 수정 - 업데이트
	public void updateProfile(LoginDTO loginDTO) {
		accountDAO.updateProfile(loginDTO);
		
	}
	// 프로필 수정 키워드 가져오기 
	public List<String> getUserKeyword(String userid) {
		return loginDAO.getUserKeyword(userid);
		
	}

	
	
	
}
