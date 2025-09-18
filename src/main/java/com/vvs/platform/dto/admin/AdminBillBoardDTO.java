package com.vvs.platform.dto.admin;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor

// 게시판에 POST할때 필요한 dto
public class AdminBillBoardDTO {
	
	private int billBoardId;
	private int billId; // 모달에서 가져올 seq_bills
	private int billNumber; //조인으로 가져올 의안번호
	private String title;
	private String committee; //조인으로 가져올 위원회
	private String content; // TinyMCE 에디터 내용
	private String decisionResult;
	private String decisionDate;
	private String writeday;
	private int viewnum;
	private String startDate; //투표 시작일
	private String endDate; //투표 종료일
	private String category; //법안의 종류
	private String relatedUrl; //의안시스템 정보
	private String videoUrl; //비디오 링크
	private String pdfUrl; //문서 다운로드 링크
}