package com.vvs.platform.dao.admin;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.vvs.platform.dto.admin.AdminBillBoardDTO;
import com.vvs.platform.dto.admin.AdminBillBoardListDTO;
import com.vvs.platform.dto.admin.AdminBillsDTO;
import com.vvs.platform.dto.admin.PageDTO;

@Mapper
public interface AdminBillsDAO {
	public List<AdminBillsDTO> getAllBills(@Param("pageDTO") PageDTO pageDTO);
	
	// 총 게시물 수를 가져오는 메서드 추가
    public int getBillTotalCount();
    
    //법안 폼의 입력한 요소들을 DB에 삽입하는 메서드
    public int insertBillBoard(AdminBillBoardDTO dto);
    
    //Bill Board 리스트를 가져오는 메서드 추가
    public List<AdminBillBoardListDTO> getAllBillBoard();
    
    //법안 게시판 리스트 페이지에서 삭제하는 메서드 추가
    public int deleteBillBoard(@Param("billboardId") int billboardId);
}