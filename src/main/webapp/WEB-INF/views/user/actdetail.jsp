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
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<%@ include file="../commons/cssConf.jsp"%>
</head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/actdetail.css">

<body>
<!-- Header -->
<%@include file="./common/nav.jsp" %>
	<div class="container-xxl flex-grow-1 container-p-y">
		<div class="row">
			<!-- 좌측 카드 -->
			<div class="col-md-3 mb-4">
				<div class="card mb-3">
					<img class="card-img-top"
						src="${pageContext.request.contextPath}/resources/assets/img/elements/18.jpg"
						alt="Card image cap" />
					<div class="card-body">
						<h5 class="card-title">의안 제목</h5>
						<p class="card-text">의안 내용 요약</p>
						<p class="card-text">
							<button type="button" class="btn btn-primary">자세히 보기</button>
						</p>
					</div>
				</div>
			</div>

			<!-- 우측 의안 상세 카드 -->
			<div class="col-md-8">
				<div class="card p-4 mb-4">
					<!-- 의안 상세 내용 -->
					<jsp:include page="bill-detail.jsp" />
					
					<!-- 찬반 투표 -->
					<jsp:include page="vote-section.jsp" />
					
					<!-- 댓글 -->
					<jsp:include page="comment-section.jsp" />
					
					<div style="text-align: right; margin-top: 20px;">
						<button type="button" class="btn btn-secondary"
							onclick="location.href='${pageContext.request.contextPath}/user/actlist'">
							목록</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Footer -->
	<%@include file="./common/footer.jsp" %>
	<%@include file="../commons/jsConf.jsp"%>
	
</body>
</html>