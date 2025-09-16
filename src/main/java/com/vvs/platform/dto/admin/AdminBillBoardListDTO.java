package com.vvs.platform.dto.admin;

import lombok.Data;

@Data
public class AdminBillBoardListDTO {
	private Long billboardId; // bill_board의 seq_billboard_id
	private String title; // bill_board의 title
	private String billNumber; // bills의 bill_number
	private String committee; // bills의 committee
	private String decisionResult; // bills의 decision_result
	private String decisionDate; // bills의 decision_date
}
