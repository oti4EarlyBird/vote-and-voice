package com.vvs.platform.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.vvs.platform.dto.admin.AdminUsersDTO;
import com.vvs.platform.dto.admin.PageDTO;
import com.vvs.platform.service.admin.AdminUsersService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin")
public class AdminUsersController {
	private final AdminUsersService adminUsersService;
	
	@GetMapping("/userList")
	public ModelAndView userList(@RequestParam(value="page", defaultValue="1") int page) {
		ModelAndView mav = new ModelAndView();
		
		// 페이징 
		PageDTO pageDTO = new PageDTO(page, 5); 	// 5개씩 보여줌 
		
		// Map 객체를 사용하여 데이터베이스 조회에 필요한 파라미터 전달
		Map<String, Object> map = new HashMap<>();	
		
		// 총 게시글 수 
		int totalCnt = adminUsersService.getUserTotalCount(map);
		pageDTO.setTotalCnt(totalCnt);
		
		// 사용자가 마지막 페이지에 있었는데, 해당 페이지의 마지막 사용자를 삭제해서
		// 현재 페이지 번호(pageDTO.pageNum)가 총 페이지 수(pageDTO.totalPage)보다 커질 경우
		// 마지막 페이지로 강제 이동시킵니다.
		if (pageDTO.getEndPage() > 0 && pageDTO.getPageNum() > pageDTO.getEndPage()) {
		    pageDTO.setPageNum(pageDTO.getEndPage());
		}
		
		// JSP로 보내기 전에 paginationStart 값이 1보다 작은지 확인하고 보정합니다.
		if (pageDTO.getPaginationStart() < 1) {
		    pageDTO.setPaginationStart(1);
		}
		
		map.put("offset", pageDTO.getStartList());
		map.put("limit", pageDTO.getListSize());
		
		// 1. 서비스에서 게시글 리스트를 가져옵니다.
		List<AdminUsersDTO> userList = adminUsersService.getAllUsers(map);
		
		// 2. ModelAndView에 "userList"라는 이름으로 리스트를 추가합니다.
		// 이제 JSP에서 이 이름을 사용하여 데이터를 참조할 수 있습니다.
		mav.addObject("pageDTO", pageDTO);
		mav.addObject("userList", userList);
		
		mav.setViewName("admin/adminUserList");
		return mav;
	}
	
	@PostMapping("/userDelete")
	@ResponseBody
	public Map<String, String> deleteUserBySeq(@RequestParam("userSeq") int userSeq) {
		Map<String, String> response = new HashMap<>();
		int result = adminUsersService.deleteUserBySeq(userSeq);
		
		// 디버깅을 위해 서비스 메서드의 반환값을 로그로 출력합니다.
		System.out.println("삭제 시도: userSeq=" + userSeq);
		System.out.println("서비스 메서드 반환값: result=" + result);
		
		if (result > 0) {
			response.put("result", "success");
			response.put("message", "사용자가 성공적으로 탈퇴되었습니다.");
		} else {
			response.put("result", "fail");
			response.put("message", "사용자 탈퇴에 실패했습니다.");
		}
		
		return response;
	}
}
