package com.vvs.platform.service.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vvs.platform.dao.user.CommReportDAO;
import com.vvs.platform.dao.user.CommentDAO;
import com.vvs.platform.dto.user.CommReportDTO;
import com.vvs.platform.dto.user.CommentDTO;
 
@Service
public class CommentService {
    @Autowired
    private CommentDAO commentDAO;
    @Autowired
    private CommReportDAO reportDAO;
    
    public List<CommentDTO> listAllByBillId(long billId) {
    	return commentDAO.listAllByBillId(billId);
    }
    public int insertC(CommentDTO cmt) {
    	return commentDAO.insertC(cmt); 
    }
    public CommentDTO selectById(Long seq) {
    	return commentDAO.selectById(seq);
    }
    //댓글신고
    public int insertReport(CommReportDTO crt) {
    	return reportDAO.insertReport(crt);
    }
    public CommentDTO getLatestCommentByUser(long billId, String userId) {
        // 특정 사용자가 특정 법안에 작성한 가장 최근 댓글을 조회
        return commentDAO.selectLatestCommentByUser(billId, userId);
    }
}