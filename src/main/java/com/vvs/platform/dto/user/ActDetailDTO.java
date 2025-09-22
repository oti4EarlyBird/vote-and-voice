package com.vvs.platform.dto.user;

import lombok.Data;

@Data
public class ActDetailDTO {
    private int seqBillboardId;   // bill_board
    private int billId;           // bill_board
    private String title;         // bill_board
    private String content;       // bill_board
    private String startDate;     // bill_board, String으로 바꾸면 TO_CHAR 필요
    private String endDate;       // bill_board, String으로 바꾸면 TO_CHAR 필요
    private int viewNum;          // bill_board

    private String billNumber;    // bills
    private String committee;     // bills
    private String decisionResult;// bills
    private String decisionDate;  // bills, TO_CHAR 필요
    private String relatedUrl;    // bills
    private String pdfLink;       // bills
    private String videoLink;     // bills
    private String summary;		  // bills
}
