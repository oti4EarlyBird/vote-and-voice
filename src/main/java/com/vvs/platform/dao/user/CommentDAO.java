package com.vvs.platform.dao.user;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.vvs.platform.dto.user.CommentDTO;

@Mapper
public interface CommentDAO {
	//특정 댓글 전체 목록 조회
	public List<CommentDTO> listAllByBillId(@Param("billId") int billId);  
    //댓글 저장
    public int insertC(CommentDTO cmt);
    // seq로 댓글 하나를 조회하는 메소드 추가 (XML의 selectById와 매칭)
    public CommentDTO selectById(Long seq); 

}