package com.vvs.platform.dao.user;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.vvs.platform.dto.user.LoginDTO;

@Mapper
public interface LoginDAO {
	LoginDTO login(@Param("userid")String userid); // 아이디로 회원 찾기
}
