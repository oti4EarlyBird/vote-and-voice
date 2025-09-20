package com.vvs.platform.dto.user;

import lombok.Data;

@Data
public class CommReportDTO {
	private Long seq;
	private String reporterId;
	private Long commentId;
	private String reportContent;
	private String reportDate;
}