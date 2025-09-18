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
import com.vvs.platform.dto.admin.AdminBillBoardListDTO;
import com.vvs.platform.service.admin.AdminBillsService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin")
public class BillController {

	private final AdminBillsService adminBillsService;

	@GetMapping("/bill")
	public ModelAndView billList() {
		ModelAndView mav = new ModelAndView();

		// 1. 서비스에서 게시글 리스트를 가져옵니다.
		List<AdminBillBoardListDTO> billBoardList = adminBillsService.getAllBillBoardList();

		// 2. ModelAndView에 "billBoardList"라는 이름으로 리스트를 추가합니다.
		// 이제 JSP에서 이 이름을 사용하여 데이터를 참조할 수 있습니다.
		mav.addObject("billBoardList", billBoardList);

		mav.setViewName("admin/adminBillList");
		return mav;
	}

	@GetMapping("/billWriteForm")
	public ModelAndView writeForm() {
		ModelAndView mav = new ModelAndView();

		mav.setViewName("admin/adminBillForm");
		return mav;
	}

	@PostMapping("/billWriteForm")
	public ModelAndView submitForm(AdminBillBoardDTO dto) {
		ModelAndView mav = new ModelAndView();

		int result = adminBillsService.insertBillBoard(dto);

		if (result > 0) {
			mav.setViewName("redirect:/admin/bill");
		} else {
			// 실패 시 예외 처리 또는 에러 페이지로 이동
			mav.setViewName("error/error");
		}

		System.out.println("제목: " + dto.getTitle()); // 게시판에 글이 작성될 때 title을 서버 로그에서 확인하기 위한 로그

		return mav;
	}

	// 게시글 삭제 요청을 처리하는 POST 메서드
	// @ResponseBody를 사용해 JSON 응답을 반환
	@PostMapping("/billDelete")
	@ResponseBody
	public Map<String, String> deleteBillBoard(@RequestParam("billboardId") int billboardId) {
		Map<String, String> response = new HashMap<>();
		int result = adminBillsService.deleteBillBoard(billboardId);

		if (result > 0) {
			response.put("result", "success");
			response.put("message", "게시글이 성공적으로 삭제되었습니다.");
		} else {
			response.put("result", "fail");
			response.put("message", "게시글 삭제에 실패했습니다.");
		}

		return response;
	}
	
	//법안 게시글 상세페이지를 불러오는 리스트
	@GetMapping("/billDetail")
	public ModelAndView billDetail(@RequestParam("billboardId") int billboardId) {
		ModelAndView mav = new ModelAndView();
		
		// 1. 서비스에서 게시글 리스트를 가져옵니다.
		AdminBillBoardDTO billBoardDetail = adminBillsService.getBillBoardDetailByNum(billboardId);
		
		// 2. ModelAndView에 "billBoardDetail"이라는 이름으로 리스트를 추가합니다.
		// 이제 JSP에서 이 이름을 사용하여 데이터를 참조할 수 있습니다.
		mav.addObject("billBoardDetail", billBoardDetail);
		
		mav.setViewName("admin/adminBillDetail");
		
		return mav;
	}
}
