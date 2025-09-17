package com.vvs.platform.dao.admin;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.vvs.platform.dto.admin.AdminNoticesDTO;
import com.vvs.platform.dto.admin.PageDTO;

@Mapper
public interface AdminNoticesDAO {
	//공지사항을 리스트로 뽑아내는 메서드 추가
	public List<AdminNoticesDTO> getAllNotices(); 
	
	//공지사항의 총 게시글 수를 가져오는 메서드 추가
	public int getNoticeTotalCount();
	
	//카테고리 별로 공지사항을 리스트로 뽑아내는 메서드 추가
	public List<AdminNoticesDTO> getNoticesByCategory(@Param("category") String category);

	//공지사항 작성 폼의 입력한 요소들을 DB에 삽입하는 메서드
	public int insertNotice(AdminNoticesDTO dto);
	
	//공지사항 리스트 페이지에서 삭제하는 메서드 추가
	public int deleteNotice(@Param("noticeId") int noticeId);
}
