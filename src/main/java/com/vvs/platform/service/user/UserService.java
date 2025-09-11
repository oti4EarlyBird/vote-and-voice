package com.vvs.platform.service.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vvs.platform.dao.user.SignUpKeywordDAO;
import com.vvs.platform.dao.user.UserSignUpDAO;
import com.vvs.platform.dto.user.UserDTO;

@Service
public class SignUpService(UserDTO userDTO) {
	@Autowired
	private UserSignUpDAO userDAO;
	private SignUpKeywordDAO keywordDAO;
	//입력값 검증
	

	//중복 체크
	//비번 암호화
	//DB 저장
	//키워드 저장
	//결과 처리
}
