<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
</head>

<body>
<%@include file="./common/nav.jsp"%>
	<div class="layout-wrapper layout-content-navbar">
		<div class="layout-container">
			<div class="layout-page">
				<div class="container-xxl flex-grow-1 container-p-y">
					<h4 class="fw-bold py-3 mb-4">
						<span class="text-muted fw-light">공지사항 /</span> [수주] 2025년 가족관계등록 자료정비 사업 수주
					</h4>
					
					<div class="card">
						<!-- 작성자 정보 -->
						<div class="card-header">
							<div class="d-flex justify-content-between mb-3 border-bottom pt-3">
								<div>
									<strong>최고관리자</strong>
								</div>
								<div class="text-end">
									<span>조회 : 1408회</span><br>
									<span>작성일 : 25-01-06 12:24</span>
								</div>
							</div>
						</div>

						<!-- 본문 내용 -->
						<div class="card-body p-4">
						hhhh
						</div>
						
						
						<!-- 이전글/다음글 -->
						<div class="card-footer mt-5">
							<ul class="list-group rounded-0">
								<li class="list-group-item border-start-0 border-end-0">
									<span class=text-muted fw-light"><i class="bx bx-chevron-up"></i>이전글</span>
									이전글의 제목입니다.</li>
								<li class="list-group-item border-start-0 border-end-0">
									<span class=text-muted fw-light"><i class="bx bx-chevron-down"></i>다음글</span>
									다음글의 제목입니다.
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