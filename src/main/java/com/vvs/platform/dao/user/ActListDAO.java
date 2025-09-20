package com.vvs.platform.dao.user;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.vvs.platform.dto.user.ActListDTO;
import com.vvs.platform.dto.user.NoticeDTO;

@Mapper
public interface ActListDAO {
	//카테고리 별 글 개수
	int getActTotalCount(String category);

	// 카테고리에 따라 페이징된 글 목록 가져옴
	List<ActListDTO> getActList(Map<String, Object> map);
}
