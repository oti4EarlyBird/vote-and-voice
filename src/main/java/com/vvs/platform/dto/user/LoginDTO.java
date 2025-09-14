package com.vvs.platform.dto.user;

import lombok.Data;

@Data
public class LoginDTO {
	private int userSeq;
    private String userid;
    private String name;
    private String password;
    private String email;
    private String birthDate;
    private String role;
    private String accountStatus;
    private String notificationOptIn;
    private String signupDate;
    private String emailVerificationCode;
    private String emailVerified;
}	