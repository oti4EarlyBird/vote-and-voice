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
                        <label class="form-check-label" for="reason1">스팸/광고</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="reason" id="reason2" value="욕설/비방">
                        <label class="form-check-label" for="reason2">성적 수치심</label>
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
document.addEventListener('DOMContentLoaded', function() { 
    // ----- 신고 모달 처리 -----
    const reportForm = document.getElementById('reportForm');
    const reportSubmit = document.getElementById('reportSubmit');

    // 이벤트 위임을 사용하여 동적으로 추가된 신고 버튼도 처리
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
});
</script>