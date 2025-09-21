package com.vvs.platform.service.admin;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vvs.platform.dao.admin.AdminBillsDAO;
import com.vvs.platform.dao.user.UserChatDAO;
import com.vvs.platform.dto.admin.AdminBillBoardDTO;
import com.vvs.platform.dto.admin.AdminBillBoardListDTO;
import com.vvs.platform.dto.admin.AdminBillsDTO;
import com.vvs.platform.dto.admin.PageDTO;
import com.vvs.platform.dto.user.ChatRoomDTO;

@Service
public class AdminBillsService {
	private final AdminBillsDAO adminBillsDAO;

	@Autowired
	public AdminBillsService(AdminBillsDAO adminBillsDAO) {
		this.adminBillsDAO = adminBillsDAO;
	}
	
	@Autowired
	private UserChatDAO chatDAO;
	
	// 관리자가 법안 게시글 작성에서 모달을 통해 투표에 부칠 법안을 선택하는 메서드
	public Map<String, Object> getBillInModalSearch(PageDTO pageDTO) {
		// 1. 총 게시물 수를 조회하고 PageDTO에 설정
		int totalCnt = adminBillsDAO.getBillTotalCount();
		pageDTO.setTotalCnt(totalCnt);

		// 2. 페이징 정보가 담긴 PageDTO로 데이터를 조회
		List<AdminBillsDTO> dataList = adminBillsDAO.getAllBills(pageDTO);

		// 3. 리스트와 페이징 정보를 함께 Map에 담아 반환
		Map<String, Object> result = new HashMap<>();
		result.put("dataList", dataList);
		result.put("pageDTO", pageDTO);

		return result;
	}

	public int insertBillBoard(AdminBillBoardDTO dto) {
		return adminBillsDAO.insertBillBoard(dto);
	}

	public List<AdminBillBoardListDTO> getAllBillBoardList() {
		return adminBillsDAO.getAllBillBoard();
	}

	// 법안 게시글을 삭제하는 서비스 메서드
	public int deleteBillBoard(int billboardId) {
		return adminBillsDAO.deleteBillBoard(billboardId);
	}

	//의안등록시 채팅방 생성
	@Transactional
	public int insertBillBoardAndCreatChatRoom(AdminBillBoardDTO dto) {
		// 1. 의안 등록
		int insertBillBoardResult = adminBillsDAO.insertBillBoard(dto);
		if(insertBillBoardResult != 1) {
			throw new RuntimeException("의안 등록 실패");
		}
		
		//startDate를 위한 현재 시간 구하기 -> 의안 작성시 투표시간을 안만듬 
		LocalDate startLocalDate = LocalDate.now();
		LocalDate endLocalDate = startLocalDate.plusDays(7);
		
		Date startDate = Date.from(startLocalDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
		Date endDate = Date.from(endLocalDate.atStartOfDay(ZoneId.systemDefault()).toInstant());

		// 2. 채팅방 생성
		ChatRoomDTO chatRoomDTO = new ChatRoomDTO();
		
		chatRoomDTO.setBillBoardId(dto.getBillBoardId());
		chatRoomDTO.setTitle(dto.getTitle());
		chatRoomDTO.setStartDate(startDate);
		chatRoomDTO.setEndDate(endDate);
		chatRoomDTO.setStatus("OPEN");
		
		int insertChatResult = chatDAO.insertChatRoom(chatRoomDTO);
		if(insertChatResult != 1) {
			throw new RuntimeException("채팅방 생성 실패");
		}
		
		return 1;
	}
}
