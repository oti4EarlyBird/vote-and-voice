package com.vvs.platform.dto.user;

import lombok.Data;

@Data
public class VoteDTO {
	private int seq;
	private String userId;
	private int billId;
	private String result;
	private String voteDate;
}