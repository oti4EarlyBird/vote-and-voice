package com.vvs.platform.dto.user;

import lombok.Data;
import java.util.List;

@Data
public class UserSignUpDTO {
	private int userSeq;
    private String userId;
    private String name;
    private String password;
    private String passwordConfirm; // DB에 저장 X
    private String email;
    private String birthDate;   // 화면에서 넘어온 date input
    private List<Integer> selectedKeywords; // 관심 키워드
	}
	
