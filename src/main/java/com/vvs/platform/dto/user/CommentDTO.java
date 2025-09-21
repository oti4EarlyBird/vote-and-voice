package com.vvs.platform.dto.user;

import lombok.Data;

@Data
public class CommentDTO {
	private long seq;
	private long billId;
	private String userId;
	private String content;
	private String createdAt;
	private String side;
}