package com.vvs.platform.controller.user;
//
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
		
		// 목록 가져오기 
		//List<NoticeDTO> list = noticeService.selectNoticeList();
		List<NoticeDTO> list = noticeService.getNoticeList(map);
		
		for(NoticeDTO dto : list) {
			System.out.println(dto.getTitle());
		}

		mav.addObject("pageDTO", pageDTO);
		mav.addObject("noticeList",list);
		mav.setViewName("user/userNotice");
		return mav;
	}
	
	
	// 공지사항 상세보기
	@RequestMapping(value="/notice/detail/{noticeSeq}")
	public String noticeDetail(@PathVariable("noticeSeq") int noticeSeq, Model model, HttpSession session) {
		
		// 조회수 증가  (공지사항 번호, 조회수)
		Map<Integer, Long> viewedMap  = (Map<Integer, Long>) session.getAttribute("viewedMap");
		
		if(viewedMap  == null) {
			viewedMap  = new HashMap<Integer, Long>();
		}
		
		long now = System.currentTimeMillis(); // 현재 시간을 밀리초 단위로 가져옴
		long lastViewedTime = viewedMap .getOrDefault(noticeSeq, 0L);  // 해당 게시글의 마지막 조회 시간
		
		if(now - lastViewedTime > 30*60*100) { //3분
			noticeService.incrementViewCount(noticeSeq);  // 조회수 증가
			viewedMap.put(noticeSeq, now);		// 세션에 저장 
			session.setAttribute("viewedMap", viewedMap );
		}
		
		//  특정 번호(현재)의 공지사항 하나의 정보 가져옴 //55
		NoticeDTO noticeDTO = noticeService.getNoticeById(noticeSeq);		
		System.out.println(noticeDTO);
		// 이전글 제목, 번호
		NoticeDTO prevNotice = noticeService.getPrevNotice(noticeSeq); //56
		// 다음글 제목, 번호
		NoticeDTO nextNotice = noticeService.getNextNotice(noticeSeq);  //54
			
		
		
		System.out.println("viewedMap  : " + viewedMap  );
		System.out.println("noticeSeq : " + noticeSeq);
		System.out.println("now : " + now);
		System.out.println("lastViewedTime : " + lastViewedTime);
		
		
		model.addAttribute("noticeSeq", noticeSeq);
		model.addAttribute("noticeDTO", noticeDTO);
		model.addAttribute("prevNotice", prevNotice);
		model.addAttribute("nextNotice", nextNotice);
		
		return "user/userNoticeDetail";
	}
	
	
}
