package com.vvs.platform.dao.admin;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.vvs.platform.dto.admin.AdminBillsDTO;
import com.vvs.platform.dto.admin.PageDTO;

@Mapper
public interface AdminBillsDAO {
	public List<AdminBillsDTO> getAllBills(@Param("pageDTO") PageDTO pageDTO);
	
	// 총 게시물 수를 가져오는 메서드 추가
    public int getBillTotalCount();
}