<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en"
      class="light-style"
      dir="ltr"
      data-theme="theme-default"
      data-assets-path="${pageContext.request.contextPath}/resources/assets/"
      data-template="vertical-menu-template-free">

<head>
    <meta charset="utf-8" />
    <title>의안 상세</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <!-- Sneat CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/vendor/css/core.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/vendor/css/theme-default.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/demo.css" />

    <!-- Vendors CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/actlist.css" />

    <!-- Helpers -->
    <script src="${pageContext.request.contextPath}/resources/assets/vendor/js/helpers.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/config.js"></script>
</head>

<body>

    <!-- Header -->


    <!-- Main Content -->
    		<%-- 컨트롤러에서 보낸 데이터 --%>
            <c:set var="bill" value="${bill}" />
			<c:set var="comments" value="${comments}" />

            <!-- 의안 상세 -->
            <div class="bill-detail">
                <h2><c:out value="${bill.title}" /></h2>
                <hr class="boldhr">
                <p>번호 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<c:out value="${bill.num}" /></p>
                <hr>
                <p>의안번호 &nbsp;&nbsp;<c:out value="${bill.billnum}" /></p>
                <hr>
                <p>소관위원회 &nbsp;&nbsp;<c:out value="${bill.where}" /></p>
                <hr>
                <p>본회의 의결일 &nbsp;&nbsp;<c:out value="${bill.date}" /></p>
                <hr>
                <p>본회의 의결 결과 &nbsp;&nbsp;<c:out value="${bill.result}" /></p>
                <hr class="boldhr">
                
                <div style="white-space: pre-line;"><c:out value="${bill.content}" /></div><br>
            </div>

            <!-- 찬반 버튼 -->
            <div class="vote-buttons">
                <button type="button" id="voteYes" class="btn btn-outline-success">찬성</button>
                <button type="button" id="voteNo" class="btn btn-outline-danger">반대</button>
            </div>

            <!-- 차트 -->
            <div style="width: 300px; margin: 20px auto;">
                <canvas id="voteChart"></canvas>
            </div>
            <div id="voteCount" style="text-align: center; font-size: 1.2em; margin-top: 10px; display: none;">
                찬성 0표 | 반대 0표
            </div>

            <!-- 댓글 -->
            <div class="comment-section">
                <h3>댓글</h3>
                <textarea id="commentInput" placeholder="당신의 의견을 알려주세요."></textarea>
                <div style="text-align: right; font-size: 0.9em; color: #666;">
                    <span id="charCount">0/1000</span>
                </div>
                <button type="button" class="btn btn-outline-secondary" id="commentSubmit">등록</button>

                <div id="commentList">
                    <c:forEach var="comment" items="${comments}">
                    <div class="comment-item">
                        <button type="button" class="btn btn-sm btn-outline-danger report-btn">신고</button>
                        <p><strong>${ comment.userName }</strong></p>
                        <p>${ comment.content }</p>
                        <p class="comment-date">${ comment.createdAt }</p>
                        <button type="button" class="btn btn-outline-secondary">대댓글</button>
                    </div>
                    </c:forEach>
                    <div style="text-align: right; margin-top: 20px;">
    					<button type="button" class="btn btn-secondary"
            			onclick="location.href='${pageContext.request.contextPath}/user/actlist'">
        				목록
    					</button>
					</div>
                </div>
            </div>
        </div>

    <%-- JS --%>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
    document.addEventListener('DOMContentLoaded', function() { 
        // ----- 찬반 투표 -----
        let agreeCount = 0; 
        let disagreeCount = 0; 
        let hasVoted = false; 

        const canvas = document.getElementById('voteChart');
            const ctx = canvas.getContext('2d');
            const voteChart = new Chart(ctx, { 
            type: 'doughnut', 
            data: { 
                labels: ['찬성','반대'], 
                datasets: [{ data:[agreeCount, disagreeCount], backgroundColor:['#28a745','#dc3545'] }] 
            }, 
            options: { 
                responsive:true, 
                plugins:{ 
                    legend:{ position:'bottom' }, 
                    tooltip:{ callbacks:{ 
                        label:function(context){ 
                            const total = agreeCount + disagreeCount; 
                            const value = context.raw; 
                            const percentage = total ? ((value/total)*100).toFixed(1) : 0; 
                            return context.label + ': ' + value + '표 (' + percentage + '%)';
                        } 
                    } } 
                } 
            } 
        }); 
		
        function updateVoteDisplay(){ 
        	const voteCountDiv = document.getElementById('voteCount');

            voteChart.data.datasets[0].data = [agreeCount, disagreeCount]; 
            voteChart.update(); 
            voteCountDiv.style.display='block'; 
            voteCountDiv.textContent = '찬성 ' + agreeCount + '표 | 반대 ' + disagreeCount + '표';
        } 

        document.getElementById("voteYes")?.addEventListener('click', function(){ 
            if(hasVoted){ alert("이미 투표하셨습니다."); return; } 
            agreeCount++; 
            hasVoted=true; 
            updateVoteDisplay(); 
        }); 

        document.getElementById("voteNo")?.addEventListener('click', function(){ 
            if(hasVoted){ alert("이미 투표하셨습니다."); return; } 
            disagreeCount++; 
            hasVoted=true; 
            updateVoteDisplay(); 
        });   

        // ----- 댓글 -----
        const commentInput = document.getElementById('commentInput'); 
        const charCount = document.getElementById('charCount'); 
        const commentSubmit = document.getElementById('commentSubmit'); 
        const commentList = document.getElementById('commentList'); 

        commentInput?.addEventListener('input', function(){ 
            let len = commentInput.value.length; 
            if(len>1000){ commentInput.value=commentInput.value.substring(0,1000); len=1000; } 
            charCount.textContent = len + '/1000'; 
        }); 

        commentSubmit?.addEventListener('click', function(){ 
            const content = commentInput.value.trim(); 
            if(content===''){ alert('댓글을 입력해주세요.'); return; } 
            const commentItem = document.createElement('div'); 
            commentItem.className='comment-item'; 

            const now = new Date(); 
            const yyyy = now.getFullYear(); 
            const mm = String(now.getMonth()+1).padStart(2,'0'); 
            const dd = String(now.getDate()).padStart(2,'0'); 
            const hh = String(now.getHours()).padStart(2,'0'); 
            const min = String(now.getMinutes()).padStart(2,'0'); 

            commentItem.innerHTML = '<p><strong>나</strong></p>'+'<p>'+content+'</p>' +
                                    '<p class="comment-date">'+yyyy+'-'+mm+'-'+dd+' '+hh+':'+min+'</p>'; 
            commentList.appendChild(commentItem); 
            commentInput.value=''; 
            charCount.textContent='0/1000'; 
        }); 
    });
 	
    </script>
	<!-- 신고 모달 -->
