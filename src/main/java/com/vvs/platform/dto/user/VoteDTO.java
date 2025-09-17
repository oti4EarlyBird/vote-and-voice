package com.vvs.platform.dto.user;

import lombok.Data;

@Data
public class VoteDTO {
	private int seq;
	private String userid;
	private int billid;
	private String result;
	private String voteDate;
}
