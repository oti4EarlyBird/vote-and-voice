<%@ page contentType="text/html; charset=UTF-8" language="java"%>

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
                        <label class="form-check-label" for="reason1">스팸</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="reason" id="reason2" value="성적 비방">
                        <label class="form-check-label" for="reason2">성적 비방</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="reason" id="reason3" value="욕설/비방">
                        <label class="form-check-label" for="reason3">욕설 비방</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="reason" id="reason4" value="기타">
                        <label class="form-check-label" for="reason4">기타</label>
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
document.addEventListener('DOMContentLoaded', function() { 
    // ----- 신고 모달 처리 -----
    const reportForm = document.getElementById('reportForm');
    const reportSubmit = document.getElementById('reportSubmit');

    // 이벤트 위임을 사용하여 동적으로 추가된 신고 버튼도 처리
    document.addEventListener('click', function(e) {
        if(e.target && e.target.classList.contains('report-btn')) {
            const commentId = e.target.getAttribute('data-comment-id');
            console.log('신고할 댓글 ID:', commentId); // 디버깅용
            
            if (!commentId) {
                alert('댓글 ID를 찾을 수 없습니다.');
                return;
            }
            
            const reportForm = document.getElementById('reportForm');
            reportForm.setAttribute('data-comment-id', commentId); // 모달에 commentId 전달

            const modal = new bootstrap.Modal(document.getElementById('reportModal'));
            modal.show();
        }
    });
    
    //신고 버튼 이벤트 처리
    reportSubmit.addEventListener('click', function() {
        const checked = reportForm.querySelector('input[name="reason"]:checked');
        if (!checked) {
            alert("신고 사유를 선택해주세요.");
            return;
        }
        
        const commentId = reportForm.getAttribute("data-comment-id"); // 신고 대상 댓글 seq
        const reason = checked.value;
        
        console.log('신고 요청:', { commentId, reason }); // 디버깅용

        // AJAX 호출 
        fetch(contextPath + '/user/comment/report', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: "commentId=" + commentId + "&reason=" + encodeURIComponent(reason)
        }) 
        .then(response => {
            console.log('응답 상태:', response.status); // 디버깅용
            console.log('응답 헤더:', response.headers.get('content-type')); // 디버깅용
            
            if (!response.ok) {
                throw new Error('HTTP error! status: ' + response.status);
            }
            
            // Content-Type이 JSON인지 확인
            const contentType = response.headers.get('content-type');
            if (!contentType || !contentType.includes('application/json')) {
                throw new Error('서버에서 JSON이 아닌 응답을 반환했습니다.');
            }
            
            return response.json(); 
        })
        .then(data => {
            console.log('응답 데이터:', data); // 디버깅용
            alert(data.message);
            
            const modalEl = document.getElementById('reportModal');
            const modal = bootstrap.Modal.getInstance(modalEl);
            modal.hide();
            reportForm.reset();
        })
        .catch(error => {
            console.error('신고 처리 중 오류:', error);
            alert('신고 처리 중 오류가 발생했습니다: ' + error.message);
        });
    });
});
</script>