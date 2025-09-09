<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en" class="light-style" dir="ltr" data-theme="theme-default"
	data-assets-path="${pageContext.request.contextPath}/resources/assets/"
	data-template="vertical-menu-template-free">

<head>
<meta charset="utf-8" />
<title>의안 상세</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!-- Sneat CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets/vendor/css/core.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets/vendor/css/theme-default.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets/css/demo.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets/css/actdetail.css" />
<!-- Vendors CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

<!-- Custom CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets/css/actlist.css" />

<!-- Helpers -->
<script
	src="${pageContext.request.contextPath}/resources/assets/vendor/js/helpers.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/assets/js/config.js"></script>
</head>

<body>

	<!-- Header -->


	<div class="container-xxl flex-grow-1 container-p-y">
		<div class="row">
			<!-- 좌측 카드 -->
			<div class="col-md-4 mb-4">
				<div class="card mb-3">
					<img class="card-img-top"
						src="${pageContext.request.contextPath}/resources/assets/img/elements/18.jpg"
						alt="Card image cap" />
					<div class="card-body">
						<h5 class="card-title">의안 제목</h5>
						<p class="card-text">의안 내용 요약</p>
						<p class="card-text">
							<button type="button" class="btn btn-primary">원안 확인하기</button>
						</p>
					</div>
				</div>
			</div>

			<!-- 우측 의안 상세 카드 -->
			<div class="col-md-8">
				<div class="card p-4 mb-4">
					<!-- 의안 상세 내용 시작 -->
					<%-- 컨트롤러에서 보낸 데이터 --%>
					<c:set var="bill" value="${bill}" />
					<c:set var="comments" value="${comments}" />

					<!-- 의안 상세 -->
					<div class="bill-detail">
						<h2>
							<c:out value="${bill.title}" />
						</h2>
						<hr class="boldhr">
						<p>
							번호 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<c:out value="${bill.num}" />
						</p>
						<hr>
						<p>
							의안번호 &nbsp;&nbsp;
							<c:out value="${bill.billnum}" />
						</p>
						<hr>
						<p>
							소관위원회 &nbsp;&nbsp;
							<c:out value="${bill.where}" />
						</p>
						<hr>
						<p>
							본회의 의결일 &nbsp;&nbsp;
							<c:out value="${bill.date}" />
						</p>
						<hr>
						<p>
							본회의 의결 결과 &nbsp;&nbsp;
							<c:out value="${bill.result}" />
						</p>
						<hr class="boldhr">

						<div style="white-space: pre-line;">
							<c:out value="${bill.content}" />
						</div>
						<br>
					</div>

					<!-- 찬반 버튼 -->
					<div class="vote-buttons">
						<button type="button" id="voteYes" class="btn btn-outline-success">찬성</button>
						<button type="button" id="voteNo" class="btn btn-outline-danger">반대</button>
					</div>

					<!-- 차트 -->
					<div style="width: 300px; margin: 20px auto;">
						<canvas id="voteChart" width="300" height="200" style="display: block;"></canvas>
					</div>
					<div id="voteCount"
						style="text-align: center; font-size: 1.2em; margin-top: 10px; display: none;">
						찬성 0표 | 반대 0표</div>

					<!-- 댓글 -->
					<!-- 댓글 작성 부분 수정 -->
					<div class="comment-section">
						<h3>댓글</h3>
						<div class="comment-input-container">
							<textarea class="form-control" id="exampleFormControlTextarea1"
								rows="3" placeholder="당신의 의견을 알려주세요."></textarea>
							<div class="comment-input-footer">
								<div class="char-count">
									<span id="charCount">0/1000</span>
								</div>
								<button type="button" class="btn btn-primary" id="commentSubmit">등록</button>
							</div>
						</div>
						<br>
						<!-- 댓글목록 -->
						<div id="commentList" class="d-flex flex-column">
							<c:forEach var="comment" items="${comments}">
								<div
									class="comment-item ${comment.side == '찬성' ? 'comment-support' : 'comment-oppose'}">
									<div class="d-flex justify-content-between align-items-start">
										<div class="flex-grow-1">
											<p class="mb-1">
												<strong>${comment.userName}</strong>
											</p>
											<p class="mb-1">${comment.content}</p>
											<p class="comment-date mb-0">${comment.createdAt}</p>
										</div>
										<button type="button" class="btn btn-outline-danger" id="report-btn">신고</button>
									</div>
								</div>
							</c:forEach>
						</div>
						<div style="text-align: right; margin-top: 20px;">
							<button type="button" class="btn btn-secondary"
								onclick="location.href='${pageContext.request.contextPath}/user/actlist'">
								목록</button>
						</div>
					</div>

					<%-- JS --%>
					
					<script>
    document.addEventListener('DOMContentLoaded', function() { 
        // ----- 찬반 투표 -----
        let agreeCount = 0; 
        let disagreeCount = 0; 
        let hasVoted = false; 
        let voteside = null;

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
            voteChart.data.datasets[0].data = [agreeCount, disagreeCount]; 
            voteChart.update(); 
            
            const voteCountDiv = document.getElementById('voteCount');
            voteCountDiv.style.display='block'; 
            voteCountDiv.textContent = '찬성 ' + agreeCount + '표 | 반대 ' + disagreeCount + '표';
            
         	// 캔버스 표시 보장
            document.getElementById('voteChart').style.display = 'block';
        }  
		
        document.getElementById("voteYes")?.addEventListener('click', function(){ 
            if(hasVoted){ alert("이미 투표하셨습니다."); return; } 
            agreeCount++; 
            hasVoted=true; 
            voteside='찬성';
            updateVoteDisplay(); 
        }); 

        document.getElementById("voteNo")?.addEventListener('click', function(){ 
            if(hasVoted){ alert("이미 투표하셨습니다."); return; } 
            disagreeCount++; 
            hasVoted=true; 
            voteside='반대';
            updateVoteDisplay(); 
        });   

        // ----- 댓글 -----
        const commentSubmit = document.getElementById('commentSubmit'); 
        const commentList = document.getElementById('commentList'); 

        commentSubmit?.addEventListener('click', function(){ 
            const content = commentInput.value.trim(); 
            if(content === '') { 
                alert('댓글을 입력해주세요.'); 
                return; 
            }

            if (!voteside) {
                alert('먼저 찬성 또는 반대를 선택해 주세요.');
                return;
            }

            const commentItem = document.createElement('div'); 
            commentItem.className = 'comment-item ' + (voteside === '찬성' ? 'comment-support' : 'comment-oppose');

            const now = new Date(); 
            const yyyy = now.getFullYear(); 
            const mm = String(now.getMonth()+1).padStart(2,'0'); 
            const dd = String(now.getDate()).padStart(2,'0'); 
            const hh = String(now.getHours()).padStart(2,'0'); 
            const min = String(now.getMinutes()).padStart(2,'0'); 

            commentItem.innerHTML = `
                <div class="d-flex justify-content-between align-items-start">
                    <div class="flex-grow-1">
                        <p class="mb-1"><strong>나</strong></p>
                        <p class="mb-1">${content}</p>
                        <p class="comment-date mb-0">${yyyy}-${mm}-${dd} ${hh}:${min}</p>
                    </div>
                    <button type="button" class="btn btn-outline-danger" id="report-btn">신고</button>
                    
                </div>
            `; 

            document.getElementById('commentList').appendChild(commentItem); 
            commentInput.value = ''; 
            charCount.textContent = '0/1000'; 
        });
        
    </script>
					<!-- 신고 모달 -->
					<div class="modal fade" id="reportModal" tabindex="-1"
						aria-hidden="true">
						<div class="modal-dialog modal-dialog-centered">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title">댓글 신고하기</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="닫기"></button>
								</div>
								<div class="modal-body">
									<form id="reportForm">
										<p>신고 사유를 선택하세요:</p>
										<div class="form-check">
											<input class="form-check-input" type="radio" name="reason"
												id="reason1" value="스팸" required> <label
												class="form-check-label" for="reason1">스팸/광고</label>
										</div>
										<div class="form-check">
											<input class="form-check-input" type="radio" name="reason"
												id="reason2" value="욕설/비방"> <label
												class="form-check-label" for="reason2">욕설/비방</label>
										</div>
										<div class="form-check">
											<input class="form-check-input" type="radio" name="reason"
												id="reason3" value="기타"> <label
												class="form-check-label" for="reason3">기타</label>
										</div>
									</form>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary"
										data-bs-dismiss="modal">취소</button>
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

document.addEventListener('click', function(e) {
    if(e.target && e.target.classList.contains('report-btn')) {
        e.preventDefault();
        e.stopPropagation();
        const modal = new bootstrap.Modal(document.getElementById('reportModal'));
        modal.show();
    }
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
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
        const commentInput = document.getElementById('exampleFormControlTextarea1'); 
        const charCount = document.getElementById('charCount'); 
        commentInput?.addEventListener('input', function(){ 
            let len = commentInput.value.length; 
            if(len>1000){ 
            	commentInput.value=commentInput.value.substring(0,1000); len=1000; 
            	} 
            }
            charCount.textContent = len + '/1000'; 
        }); 
</script>

					<!-- Footer -->


					<!-- Core JS -->
					<script
						src="${pageContext.request.contextPath}/resources/assets/vendor/libs/jquery/jquery.js"></script>
					<script
						src="${pageContext.request.contextPath}/resources/assets/vendor/libs/popper/popper.js"></script>
					<script
						src="${pageContext.request.contextPath}/resources/assets/vendor/js/bootstrap.js"></script>
					<script
						src="${pageContext.request.contextPath}/resources/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
					<script
						src="${pageContext.request.contextPath}/resources/assets/vendor/js/menu.js"></script>
					<script
						src="${pageContext.request.contextPath}/resources/assets/js/main.js"></script>
</body>
</html>
