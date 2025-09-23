package com.vvs.platform.dao.user;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.vvs.platform.dto.user.NoticeDTO;

@Mapper
public interface UserNoticeDAO {
	// 그냥 전체 글 가져옴
	List<NoticeDTO> selectNoticeList();
	
	// category에 따른 전체 글 수 
	int getNoticeTotalCount(String category);

	// 카테고리에 맞춘 페이징된 글 목록 가져옴
	List<NoticeDTO> getNoticeList(Map<String, Object> map);

	// 특정 번호의 공지사항 하나의 정보 가져옴
	NoticeDTO getNoticeById(int noticeSeq);

	// 이전글 제목, 번호
	NoticeDTO getPrevNotice(int noticeSeq);
	// 다음글 제목, 번호
	NoticeDTO getNextNotice(int noticeSeq);
	
	// 조회수 증가 
	void incrementViewCount(int noticeSeq);
}
