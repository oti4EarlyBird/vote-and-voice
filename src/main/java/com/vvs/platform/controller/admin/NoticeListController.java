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

import com.vvs.platform.dto.admin.AdminBillBoardDTO;
import com.vvs.platform.dto.admin.AdminNoticesDTO;
import com.vvs.platform.service.admin.AdminNoticesService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin")
public class NoticeListController {
	private final AdminNoticesService adminNoticesService;
	
	@GetMapping("/noticeList")
	public ModelAndView noticeList() {
		ModelAndView mav = new ModelAndView();
		
		// 1. 서비스에서 게시글 리스트를 가져옵니다.
		List<AdminNoticesDTO> noticeList = adminNoticesService.getAllNotices();

		// 2. ModelAndView에 "noticeList"라는 이름으로 리스트를 추가합니다.
		// 이제 JSP에서 이 이름을 사용하여 데이터를 참조할 수 있습니다.
		mav.addObject("noticeList", noticeList);
		
		mav.setViewName("admin/adminNoticeList");
		return mav;
	}
	
	@GetMapping("/noticesByCategory")
	@ResponseBody
	public List<AdminNoticesDTO> getNoticesByCategory(@RequestParam(value = "category", required = false) String category) {
		if (category == null || category.isEmpty() || "ALL".equalsIgnoreCase(category)) {
			// 카테고리가 없거나 'ALL'인 경우, 모든 공지사항을 반환합니다.
			return adminNoticesService.getAllNotices();
		}
		else {
			// 특정 카테고리의 공지사항을 반환합니다.
			return adminNoticesService.getNoticesByCategory(category);
		}
	}
	
	@GetMapping("/noticeWriteForm")
	public ModelAndView writeForm() {
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("admin/adminNoticeForm");
		return mav;
	}
	
	@PostMapping("/noticeWriteForm")
	public ModelAndView submitForm(AdminNoticesDTO dto) {
		ModelAndView mav = new ModelAndView();

		int result = adminNoticesService.insertNotice(dto);

		if (result > 0) {
			mav.setViewName("redirect:/admin/noticeList");
		} else {
			// 실패 시 예외 처리 또는 에러 페이지로 이동
			mav.setViewName("error/error");
		}

		System.out.println("제목: " + dto.getTitle()); // 게시판에 그리 작성될 때 title을 서버 로그에서 확인하기 위한 로그

		return mav;
	}
	
	//공지사항 글 삭제 요청을 처리하는 POST 메서드
	// @ResponseBody를 사용해 JSON 응답을 반환
	@PostMapping("/noticeDelete")
	@ResponseBody
	public Map<String, String> deleteNotice(@RequestParam("noticeId") int noticeId) {
		Map<String, String> response = new HashMap<>();
		int result = adminNoticesService.deleteNotice(noticeId);
				if (result > 0) {
			response.put("result", "success");
			response.put("message", "공지사항글이 성공적으로 삭제되었습니다.");
		} else {
			response.put("result", "fail");
			response.put("message", "공지사항글 삭제에 실패했습니다.");
		}
		
		return response;
	}
}
