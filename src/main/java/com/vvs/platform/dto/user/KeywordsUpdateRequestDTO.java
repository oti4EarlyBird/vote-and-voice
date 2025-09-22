package com.vvs.platform.dto.user;

import java.util.List;

import lombok.Data;

@Data
public class KeywordsUpdateRequestDTO {
	private List<String> keywords;	// 키워드ID 목록을 저장 
}
