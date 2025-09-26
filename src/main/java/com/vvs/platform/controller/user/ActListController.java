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
import com.vvs.platform.dto.user.ActListDTO;
import com.vvs.platform.service.user.ActListService;
 
@Controller
@RequestMapping("/user")
public class ActListController {
	
	@Autowired 
	private ActListService actlistService;

 	@RequestMapping("/actlist")
 	public ModelAndView notice(@RequestParam(value= "page", defaultValue="1") int page,
 								@RequestParam(value="category", defaultValue="all") String category) {
 		ModelAndView mav = new ModelAndView();

 		int pageSize = 10;
 		PageDTO pageDTO = new PageDTO(page, pageSize); 	// 10개씩 보여줌 
 		Map<String, Object> map = new HashMap<>();
 		map.put("category", category);	
 		int totalCnt = actlistService.getActTotalCount(map);
 		pageDTO.setTotalCnt(totalCnt);
 				
 		map.put("offset", pageDTO.getStartList());
 		map.put("limit", pageDTO.getListSize());
 		
 		System.out.println("UserNoticeController : " + totalCnt);
 
	 	List<ActListDTO> list = actlistService.getActList(map);
	
	    mav.addObject("list", list);
	    mav.addObject("pageDTO", pageDTO);
	    mav.addObject("category", category);
	    mav.setViewName("user/actlist");
	    return mav;
	 	}
	 	
}

