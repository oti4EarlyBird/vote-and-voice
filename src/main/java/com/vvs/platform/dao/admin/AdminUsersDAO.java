package com.vvs.platform.dao.admin;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.vvs.platform.dto.admin.AdminUsersDTO;

@Mapper
public interface AdminUsersDAO {
	//사용자 정보를 리스트로 뽑아내는 메서드 추가
	public List<AdminUsersDTO> getAllUsers(Map<String, Object> map);
	
	public int getUserTotalCount(Map<String, Object> map);
	
	//사용자를 탈퇴하기 위해 삭제하는 메서드
	public int deleteUserBySeq(@Param("userSeq") int userSeq);
}
