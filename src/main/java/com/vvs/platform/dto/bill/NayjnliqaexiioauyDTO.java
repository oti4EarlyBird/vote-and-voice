package com.vvs.platform.dto.bill;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@JsonIgnoreProperties(ignoreUnknown=true)
@Builder
public class NayjnliqaexiioauyDTO {
	@JsonProperty("BILL_ID")
    private String billId; // 의안ID

    @JsonProperty("BILL_NO")
    private String billNo; // 의안번호

    @JsonProperty("AGE")
    private String age; // 대수

    @JsonProperty("BILL_NAME")
    private String billName; // 의안명

    @JsonProperty("CURR_COMMITTEE_ID")
    private String currCommitteeId; // 소관위코드

    @JsonProperty("CURR_COMMITTEE")
    private String currCommittee; // 소관위

    @JsonProperty("PROC_DT")
    private String procDt; // 의결일

    @JsonProperty("COMMITTEE_RESULT")
    private String committeeResult; // 소관위처리결과

    @JsonProperty("LINK_URL")
    private String linkUrl; // 상세정보 URL

    @JsonProperty("COMMITTEE_PROC_DT")
    private String committeeProcDt; // 소관위처리일

    @JsonProperty("CMT_PRESENT_DT")
    private String cmtPresentDt; // 소관위상정일

    @JsonProperty("LAW_SUBMIT_DT")
    private String lawSubmitDt; // 법사위회부일

    @JsonProperty("LAW_PRESENT_DT")
    private String lawPresentDt; // 법사위상정일

    @JsonProperty("LAW_PROC_DT")
    private String lawProcDt; // 법사위처리일

    @JsonProperty("LAW_PROC_RESULT_CD")
    private String lawProcResultCd; // 법사위처리결과

    @JsonProperty("COMMITTEE_DT")
    private String committeeDt; // 소관위회부일
}
