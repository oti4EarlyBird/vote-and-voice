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
	public int getNoticeTotalCount(Map<String, Object> map) {
		String category = (String) map.get("category");
		return noticeDAO.getNoticeTotalCount(category);
	}
	
	// 카테고리에 맞춘 페이징된 글 목록 가져옴
	public List<NoticeDTO> getNoticeList(Map<String, Object> map) {
		return noticeDAO.getNoticeList(map);
	}

// ----------
	// 특정 번호의 공지사항 하나의 정보 가져옴
	public NoticeDTO getNoticeById(int noticeSeq) {
		return noticeDAO.getNoticeById(noticeSeq);

	}
	// 이전글 제목, 번호
	public NoticeDTO getPrevNotice(int noticeSeq) {
		return noticeDAO.getPrevNotice(noticeSeq);
	}
	// 다음글 제목, 번호
	public NoticeDTO getNextNotice(int noticeSeq) {
		return noticeDAO.getNextNotice(noticeSeq);
	}

	// 조회수 증가 
	public void incrementViewCount(int noticeSeq) {
		noticeDAO.incrementViewCount(noticeSeq);
		
	}
}
