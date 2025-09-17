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
	private String title;
	private String content; // TinyMCE 에디터 내용
	private String writeday;
	private int viewnum;
	private String startDate;
	private String endDate;
}