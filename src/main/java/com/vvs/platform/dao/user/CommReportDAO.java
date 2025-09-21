package com.vvs.platform.dao.user;

import org.apache.ibatis.annotations.Mapper;

import com.vvs.platform.dto.user.CommReportDTO;
import com.vvs.platform.dto.user.CommentDTO;

@Mapper
public interface CommReportDAO {
	//신고 저장
	int insertReport(CommReportDTO crt);
	CommentDTO selectLatestCommentByUser(long billId, String userId);
}