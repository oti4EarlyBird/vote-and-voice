package com.vvs.platform.service.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vvs.platform.dao.user.VoteDAO;
import com.vvs.platform.dto.user.VoteDTO;
 
@Service
public class VoteService {

    @Autowired
    private VoteDAO voteDAO;

    // 투표 처리
    public boolean doVote(VoteDTO vote) {
        // 1. 중복 투표 여부 확인
        VoteDTO exist = voteDAO.getVoteByUser(vote.getBillId(), vote.getUserId());
        if (exist != null) {
            return false; // 이미 투표했음
        }

        // 2. 투표 저장
        voteDAO.insertVote(vote);
        return true;
    }

    // 투표 현황 조회
    public List<VoteDTO> getVoteList(int billId) {
        return voteDAO.getVotesByBillId(billId);
    }
}