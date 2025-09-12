package com.vvs.platform.dao.user;

import org.apache.ibatis.annotations.Mapper;

import com.vvs.platform.dto.user.UserSignUpDTO;

@Mapper
public interface UserSignUpDAO {

		public int insertUser(UserSignUpDTO user); //회원가입
		public boolean checkId(String userId); //아이디 중복 확인
		public boolean checkEmail(String email); //이메일 중복 확인
		public UserSignUpDTO selectUserById(String userId); //회원 정보 조회(로그인에 필요)
	
}
	
