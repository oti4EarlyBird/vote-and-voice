package com.vvs.platform.dto.admin;

import java.time.LocalDate;

import lombok.Data;

@Data
public class AdminBillsDTO {
    private Long   seqBills;        // SEQ_BILLS (DB 시퀀스 사용)
    private String billTitle;       // BILL_TITLE      <- BILL_NAME
    private String billNumber;      // BILL_NUMBER     <- BILL_NO
    private String relatedUrl;      // RELATED_URL     <- LINK_URL
    private String committee;       // COMMITTEE       <- CURR_COMMITTEE
    private String decisionResult;  // DECISION_RESULT <- PROC_RESULT_CD (가정)
    private LocalDate decisionDate; // DECISION_DATE   <- PROC_DT (YYYY-MM-DD)
    private String pdfLink;         // PDF_LINK        <- 상세페이지 pre#prntSummary 텍스트

    // + 선택적으로 원본 필드를 더 보관하고 싶다면 아래를 추가
    private String billId;          // 원본 BILL_ID
    private String age;             // AGE   
}
