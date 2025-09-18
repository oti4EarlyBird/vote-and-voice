package com.vvs.platform.controller.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.vvs.platform.dto.admin.PageDTO;
import com.vvs.platform.dto.user.NoticeDTO;
import com.vvs.platform.service.user.NoticeService;

@Controller
@RequestMapping("/user")
public class UserNoticeController {

	@Autowired
	private NoticeService noticeService;
	
	// 공지사항 목록
	@RequestMapping("/notice")
	public ModelAndView notice(@RequestParam(value= "page", defaultValue="1") int page,
								@RequestParam(value="category", defaultValue="all") String category) {
		ModelAndView mav = new ModelAndView();
		
		// 페이징 
		PageDTO pageDTO = new PageDTO(page, 5); 	// 10개씩 보여줌 
		Map<String, Object> map = new HashMap<>();
		map.put("category", category);		
		
		// 총 게시글 수 
		int totalCnt = noticeService.getNoticeTotalCount(map);
		pageDTO.setTotalCnt(totalCnt);
		map.put("offset", pageDTO.getStartList());
		map.put("limit", pageDTO.getListSize());
		
	System.out.println("UserNoticeController : " + totalCnt);
		// 목록 가져오기 
		//List<NoticeDTO> list = noticeService.selectNoticeList();
		List<NoticeDTO> list = noticeService.getNoticeList(map);
		
		for(NoticeDTO dto : list) {
			System.out.println(dto.getTitle());
		}
		System.out.println("totalCNT : " +totalCnt);
		System.out.println(pageDTO.getPaginationStart());
		System.out.println(pageDTO.getPaginationEnd());
		System.out.println(pageDTO.getEndPage());
		mav.addObject("pageDTO", pageDTO);
		mav.addObject("noticeList",list);
		mav.setViewName("user/userNotice");
		return mav;
	}
	
	// 공지사항 상세보기
	@RequestMapping(value="/notice/detail/{noticeSeq}")
	public ModelAndView noticeDetail(@PathVariable("noticeSeq") int noticeSeq) {
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("user/userNoticeDetail");
		return mav;
	}
	
	
}
