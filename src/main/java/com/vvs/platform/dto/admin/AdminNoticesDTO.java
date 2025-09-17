package com.vvs.platform.dto.admin;

import lombok.Data;

@Data
public class AdminNoticesDTO {
	// noticeId는 오라클 DB에서 시퀀스로 자동 생성되므로, int 또는 Integer 타입이어야 합니다.
	private int noticeId; //시퀀스: SEQ_NOTICES - NOT NULL - NUMBER
	
	private String title; //제목: TITLE - VARCHAR2(200)
	private String content; //tiny MCE 에디터 내용: CONTENT - CLOB
	private String category; //카테고리: CATEGORY - VARCHAR2(50)
	
	private String isPinned; //상단 고정여부: IS_PINNED - CHAR(1)
	
	private String postDate; //작성일: POST_DATE - DATE
	private String writer; //작성자: WRITER - VARCHAR2(100)
	private int viewNum; //조회수: VIEWNUM - NUMBER
}
