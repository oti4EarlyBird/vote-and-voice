<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko" class="light-style" dir="ltr" data-theme="theme-default"
	data-assets-path="resources/assets/"
	data-template="vertical-menu-template-free">
<head>
<meta charset="UTF-8">
<!-- 반응형 웹페이지 -->
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
<title>User Notice Detail</title>
<!-- Sneat 템플릿 CSS -->
<%@ include file="../commons/cssConf.jsp"%>
<style type="text/css">
table, tr, td {
	border: 1px solid #d0d6dd;
	text-align: center;
}
</style>
</head>

<body>
<%@include file="./common/nav.jsp"%>
	<div class="layout-wrapper layout-content-navbar">
		<div class="layout-container">
			<div class="layout-page">
				<div class="container-xxl flex-grow-1 container-p-y">
					<h4 class="fw-bold py-3 mb-4">
						<span class="text-muted fw-light">${requestScope.noticeSeq }공지사항 /</span>${noticeDTO.title } 
					</h4>
					
					<div class="card">
						<!-- 작성자 정보 -->
						<div class="card-header">
							<div class="d-flex justify-content-between mb-3 border-bottom pt-3">
								<div>
									<strong>${noticeDTO.writer}</strong>
								</div>
								<div class="text-end">
									<span>조회 : ${noticeDTO.viewnum }</span><br>
									<span>작성일 : <fmt:formatDate value="${noticeDTO.postDate}" pattern="yyyy-MM-dd hh:mm"/> </span>
								</div>
							</div>
						</div>

						<!-- 본문 내용 -->
						<div class="card-body p-4">
						${noticeDTO.content }
						</div>
						
						
						<!-- 이전글/다음글 -->
						<div class="card-footer mt-5">
							<ul class="list-group rounded-0">
								<li class="list-group-item border-start-0 border-end-0">
									<span class=text-muted fw-light"><i class="bx bx-chevron-up"></i>이전글</span>
									${prevNotice.title }</li>
								<li class="list-group-item border-start-0 border-end-0">
									<span class=text-muted fw-light"><i class="bx bx-chevron-down"></i>다음글</span>
									${nextNotice.title }
								</li>
							</ul>
						</div>
						
					</div>  <!-- card -->



					
					
					
					
					
					
				</div>	
				
			</div>
		</div>
	</div>



	<%@include file="./common/footer.jsp"%>
<%@include file="../commons/jsConf.jsp"%>
</body>
</html>