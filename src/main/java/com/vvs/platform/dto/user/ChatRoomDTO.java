package com.vvs.platform.dto.user;

import java.util.Date;

import lombok.Data;

@Data
public class ChatRoomDTO {
	private Long chatRoomId;
    private String title; // bill_board.title
    private Date startDate;
    private Date endDate;
    private String status; // 계산된 상태
}