<div class="modal fade" id="reportModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">댓글 신고하기</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
      </div>
      <div class="modal-body">
        <form id="reportForm">
          <p>신고 사유를 선택하세요:</p>
          <div class="form-check">
            <input class="form-check-input" type="radio" name="reason" id="reason1" value="스팸" required>
            <label class="form-check-label" for="reason1">스팸/광고</label>
          </div>
          <div class="form-check">
            <input class="form-check-input" type="radio" name="reason" id="reason2" value="욕설/비방">
            <label class="form-check-label" for="reason2">욕설/비방</label>
          </div>
          <div class="form-check">
            <input class="form-check-input" type="radio" name="reason" id="reason3" value="기타">
            <label class="form-check-label" for="reason3">기타</label>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <button type="button" id="reportSubmit" class="btn btn-danger">신고하기</button>
      </div>
    </div>
  </div>
</div>
<script>
//----- 신고 모달 처리 -----
const reportButtons = document.querySelectorAll('.report-btn');
const reportForm = document.getElementById('reportForm');
const reportSubmit = document.getElementById('reportSubmit');
document.getElementById('commentList').addEventListener('click', function(e) {
    if(e.target && e.target.classList.contains('report-btn')){
        const modal = new bootstrap.Modal(document.getElementById('reportModal'));
        modal.show();
    }
});

reportButtons.forEach(btn => {
    btn.addEventListener('click', function() {
        // 신고할 댓글 id 같은 값이 있다면 여기에 저장
        const modal = new bootstrap.Modal(document.getElementById('reportModal'));
        modal.show();
    });
});

reportSubmit.addEventListener('click', function() {
    const checked = reportForm.querySelector('input[name="reason"]:checked');
    if (!checked) {
        alert("신고 사유를 선택해주세요.");
        return;
    }
    alert("신고가 완료되었습니다!");
    const modalEl = document.getElementById('reportModal');
    const modal = bootstrap.Modal.getInstance(modalEl);
    modal.hide();
    reportForm.reset();
});
</script>

    <!-- Footer -->


    <!-- Core JS -->
    <script src="${pageContext.request.contextPath}/resources/assets/vendor/libs/jquery/jquery.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/vendor/libs/popper/popper.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/vendor/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/vendor/js/menu.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/main.js"></script>

</body>
</html>
