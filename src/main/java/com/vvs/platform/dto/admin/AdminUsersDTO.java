package com.vvs.platform.dto.admin;

import java.util.Date;

import lombok.Data;

@Data
public class AdminUsersDTO {
	private int userSeq; //사용자의 seq값
	private String userId; //사용자의 아이디
	private String name; //사용자의 이름
	private String email; //사용자의 이메일 주소
	private Date birthDate; //사용자의 생년월일
	private String accountStatus; //사용자의 계정 정지 여부 
	private String notificationOptIn; //사용자의 알림 여부
	private String signupDate; //사용자의 가입일
	
}
