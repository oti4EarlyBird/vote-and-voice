<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- 댓글 작성 -->
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
                            <strong>${comment.userId}</strong>
                        </p>
                        <p class="mb-1">${comment.content}</p>
                        <p class="comment-date mb-0">${comment.createdAt}</p>
                    </div>
                    <button type="button" class="btn btn-outline-danger btn-sm report-btn" data-comment-id=${comment.seq}>신고</button>
                </div>
            </div>
        </c:forEach>
    </div> 
</div>

<!-- 신고 모달 -->
<jsp:include page="report-modal.jsp" />

<script>
// 서버 데이터를 JavaScript 변수로 전달
const contextPath = '${pageContext.request.contextPath}';
const billId = '${bill.billId}';

document.addEventListener('DOMContentLoaded', function() {  
    const commentSubmit = document.getElementById('commentSubmit'); 
    const commentInput = document.getElementById('exampleFormControlTextarea1');
    const charCount = document.getElementById('charCount'); 
    const commentList = document.getElementById('commentList'); 

    // 디버깅: 현재 상태 확인
    console.log('=== 초기 상태 확인 ===');
    console.log('commentList:', commentList);
    console.log('기존 댓글 수:', commentList ? commentList.children.length : 0);
    console.log('commentList 스타일:', commentList ? window.getComputedStyle(commentList) : 'null');

    // 글자 수 카운트 이벤트
    commentInput?.addEventListener('input', function(){ 
        let len = commentInput.value.length; 
        if(len > 1000){ 
            commentInput.value = commentInput.value.substring(0, 1000); 
            len = 1000; 
        } 
        charCount.textContent = len + '/1000'; 
    });  
 	
    // 댓글 등록 이벤트
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

        console.log('=== 댓글 등록 시작 ===');
        console.log('내용:', content);
        console.log('측면:', window.voteside);

        // AJAX로 DB 저장 요청
        fetch(contextPath + '/user/comment/write', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                billId: billId,
                content: content,
                side: window.voteside
            })
        })
        .then(res => res.json())
        .then(data => {
            console.log('=== 서버 응답 ===');
            console.log('전체 응답:', data);
            
            if (data.success && data.comment) { 
                const comment = data.comment;
                console.log('댓글 데이터:', comment);
                
                // 완전히 새로운 방법: 기존 첫 번째 댓글과 동일하게 생성
                const firstExistingComment = commentList.querySelector('.comment-item');
                console.log('기존 첫 댓글:', firstExistingComment);
                
                if (firstExistingComment) {
                    // 기존 댓글의 전체 구조를 복사
                    const newComment = firstExistingComment.cloneNode(true);
                    console.log('복제된 댓글:', newComment);
                    
                    // 내용만 새로 교체
                    const strongTag = newComment.querySelector('strong');
                    const contentP = newComment.querySelectorAll('p')[1];
                    const dateP = newComment.querySelector('.comment-date');
                    
                    if (strongTag) {
                        strongTag.textContent = comment.userId;
                        console.log('사용자명 교체:', comment.userId);
                    }
                    if (contentP) {
                        contentP.textContent = comment.content;
                        console.log('내용 교체:', comment.content);
                    }
                    if (dateP) {
                        dateP.textContent = comment.createdAt;
                        console.log('날짜 교체:', comment.createdAt);
                    }
                    
                    // 클래스 재설정
                    newComment.className = 'comment-item ' + (comment.side === '찬성' ? 'comment-support' : 'comment-oppose');
                    console.log('클래스 설정:', newComment.className);
                    
                    // 임시로 눈에 띄는 스타일 적용
                    newComment.style.cssText = `
                        background-color: #ffffcc !important;
                        border: 3px solid #ff6b6b !important;
                        margin-bottom: 1rem !important;
                        padding: 1rem !important;
                        display: block !important;
                        visibility: visible !important;
                        opacity: 1 !important;
                    `;
                    
                    // 맨 위에 삽입
                    commentList.insertBefore(newComment, commentList.firstChild);
                    console.log('DOM에 삽입 완료');
                    
                    // 삽입 후 상태 확인
                    console.log('삽입 후 댓글 수:', commentList.children.length);
                    console.log('첫 번째 요소:', commentList.firstChild);
                    
                    // 스크롤을 위로
                    commentList.scrollTop = 0;
                    
                } else {
                    // 기존 댓글이 없는 경우 (첫 댓글)
                    console.log('첫 번째 댓글 생성');
                    
                    const commentItem = document.createElement('div');
                    commentItem.className = 'comment-item ' + (comment.side === '찬성' ? 'comment-support' : 'comment-oppose');
                    
                    // 강력한 스타일 적용
                    commentItem.style.cssText = `
                        border: 2px solid #ccc !important;
                        border-radius: 8px !important;
                        padding: 1rem !important;
                        margin-bottom: 1rem !important;
                        background-color: #f9f9f9 !important;
                        display: block !important;
                        visibility: visible !important;
                        opacity: 1 !important;
                        min-height: 60px !important;
                    `;
                    
                    // 찬성/반대 색상
                    if (comment.side === '찬성') {
                        commentItem.style.borderColor = '#28a745 !important';
                    } else {
                        commentItem.style.borderColor = '#dc3545 !important';
                    }
                     
                    commentItem.innerHTML = ` 
                        <div class="d-flex justify-content-between align-items-start">
                            <div class="flex-grow-1">
                                <p class="mb-1"><strong>${comment.userId}</strong></p> 
                                <p class="mb-1">${comment.content}</p>
                                <p class="comment-date mb-0">${comment.createdAt}</p>
                            </div> 
                            <button type="button" class="btn btn-outline-danger btn-sm report-btn" data-comment-id="${comment.seq}">신고</button>
                        </div>
                    `; 
                     
                    commentList.appendChild(commentItem);
                    console.log('첫 댓글 추가 완료');
                }
                
                // 입력 필드 초기화
                commentInput.value = ''; 
                charCount.textContent = '0/1000';
                 
                // 확인 메시지
                setTimeout(() => {
                    const currentCount = commentList.children.length;
                    alert(`댓글이 추가되었습니다! (현재 총 ${currentCount}개)`);
                }, 100);
                
            } else {
                alert(data.message || '댓글 작성 실패');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('댓글 등록 중 오류가 발생했습니다.');
        });
    }); 
});
</script>