package com.vvs.platform.dto.admin;

import lombok.Data;

@Data
public class AdminBillsDTO {
    private Long   seqBills;        // SEQ_BILLS (DB 시퀀스 사용)
    private String billTitle;       // BILL_TITLE      <- BILL_NAME
    private String billNumber;      // BILL_NUMBER     <- BILL_NO
    private String relatedUrl;      // RELATED_URL     <- LINK_URL
    private String committee;       // COMMITTEE       <- CURR_COMMITTEE
    private String decisionResult;  // DECISION_RESULT <- PROC_RESULT_CD (가정)
    private String decisionDate; // DECISION_DATE   <- PROC_DT (YYYY-MM-DD)
    private String pdfLink;         // PDF_LINK        <- 상세페이지 pre#prntSummary 텍스트  
}
