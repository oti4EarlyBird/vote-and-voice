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
    <div id="commentList">
        <h4>댓글 목록( ${comments.size()}개 )</h4>
        <hr>
        
        <c:choose>
            <c:when test="${empty comments}">
                <div style="text-align: center; color: #888; padding: 20px;">
                    	아직 댓글이 없습니다. 첫 번째 댓글을 작성해보세요!
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="comment" items="${comments}" varStatus="status">
                    <div style="padding: 10px; margin: 10px 0;">
                        <div><strong>${comment.userId}</strong> </div>
                        <div><strong>${comment.side}</strong> </div>
                        <div> ${comment.content}</div>
                        <div>${comment.createdAt}</div>
                        <button type="button" class="btn btn-outline-danger btn-sm report-btn" data-comment-id="${comment.seq}">신고</button>
                    	<hr>
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
                  padding: 10px !important;
                  margin: 10px 0 !important;
                  display: block !important;
                  visibility: visible !important;
                  opacity: 1 !important;
              `;
	            const userId = comment.userId || '알 수 없음';
	            const content = comment.content || '내용 없음';
	            const side = comment.side || '미정';
	            const createdAt = comment.createdAt || '날짜 없음';
	            const seq = comment.seq || '0';
              // 기존 댓글과 동일한 HTML 구조
              commentItem.innerHTML = 
                  '<div><strong>'+userId+'</strong></div>' +
                  '<div><strong>'+side+'</strong></div>' +
                  '<div>' + content + '</div>' +
                  '<div>' + createdAt + '</div>' +
                  '<button type="button" class="btn btn-outline-danger btn-sm report-btn" data-comment-id="' + seq + '">신고</button>';
              
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