<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en" class="light-style" dir="ltr" data-theme="theme-default"
	data-assets-path="${pageContext.request.contextPath}/resources/assets/"
	data-template="vertical-menu-template-free">

<head>
<meta charset="utf-8" />
<title>의안 정보</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<%@ include file="../commons/cssConf.jsp"%>
</head>

<body>

	<!-- Header -->
	<%@include file="./common/nav.jsp"%>

	<!-- Main Content -->
	<div class="container-xxl flex-grow-1 container-p-y">
		<h4 class="fw-bold mb-4">의안 검색</h4>

		<!-- ✅ 카테고리 버튼 수정 -->
		<div class="btn-container mb-3">
			<a href="?category=all" class="btn rounded-pill btn-primary ${param.category eq 'all' ? 'active' : ''}">전체</a>
			<a href="?category=청년" class="btn rounded-pill btn-primary ${param.category eq '청년' ? 'active' : ''}">청년</a>
			<a href="?category=노인" class="btn rounded-pill btn-primary ${param.category eq '노인' ? 'active' : ''}">노인</a>
			<a href="?category=복지" class="btn rounded-pill btn-primary ${param.category eq '복지' ? 'active' : ''}">복지</a>
			<a href="?category=교육" class="btn rounded-pill btn-primary ${param.category eq '교육' ? 'active' : ''}">교육</a>
		</div>

		<!-- 검색 박스 -->
		<div class="card p-3 mb-4">
			<form class="row g-2" action="${pageContext.request.contextPath}/user/actlist" method="get">
				<div class="col-md-10">
					<input type="text" name="keyword" class="form-control"
						placeholder="검색어를 입력하세요">
				</div>
				<div class="col-md-2">
					<button type="submit" class="btn btn-primary w-100">검색</button>
				</div>
			</form>
		</div>

		<!-- ✅ 목록 테이블 수정 -->
		<div class="card">
			<h5 class="card-header">의안 정보</h5>
			<div class="table-responsive text-nowrap">
				<table class="table table-hover">
					<thead>
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>의안번호</th>
							<th>소관위원회</th>
							<th>본회의 의결결과</th>
							<th>본회의 의결일</th>
						</tr>
					</thead>
					<tbody class="table-border-bottom-0">
						<c:forEach var="act" items="${list}">
							<tr style="cursor:pointer"
								onclick="location.href='${pageContext.request.contextPath}/user/actdetail/${act.billboardId}'">
								<td>${act.billboardId}</td>
								<td>${act.title}</td>
								<td>${act.billNumber}</td>
								<td>${act.committee}</td>
								<td>${act.decisionResult}</td>
								<td>${act.decisionDate}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>

		<!-- ✅ 페이징 수정 -->
		<div class="demo-inline-spacing mt-4">
			<nav aria-label="Page navigation">
				<ul class="pagination justify-content-center">
					<c:if test="${pageDTO.pageNum != pageDTO.paginationStart }">
						<li class="page-item prev">
							<a class="page-link"
								href="?page=${pageDTO.paginationStart}&category=${param.category}">
								<i class="tf-icon bx bx-chevron-left"></i>
							</a>
						</li>
					</c:if>
				<c:if test="${not empty pageDTO and pageDTO.paginationStart > 0}">
					<c:forEach var="i" begin="${pageDTO.paginationStart}" end="${pageDTO.paginationEnd}">
						<li class="page-item ${i==pageDTO.pageNum?'active':''}">
							<a class="page-link" href="?page=${i}&category=${param.category}">${i}</a>
						</li>
					</c:forEach>
				</c:if>
					<c:if test="${pageDTO.pageNum != pageDTO.paginationEnd }">
						<li class="page-item next">
							<a class="page-link"
								href="?page=${pageDTO.paginationEnd}&category=${param.category}">
								<i class="tf-icon bx bx-chevron-right"></i>
							</a>
						</li>
					</c:if>
				</ul>
			</nav>
		</div>

	</div>

	<!-- Footer -->
	<%@include file="./common/footer.jsp"%>
	<%@include file="../commons/jsConf.jsp"%>

</body>
</html>
