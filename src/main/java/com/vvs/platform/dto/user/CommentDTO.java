package com.vvs.platform.dto.user;

import lombok.Data;

@Data
public class CommentDTO {
	private Long seq;
	private Long billId;
	private String userId;
	private String content;
	private String createdAt;
	private String side;
}