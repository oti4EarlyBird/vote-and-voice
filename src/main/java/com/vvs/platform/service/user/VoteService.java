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
    
    // 투표 처리 (중복 체크 포함)
    public boolean doVote(VoteDTO dto) {
        try {
            // 1. 중복 투표 여부 확인
            VoteDTO exist = voteDAO.getVoteByUser(dto.getBillId(), dto.getUserId());
            if (exist != null) {
                return false; // 이미 투표했음
            }
            
            // 2. 투표 저장
            voteDAO.insertVote(dto);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // 단순 투표 저장 (중복 체크 없음)
    public void insertVote(VoteDTO dto) {
        voteDAO.insertVote(dto);
    }
    
    // 투표 현황 조회
    public List<VoteDTO> getVoteList(int billId) {
        return voteDAO.getVotesByBillId(billId);
    }
    
    // 특정 사용자의 투표 여부 확인
    public boolean hasUserVoted(int billId, String userId) {
        VoteDTO vote = voteDAO.getVoteByUser(billId, userId);
        return vote != null;
    }
}