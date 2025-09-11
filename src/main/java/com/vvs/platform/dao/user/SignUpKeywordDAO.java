package com.vvs.platform.dao.user;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.vvs.platform.dto.user.KeywordDTO;

@Mapper
public interface SignUpKeywordDAO {
	public List<KeywordDTO> getAllKeywords(); //전체 키워드 목록 조회(회원가입 시 선택용)
	public int insertUserKeyword(KeywordDTO keyword); //사용자가 선택한 키워드 저장
	
}
