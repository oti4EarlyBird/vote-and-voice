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
@JsonIgnoreProperties(ignoreUnknown=true)
public class WebcastvconfDTO {
	@JsonProperty("ERACO")
    private String eraco; // 대수

    @JsonProperty("CONF_DT")
    private String confDt; // 회의일자 (YYYY-MM-DD)

    @JsonProperty("CONF_PTM")
    private String confPtm; // 회의시간

    @JsonProperty("CONF_NM")
    private String confNm; // 회의명

    @JsonProperty("LINK_URL")
    private String linkUrl; // 링크 URL
}
