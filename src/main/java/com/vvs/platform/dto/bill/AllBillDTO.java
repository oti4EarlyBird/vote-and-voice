package com.vvs.platform.dto.bill;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@JsonIgnoreProperties(ignoreUnknown=true)
public class AllBillDTO {

	@JsonProperty("ERACO")
    private String eraco; // 대수
	
	@JsonProperty("BILL_ID")
    private String billId; // 의안ID
	
	@JsonProperty("BILL_NO")
    private String billNo; // 의안번호
	
	@JsonProperty("BILL_KND")
    private String billKnd; // 의안종류
	
	@JsonProperty("BILL_NM")
    private String billNm; // 의안명
	
	@JsonProperty("PPSR_KND")
    private String ppsrKnd; // 제안자구분
	
	@JsonProperty("PPSR_NM")
    private String ppsrNm; // 제안자명
	
	@JsonProperty("PPSL_SESS")
    private String ppslSess; // 제안회기
	
	@JsonProperty("PPSL_DT")
    private String ppslDt; // 제안일
	
	@JsonProperty("JRCMIT_NM")
    private String jrcmitNm; // 소관위원회명
	
	@JsonProperty("JRCMIT_CMMT_DT")
    private String jrcmitCmmtDt; // 소관위원회 회부일
	
	@JsonProperty("JRCMIT_PRSNT_DT")
    private String jrcmitPrsntDt; // 소관위원회 상정일
	
	@JsonProperty("JRCMIT_PROC_DT")
    private String jrcmitProcDt; // 소관위원회 처리일
	
	@JsonProperty("JRCMIT_PROC_RSLT")
    private String jrcmitProcRslt; // 소관위원회 처리결과
	
	@JsonProperty("LAW_CMMT_DT")
    private String lawCmmtDt; // 법사위 체계자구심사 회부일
	
	@JsonProperty("LAW_PRSNT_DT")
    private String lawPrsntDt; // 법사위 체계자구심사 상정일
	
	@JsonProperty("LAW_PROC_DT")
    private String lawProcDt; // 법사위 체계자구심사 처리일
	
	@JsonProperty("LAW_PROC_RSLT")
    private String lawProcRslt; // 법사위 체계자구심사 처리결과
	
	@JsonProperty("RGS_PRSNT_DT")
    private String rgsPrsntDt; // 본회의 심의 상정일
	
	@JsonProperty("RGS_RSLN_DT")
    private String rgsRslnDt; // 본회의 심의 의결일
	
	@JsonProperty("RGS_CONF_NM")
    private String rgsConfNm; // 본회의 심의 회의명
	
	@JsonProperty("RGS_CONF_RSLT")
    private String rgsConfRslt; // 본회의 심의결과
	
	@JsonProperty("GVRN_TRSF_DT")
    private String gvrnTrsfDt; // 정부 이송일
	
	@JsonProperty("PROM_LAW_NM")
    private String promLawNm; // 공포 법률명
	
	@JsonProperty("PROM_DT")
    private String promDt; // 공포일
	
	@JsonProperty("PROM_NO")
    private String promNo; // 공포번호
	
	@JsonProperty("LINK_URL")
    private String linkUrl; // 링크URL
	
	
}
