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
    
    <!-- 디버깅 정보 -->
    <div style="background-color: #f0f0f0; padding: 10px; margin: 10px 0; border: 1px solid #ccc;">
        <strong>디버깅 정보:</strong><br>
        댓글 리스트 존재: ${not empty comments ? 'YES' : 'NO'}<br>
        댓글 개수: ${comments.size()}<br>
        Bill ID: ${bill.billId}<br>
    </div>
    
    <!-- 댓글목록 -->
    <div id="commentList" style="border: 2px solid red; padding: 20px; min-height: 200px; background-color: #f9f9f9;">
        <h4>댓글 목록</h4>
        
        <c:choose>
            <c:when test="${empty comments}">
                <div style="text-align: center; color: #888; padding: 50px;">
                    아직 댓글이 없습니다. 첫 번째 댓글을 작성해보세요!
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="comment" items="${comments}" varStatus="status">
                    <div style="border: 3px solid blue; background-color: lightyellow; padding: 20px; margin: 15px 0;">
                        <div><strong>댓글 #${status.count}</strong></div>
                        <div><strong>사용자:</strong> ${comment.userId}</div>
                        <div><strong>측면:</strong> ${comment.side}</div>
                        <div><strong>내용:</strong> ${comment.content}</div>
                        <div><strong>작성일:</strong> ${comment.createdAt}</div>
                        <div><strong>SEQ:</strong> ${comment.seq}</div>
                        <button type="button" class="btn btn-outline-danger btn-sm report-btn" data-comment-id="${comment.seq}">신고</button>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div> 
</div>

<!-- 신고 모달 -->
<jsp:include page="report-modal.jsp" />

<script>
//서버 데이터를 JavaScript 변수로 전달
const contextPath = '${pageContext.request.contextPath}';
const billId = '${bill.billId}';

console.log('=== 페이지 로딩 시 변수 확인 ===');
console.log('contextPath:', contextPath);
console.log('billId:', billId);

document.addEventListener('DOMContentLoaded', function() {  
  const commentSubmit = document.getElementById('commentSubmit'); 
  const commentInput = document.getElementById('exampleFormControlTextarea1');
  const charCount = document.getElementById('charCount'); 
  const commentList = document.getElementById('commentList'); 

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
              billId: parseInt(billId),
              content: content,
              side: window.voteside
          })
      })
      .then(res => {
          console.log('응답 상태:', res.status);
          return res.text();
      })
      .then(text => {
          console.log('서버 응답 원본:', text);
          const data = JSON.parse(text);
          return data;
      })
      .then(data => {
          console.log('=== 서버 응답 ===');
          console.log('전체 응답:', data);
          
          if (data.success && data.comment) { 
              const comment = data.comment;
              console.log('댓글 데이터:', comment);
              
              // 기존 "아직 댓글이 없습니다" 메시지 제거
              const emptyMessage = commentList.querySelector('div[style*="text-align: center"]');
              if (emptyMessage) {
                  emptyMessage.remove();
                  console.log('빈 메시지 제거됨');
              }
              
              // 새 댓글 요소 생성 (기존 댓글과 동일한 스타일)
              const commentItem = document.createElement('div');
              commentItem.style.cssText = `
                  border: 3px solid blue !important;
                  background-color: lightyellow !important;
                  padding: 20px !important;
                  margin: 15px 0 !important;
                  display: block !important;
                  visibility: visible !important;
                  opacity: 1 !important;
              `;
              
              // 기존 댓글과 동일한 HTML 구조
              commentItem.innerHTML = `
                  <div><strong>댓글 #NEW</strong></div>
                  <div><strong>사용자:</strong> ${comment.userId}</div>
                  <div><strong>측면:</strong> ${comment.side}</div>
                  <div><strong>내용:</strong> ${comment.content}</div>
                  <div><strong>작성일:</strong> ${comment.createdAt}</div>
                  <div><strong>SEQ:</strong> ${comment.seq}</div>
                  <button type="button" class="btn btn-outline-danger btn-sm report-btn" data-comment-id="${comment.seq}">신고</button>
              `;
              
              console.log('=== 댓글 요소 생성 완료 ===');
              console.log('생성된 요소:', commentItem);
              console.log('innerHTML:', commentItem.innerHTML);
              
              // h4 "댓글 목록" 다음에 추가
              const h4Element = commentList.querySelector('h4');
              if (h4Element) {
                  // h4 다음에 삽입
                  h4Element.insertAdjacentElement('afterend', commentItem);
                  console.log('h4 다음에 댓글 추가됨');
              } else {
                  // h4가 없으면 맨 앞에 추가
                  commentList.insertBefore(commentItem, commentList.firstChild);
                  console.log('맨 앞에 댓글 추가됨');
              }
              
              console.log('댓글 추가 후 commentList 자식 수:', commentList.children.length);
              
              // 스크롤을 해당 요소로 이동
              commentItem.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
              
              // 입력 필드 초기화
              commentInput.value = ''; 
              charCount.textContent = '0/1000';
              
              alert('댓글이 성공적으로 등록되었습니다!');
               
          } else {
              console.error('댓글 등록 실패:', data);
              alert(data.message || '댓글 작성 실패');
          }
      })
      .catch(error => {
          console.error('Error:', error);
          alert('댓글 등록 중 오류가 발생했습니다: ' + error.message);
      });
  });

  // 신고 버튼 이벤트 위임
  commentList?.addEventListener('click', function(e) {
      if (e.target.classList.contains('report-btn')) {
          const commentId = e.target.getAttribute('data-comment-id');
          console.log('신고 버튼 클릭:', commentId);
      }
  });
});
</script>