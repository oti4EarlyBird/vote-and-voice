<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- 댓글 -->
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
            <div class="comment-item ${comment.side == '찬성' ? 'comment-support' : 'comment-oppose'}">
                <div class="d-flex justify-content-between align-items-start">
                    <div class="flex-grow-1">
                        <p class="mb-1">
                            <strong>${comment.userName}</strong>
                        </p>
                        <p class="mb-1">${comment.content}</p>
                        <p class="comment-date mb-0">${comment.createdAt}</p>
                    </div>
                    <button type="button" class="btn btn-outline-danger btn-sm report-btn">신고</button>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<!-- 신고 모달 -->
<jsp:include page="report-modal.jsp" />

<script>
document.addEventListener('DOMContentLoaded', function() { 
    // ----- 댓글 -----
    const commentSubmit = document.getElementById('commentSubmit'); 
    const commentInput = document.getElementById('exampleFormControlTextarea1');
    const charCount = document.getElementById('charCount'); 
    const commentList = document.getElementById('commentList'); 

    // 글자 수 카운트
    commentInput?.addEventListener('input', function(){ 
        let len = commentInput.value.length; 
        if(len > 1000){ 
            commentInput.value = commentInput.value.substring(0, 1000); 
            len = 1000; 
        } 
        charCount.textContent = len + '/1000'; 
    }); 

    commentSubmit?.addEventListener('click', function(){  
        const content = commentInput.value.trim(); 
        if(content === '') { 
            alert('댓글을 입력해주세요.'); 
            return;  
        }

        if (!window.voteside) {
            alert('먼저 찬성 또는 반대를 선택해 주세요.');
            return;
        }

        const commentItem = document.createElement('div'); 
        commentItem.className = 'comment-item ' + (window.voteside === '찬성' ? 'comment-support' : 'comment-oppose');

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
                <button type="button" class="btn btn-outline-danger btn-sm report-btn">신고</button> 
            </div>
        `;  
  
        commentList.appendChild(commentItem); 
        commentInput.value = ''; 
        charCount.textContent = '0/1000'; 
    });
});
</script>