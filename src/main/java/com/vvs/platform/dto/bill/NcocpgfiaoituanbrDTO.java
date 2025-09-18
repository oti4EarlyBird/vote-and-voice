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
@Builder
@JsonIgnoreProperties(ignoreUnknown= true)
public class NcocpgfiaoituanbrDTO {
	@JsonProperty("BILL_ID")
    private String billId; // 의안 ID

    @JsonProperty("PROC_DT")
    private String procDt; // 처리일 (YYYY-MM-DD)

    @JsonProperty("BILL_NO")
    private String billNo; // 의안번호

    @JsonProperty("BILL_NAME")
    private String billName; // 의안명

    @JsonProperty("CURR_COMMITTEE")
    private String currCommittee; // 소관위

    @JsonProperty("CURR_COMMITTEE_ID")
    private String currCommitteeId; // 소관위 코드

    @JsonProperty("PROC_RESULT_CD")
    private String procResultCd; // 표결 결과 코드

    @JsonProperty("BILL_KIND_CD")
    private String billKindCd; // 의안 종류

    @JsonProperty("AGE")
    private String age; // 대수 (국회 회기 수)

    @JsonProperty("MEMBER_TCNT")
    private String memberTcnt; // 재적 의원 수

    @JsonProperty("VOTE_TCNT")
    private String voteTcnt; // 총 투표 수

    @JsonProperty("YES_TCNT")
    private String yesTcnt; // 찬성 수

    @JsonProperty("NO_TCNT")
    private String noTcnt; // 반대 수

    @JsonProperty("BLANK_TCNT")
    private String blankTcnt; // 기권 수

    @JsonProperty("LINK_URL")
    private String linkUrl; // 의안 상세 정보 URL
}
