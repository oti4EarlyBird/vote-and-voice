package com.vvs.platform.controller.user;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.vvs.platform.dto.user.VoteDTO;
import com.vvs.platform.service.user.VoteService;

@Controller
@RequestMapping("/user")
@SessionAttributes("userid")
public class ActDetailController {
	@Autowired private VoteService voteService;
	@RequestMapping(value="/actdetail", method=RequestMethod.GET)
	public ModelAndView actdetail(@RequestParam("actnum") String reqActnum) {
		ModelAndView mav = new ModelAndView(); 
		
		int actnum = Integer.parseInt(reqActnum);
		//임시 의안 데이터
		Map<String, String> bill = new HashMap<>();
        bill.put("num", "1");
        bill.put("title", "2025년 신규 교육 정책 제안");
        bill.put("billnum", "2206839");
        bill.put("where", "법사위원회");
        bill.put("date", "2025-08-23");
        bill.put("author", "김철수");
        bill.put("type", "교육");
        bill.put("result", "대안 반영 폐기");
        bill.put("content", "이번 정책은 전국 학생들의 학습 환경 개선을 목표로 하며, 구체적으로 교사 배치, 교재 개선, \n온라인 학습 인프라 확충 등을 포함합니다.\n"
        		+ "또한, 지역 간 교육 격차를 해소하기 위해 농어촌 및 도서 지역 학교에 대한 지원을 강화하고,\n"
        		+ "학습 취약 계층을 위한 맞춤형 교육 프로그램을 확대할 예정입니다.\n아울러, 최신 ICT 기술을 활용한 스마트 교실을 보급하고, "
        		+ "학생들의 자기주도 학습 능력을 키울 수 있는 \n온라인 플랫폼을 구축하여 지속 가능한 교육 환경을 마련하고자 합니다.");
        
        // 임시 댓글 데이터
        List<Map<String, String>> comments = new ArrayList<>();
        Map<String, String> comment1 = new HashMap<>();
        comment1.put("userName", "박영희");
        comment1.put("content", "정책 내용이 구체적이네요. 찬성합니다!");
        comment1.put("createdAt", "2025-08-13 14:30");
        comment1.put("side", "찬성");
        comments.add(comment1);

        Map<String, String> comment2 = new HashMap<>();
        comment2.put("userName", "이민수");
        comment2.put("content", "효과가 있을지 조금 의문입니다.");
        comment2.put("createdAt", "2025-08-13 15:05");
        comment2.put("side", "반대");
        comments.add(comment2);
        
        mav.addObject("bill", bill);
        mav.addObject("comments", comments);
        mav.setViewName("user/actdetail");
        return mav;
	}
	@PostMapping("/vote")
	@ResponseBody
	public String vote(VoteDTO vote) {
		return voteService.doVote(vote)?"success":"fail";
	}
}
