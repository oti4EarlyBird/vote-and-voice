package com.vvs.platform.service.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vvs.platform.dao.admin.AdminNoticesDAO;
import com.vvs.platform.dto.admin.AdminNoticesDTO;

@Service
public class AdminNoticesService {
	private final AdminNoticesDAO adminNoticesDAO;
	
	@Autowired
	public AdminNoticesService(AdminNoticesDAO adminNoticesDAO) {
		this.adminNoticesDAO = adminNoticesDAO;
	}
	
	//관리자가 공지사항에서 모든 공지글을 가져오는 메서드
	public List<AdminNoticesDTO> getAllNotices() {
		return adminNoticesDAO.getAllNotices();
	}
	
	//관리자가 카테고리에 따라 공지글을 필터링해서 가져오게 하는 메서드
	public List<AdminNoticesDTO> getNoticesByCategory(String category) {
		return adminNoticesDAO.getNoticesByCategory(category);
	}
	
	//공지사항 게시판에 삽입하는 메서드
	public int insertNotice(AdminNoticesDTO dto) {
		return adminNoticesDAO.insertNotice(dto);
	}
	
	//공지사항 게시판 글을 삭제하는 메서드
	public int deleteNotice(int noticeId) {
		return adminNoticesDAO.deleteNotice(noticeId);
	}
}
