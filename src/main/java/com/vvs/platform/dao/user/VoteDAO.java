package com.vvs.platform.dao.user;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.vvs.platform.dto.user.VoteDTO;

@Mapper
public interface VoteDAO {
	//투표 저장
	int insertVote(VoteDTO dto); 
	//특정 게시글 투표 현황 조회
	List<VoteDTO> getVotesByBillId(int billId);
	//특정 사용자 투표 여부 조회
	VoteDTO getVoteByUser(@Param("billId") int billId, @Param("userId") String userId);
}