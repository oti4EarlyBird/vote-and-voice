<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<title>User Notice</title>
<%@ include file="../commons/cssConf.jsp"%>
</head>
<body>
	<%@include file="./common/nav.jsp"%>




	<div class="layout-wrapper layout-content-navbar">
		<div class="layout-container">
			<div class="layout-page">
				<div class="container-xxl flex-grow-1 container-p-y">
					<h4 class="fw-bold py-3 mb-4">
						<span class="text-muted fw-light">User Notice</span> 공지사항
					</h4>


					<!-- Bordered Table -->
					<div class="card">
						<!-- <h5 class="card-header">Bordered Table</h5> -->

						<div class="card-body">
							<!-- 태그 -->
							<div
								class="d-flex justify-content-between align-items-center mb-3">
								<div class="btn-group" role="group" aria-label="Notice Type">
									<a href="?category=all"
										class="btn btn-sm btn-outline-primary <c:if test='${param.category == "all" || empty param.category}'>active</c:if>'">전체</a>
									<a href="?category=EVENT"
										class="btn btn-sm btn-outline-primary <c:if test='${param.category == "EVENT"}'></c:if>'">EVENT</a>
									<a href="?category=UPDATE"
										class="btn btn-sm btn-outline-primary <c:if test='${param.category == "UPDATE"}'></c:if>'">UPDATE</a>
									<a href="?category=INFO"
										class="btn btn-sm btn-outline-primary <c:if test='${param.category == "INFO"}'></c:if>'">INFO</a>
								</div>

								<!-- 오른쪽 검색창 -->
								<form class="d-flex" action="" method="get">
									<input type="hidden" name="category" value="all" /> <input
										class="form-control form-control-sm me-2" type="search"
										name="keyword" placeholder="검색어 입력" value="${param.keyword}"
										aria-label="Search">
									<button class="btn btn-sm btn-primary" type="submit">
										<i class="tf-icons bx bx-search"></i>
									</button>
								</form>
							</div>

							<!-- 목록 -->
							<div class="table-responsive text-nowrap mt-3">
								<table class="table table-hover">
									<!-- table-bordered -->
									<thead>
										<tr style="text-align: center;">
											<th>번호</th>
											<th>제목</th>
											<th>글쓴이</th>
											<th>조회</th>
											<th>날짜</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="notice" items="${noticeList}">
											
											<tr>
												<td>${notice.seqNotices }</td>
												<td>
													<span class="badge bg-primary me-2">${notice.category}</span> 
													<a href="<c:url value='/user/notice/detail/${notice.seqNotices}' />" style="color: #697a8d"><strong>${notice.title }</strong></a>
												</td>
												<td>${notice.writer }</td>
												<td>${notice.viewnum }</td>
												<td>
													<fmt:formatDate value="${notice.postDate }" pattern="yyyy-MM-dd" />
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
						<!--/ Bordered Table -->

						<%-- 확인 : paginationStart: ${pageDTO.paginationStart}, paginationEnd: ${pageDTO.paginationEnd} --%>
						<!-- 페이징 -->
						<div class="demo-inline-spacing">
							<!-- Basic Pagination -->
							<nav aria-label="Page navigation">
								<ul class="pagination justify-content-center">
									<c:if test="${pageDTO.pageNum != pageDTO.paginationStart }">
										<li class="page-item prev"><a class="page-link"
											href="?page=${pageDTO.paginationStart}&category=${param.category}"><i
												class="tf-icon bx bx-chevron-left"></i></a></li>
									</c:if>
									<c:forEach var="i" begin="${pageDTO.paginationStart}" end="${pageDTO.paginationEnd}">
										<li class="page-item ${i==pageDTO.pageNum?'active':''}">
											<a class="page-link" href="?page=${i}&category=${param.category}">${i}</a></li>
									</c:forEach>
									<c:if test="${pageDTO.pageNum != pageDTO.paginationEnd }">
										<li class="page-item next"><a class="page-link"
											href="?page=${pageDTO.paginationEnd}&category=${param.category}"><i
												class="tf-icon bx bx-chevron-right"></i></a></li>
									</c:if>

								</ul>
							</nav>
							<!--/ Basic Pagination -->
						</div>

					</div>
					<!-- .card -->


				</div>
			</div>
		</div>
	</div>



	<%@include file="./common/footer.jsp"%>
	<%@include file="../commons/jsConf.jsp"%>
	
	

</body>
</html>