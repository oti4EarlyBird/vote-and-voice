package com.vvs.platform.service.user;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vvs.platform.dao.user.UserNoticeDAO;
import com.vvs.platform.dto.user.NoticeDTO;

@Service
public class NoticeService {
	@Autowired
	private UserNoticeDAO noticeDAO;
	
	// 전체 공지사항을 가져옴 
	public List<NoticeDTO> selectNoticeList(){
		return noticeDAO.selectNoticeList();
	}

	// 카테고리에 맞춰 글 갯수를 가져옴
	public int getNoticeCount(Map<String, Object> map) {
		String category = (String) map.get("category");
	System.out.println(category);
		return noticeDAO.getNoticeCount(category);
	}
	
	// 카테고리에 맞춘 페이징된 글 목록 가져옴
	public List<NoticeDTO> getNoticeList(Map<String, Object> map) {
		System.out.println(noticeDAO.getNoticeList(map));
		return noticeDAO.getNoticeList(map);
	}
}
