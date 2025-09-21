package com.vvs.platform.dao.user;

import org.apache.ibatis.annotations.Mapper;

import com.vvs.platform.dto.user.ActDetailDTO;

@Mapper
public interface ActDetailDAO {
	    ActDetailDTO getBillDetailById(int billBoardId);
}
