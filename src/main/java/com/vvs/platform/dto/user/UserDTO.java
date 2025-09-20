package com.vvs.platform.dto.user;

import lombok.Data;

@Data
public class UserDTO {
	private String id;
    private String name;
    private String password;
    private String email;
    private String birthDate;  // yyyy-MM-dd 형식
}
