package com.vvs.platform.dto.user;

import lombok.Data;
import java.time.LocalDate;
import java.util.List;

@Data
public class UserSignUpDTO {
		private int userSeq;
		private String userId;
		private String name;
		private String pwd;
		private LocalDate birth;
		private String email;
		private String role;
		private String accStatus;
		private String notificationOptIn;
		private LocalDate signupDate;
		private String pwdConfirm; //비번 확인용
		private List<KeywordDTO> interests;
	}
	
