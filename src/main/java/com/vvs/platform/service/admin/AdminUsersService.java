package com.vvs.platform.service.admin;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vvs.platform.dao.admin.AdminUsersDAO;
import com.vvs.platform.dto.admin.AdminUsersDTO;

@Service
public class AdminUsersService {
	private final AdminUsersDAO adminUsersDAO;
	
	@Autowired
	public AdminUsersService (AdminUsersDAO adminUsersDAO) {
		this.adminUsersDAO = adminUsersDAO;
	}
	
	//사용자의 총 숫자를 알려주는 메서드
	public int getUserTotalCount(Map<String, Object> map) {
		return adminUsersDAO.getUserTotalCount(map);
	}
	
	//관리자가 사용자 테이블에서 리스트를 쭉 가져오는 메서드
	public List<AdminUsersDTO> getAllUsers(Map<String, Object> map) {
		return adminUsersDAO.getAllUsers(map);
	}
	
	//관리자가 사용자의 게정을 삭제하는 메서드
	public int deleteUserBySeq(int userSeq) {
		return adminUsersDAO.deleteUserBySeq(userSeq);
	}
}
