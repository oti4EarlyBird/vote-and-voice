package com.vvs.platform.controller.user;

import java.util.ArrayList;
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

    @Autowired
    private VoteService voteService;
    @Autowired
    private CommentService commentService;
    @Autowired
    private ActDetailService actDetailService;

    // 의안 상세 조회
    @RequestMapping(value="/actdetail", method=RequestMethod.GET)
    public ModelAndView actdetail(@RequestParam("actnum") int actnum) {
        ModelAndView mav = new ModelAndView(); 
        
        // DB에서 상세 조회
        ActDetailDTO bill = actDetailService.getBillDetail(actnum);

        // 디버깅
        System.out.println("=== 컨트롤러 디버깅 ===");
        System.out.println("actnum: " + actnum);
        System.out.println("bill: " + bill);
        System.out.println("bill.getBillId(): " + (bill != null ? bill.getBillId() : "null"));

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

        // 댓글 불러오기
        List<CommentDTO> comments = new ArrayList<>();
        if (bill != null && bill.getBillId() > 0 && bill.getBillId() > 0) {
            comments = commentService.listAllByBillId(bill.getBillId());
            System.out.println("댓글 조회 결과: " + comments.size() + "개");
            if (!comments.isEmpty()) {
                System.out.println("첫 번째 댓글: " + comments.get(0));
            }
        } else {
            System.out.println("ERROR: bill이 null이거나 billId가 유효하지 않음!");
        }

        mav.addObject("bill", bill);
        mav.addObject("comments", comments);
        mav.addObject("agreeCount", agreeCount);
        mav.addObject("disagreeCount", disagreeCount);
        mav.setViewName("user/actdetail");

        return mav;
    }

    // ✅ 투표 통계 API
    @RequestMapping(value="/vote-stats", method=RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> getVoteStats(@RequestParam("billId") int billId) {
        Map<String, Object> response = new HashMap<>();
        
        try {
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
            
            response.put("success", true);
            response.put("agreeCount", agreeCount);
            response.put("disagreeCount", disagreeCount);
            response.put("totalCount", agreeCount + disagreeCount);
            
        } catch (Exception e) {
            System.out.println("투표 통계 조회 오류: " + e.getMessage());
            response.put("success", false);
            response.put("message", "투표 통계 조회 실패");
            response.put("agreeCount", 0);
            response.put("disagreeCount", 0);
            response.put("totalCount", 0);
        }
        
        return response;
    }

    // 투표 처리
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

        // 최신 통계 조회
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
    @ResponseBody
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
            CommentDTO savedComment = commentService.getLatestCommentByUser(cmt.getBillId(), loginUser.getUserid());
            response.put("success", true);
            response.put("message", "댓글 작성 성공");
            response.put("comment", savedComment);
        } else {
            response.put("success", false);
            response.put("message", "댓글 작성 실패");
        }

        return response;
    }

    // 댓글 신고
    @PostMapping("/comment/report")
    @ResponseBody
    public Map<String, Object> report(@RequestParam Long commentId, 
                                      @RequestParam String reason, 
                                      HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        LoginDTO loginUser = (LoginDTO) session.getAttribute("loginUser");

        if (loginUser == null) {
            response.put("success", false);
            response.put("message", "로그인이 필요합니다.");
            return response;
        }

        CommReportDTO rpt = new CommReportDTO();
        rpt.setReporterId(loginUser.getUserid());
        rpt.setCommentId(commentId);
        rpt.setReportContent(reason);

        int result = commentService.insertReport(rpt);

        response.put("success", result > 0);
        response.put("message", result > 0 ? "신고가 접수되었습니다." : "신고 실패");

        return response;
    }
}
