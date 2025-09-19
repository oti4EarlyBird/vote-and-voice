package com.vvs.platform.dao.user;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface UserAccountDAO {

	boolean deleteAccount(String userid);

	// keyword를 Name에서 seq로 변환 
	List<Integer> findKeywordSeqByKeywordName(@Param("keywordNames") List<String> keywordNames);

	// 기존에 지정한 키워드 삭제 
	void deleteUserKeyword(String userId);

}
