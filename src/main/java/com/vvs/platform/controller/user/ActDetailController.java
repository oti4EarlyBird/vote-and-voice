package com.vvs.platform.controller.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.vvs.platform.dto.user.CommReportDTO;
import com.vvs.platform.dto.user.CommentDTO;
import com.vvs.platform.dto.user.LoginDTO;
import com.vvs.platform.dto.user.VoteDTO;
import com.vvs.platform.service.user.CommentService;
import com.vvs.platform.service.user.VoteService;

@Controller
@RequestMapping("/user")
@SessionAttributes("userid")
public class ActDetailController {
	@Autowired private VoteService voteService;
	@Autowired private CommentService commentService;
	@RequestMapping(value="/actdetail", method=RequestMethod.GET)
	public ModelAndView actdetail(@RequestParam("actnum") String reqActnum) {
		ModelAndView mav = new ModelAndView(); 
		
		int actnum = Integer.parseInt(reqActnum);
		//임시 의안 데이터
		Map<String, String> bill = new HashMap<>();
        bill.put("billId", String.valueOf(actnum));
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
        
        // 실제 투표 데이터 가져오기
        List<VoteDTO> votes = voteService.getVoteList(actnum);
        int agreeCount = 0;
        int disagreeCount = 0;
        
        for (VoteDTO vote : votes) {
            if ("AGREE".equals(vote.getResult())) {
                agreeCount++;
            } else if ("DISAGREE".equals(vote.getResult())) {
                disagreeCount++;
            }
        }
        //DB에서 댓글 불러오기
        List<CommentDTO> comments = commentService.listAllByBillId(actnum);
        
        mav.addObject("bill", bill);
        mav.addObject("comments", comments);
        mav.addObject("agreeCount", agreeCount);
        mav.addObject("disagreeCount", disagreeCount);
        mav.setViewName("user/actdetail");
        
        return mav;
    }
	//투표 처리
	@PostMapping("/vote")
	@ResponseBody
	public Map<String, Object> doVote(@RequestParam("billId") int billId, 
	                     @RequestParam(value = "result", required = false, defaultValue = "AGREE") String result, 
	                     HttpSession session) {
		Map<String, Object> response = new HashMap<>();
	    LoginDTO loginUser = (LoginDTO) session.getAttribute("loginUser");

	    if (loginUser == null) {
	        response.put("success", false);
	        response.put("message", "로그인이 필요합니다.");
	        return response;
	    }

	    VoteDTO vote = new VoteDTO();
	    vote.setBillId(billId);
	    vote.setUserId(loginUser.getUserid());
	    vote.setResult(result);

	    boolean success = voteService.doVote(vote);
	    response.put("success", success);
	    response.put("message", success ? "투표 성공" : "이미 투표하셨습니다.");
	    return response;
	}  
	// 투표 현황만 조회하는 AJAX 메서드 추가
	@GetMapping("/vote-stats")
	@ResponseBody
	public Map<String, Object> getVoteStats(@RequestParam("billId") int billId) {
	    Map<String, Object> response = new HashMap<>();
	    
	    List<VoteDTO> votes = voteService.getVoteList(billId);
	    int agreeCount = 0;
	    int disagreeCount = 0;
	    
	    for (VoteDTO vote : votes) {
	        if ("AGREE".equals(vote.getResult())) {
	            agreeCount++;
	        } else if ("DISAGREE".equals(vote.getResult())) {
	            disagreeCount++;
	        }
	    }
	    
	    response.put("agreeCount", agreeCount);
	    response.put("disagreeCount", disagreeCount);
	    response.put("totalCount", agreeCount + disagreeCount);
	    
	    return response;
	} 
	// 댓글 작성
    @PostMapping("/comment/write")
    @ResponseBody //JSON 응답
    public Map<String, Object> writeComment(@RequestBody CommentDTO cmt, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        LoginDTO loginUser = (LoginDTO) session.getAttribute("loginUser");

        if (loginUser == null) {
            response.put("success", false);
            response.put("message", "로그인이 필요합니다.");
            return response;
        }

        cmt.setUserId(loginUser.getUserid());
        int result = commentService.insertC(cmt);
        
        if (result > 0) {
            //방금 저장된 댓글 다시 조회해서 반환
            CommentDTO newComment = commentService.selectById(cmt.getSeq());

            response.put("success", true);
            response.put("message", "댓글 작성 성공");
            response.put("comment", newComment); 
        } else {
            response.put("success", false);
            response.put("message", "댓글 작성 실패");
        }

        return response;
    }
    //댓글 신고
    @PostMapping("/comment/report")
    @ResponseBody //JSON 응답
    public Map<String, Object> report(@RequestParam Long commentId, 
    								@RequestParam String reason, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        LoginDTO loginUser = (LoginDTO) session.getAttribute("loginUser");

        if (loginUser == null) {
            response.put("success", false);
            response.put("message", "로그인이 필요합니다.");
            return response;
        }
        //DTO 생성
        CommReportDTO rpt = new CommReportDTO();
        rpt.setReporterId(loginUser.getUserid());
        rpt.setCommentId(commentId);
        rpt.setReportContent(reason);
        
        int result = commentService.insertReport(rpt); // Service 호출

        response.put("success", result > 0);
        response.put("message", result > 0 ? "신고가 접수되었습니다." : "신고 실패");
        
        return response;
    }
}

