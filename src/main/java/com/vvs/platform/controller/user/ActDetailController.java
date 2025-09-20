package com.vvs.platform.controller.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.vvs.platform.dto.user.ActDetailDTO;
import com.vvs.platform.dto.user.CommReportDTO;
import com.vvs.platform.dto.user.CommentDTO;
import com.vvs.platform.dto.user.LoginDTO;
import com.vvs.platform.dto.user.VoteDTO;
import com.vvs.platform.service.user.ActDetailService;
import com.vvs.platform.service.user.CommentService;
import com.vvs.platform.service.user.VoteService;

@Controller
@RequestMapping("/user")
@SessionAttributes("userid")
public class ActDetailController {
	@Autowired private VoteService voteService;
	@Autowired private CommentService commentService;
	@Autowired private ActDetailService actDetailService;
	@RequestMapping(value="/actdetail", method=RequestMethod.GET)
	public ModelAndView actdetail(@RequestParam("actnum") int actnum) {
		ModelAndView mav = new ModelAndView(); 
		
		// DB에서 상세 조회
	    ActDetailDTO bill = actDetailService.getBillDetail(actnum);
        
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
	   
		//수정 : 투표 직후 최신 통계 내려주기
	    List<VoteDTO> votes = voteService.getVoteList(billId);
	    int agreeCount = 0;
	    int disagreeCount = 0;
	    
	    for (VoteDTO v : votes) {
	        if ("AGREE".equals(v.getResult())) {
	            agreeCount++;
	        } else if ("DISAGREE".equals(v.getResult())) {
	            disagreeCount++;
	        }
	    }
	    response.put("success", success);
	    response.put("message", success ? "투표 성공" : "이미 투표하셨습니다.");
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
        	CommentDTO comments = commentService.getLatestCommentByUser(cmt.getBillId(), loginUser.getUserid());

            response.put("success", true);
            response.put("message", "댓글 작성 성공");
            response.put("comment", comments); 
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

