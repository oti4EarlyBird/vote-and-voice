package com.vvs.platform.controller.user;
 
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
 
@Controller
@RequestMapping("/user")
public class ActListController {

    // 샘플 데이터 생성
    private static final List<Map<String, String>> actList = new ArrayList<>();
    static {
        for (int i = 1; i <= 25; i++) {
            Map<String, String> act = new HashMap<>();
            act.put("num", String.valueOf(i));
            act.put("title", "의안 제목 " + i);
            act.put("billnum", "220" + (1000 + i));
            act.put("where", "소관위원회 " + i);
            act.put("result", "의결 결과 " + i);
            act.put("date", "2025-08-" + String.format("%02d", i % 30 + 1));
            actList.add(act);
        }
    }

    @RequestMapping(value="/actlist", method=RequestMethod.GET)
    public ModelAndView actlist(
            @RequestParam(defaultValue = "1") int page) {
    	ModelAndView mav = new ModelAndView();
        int pageSize = 10; // 한 페이지당 10개
        int totalItems = actList.size();
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);
        
        // page 범위 보정
        if (page < 1) page = 1;
        if (page > totalPages) page = totalPages;
        int start = (page - 1) * pageSize;
        int end = Math.min(start + pageSize, totalItems);

        List<Map<String, String>> pageList = actList.subList(start, end);

        // JSP에 전달할 값 세팅
        mav.addObject("actList", pageList);
        mav.addObject("currentPage", page);
        mav.addObject("totalPages", totalPages);
        mav.setViewName("user/actlist");
        return mav;
    }
}

