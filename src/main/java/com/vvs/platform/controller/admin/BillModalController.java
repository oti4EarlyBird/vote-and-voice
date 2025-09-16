package com.vvs.platform.controller.admin;

import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.vvs.platform.dto.admin.AdminBillsDTO;
import com.vvs.platform.dto.admin.PageDTO;
import com.vvs.platform.service.admin.AdminBillsService;

import lombok.RequiredArgsConstructor;

//뷰를 불러오지 않는 @Restcontroller 집합 
@RestController
@RequiredArgsConstructor
@RequestMapping("/admin")
public class BillModalController {
	
	private final AdminBillsService adminBillsService;
	
	@GetMapping("/billModalSearch")
	public Map<String, Object> ModalSearch(@RequestParam(defaultValue = "1") int pageNum, @RequestParam(defaultValue = "10") int listSize) {
		PageDTO pageDTO = new PageDTO(pageNum, listSize);
		
		Map<String, Object> result = adminBillsService.getBillInModalSearch(pageDTO);
		
		return result;
	}
}
