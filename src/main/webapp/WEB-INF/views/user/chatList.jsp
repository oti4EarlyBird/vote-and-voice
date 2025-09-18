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
<title>Insert title here</title>

<!-- Sneat 템플릿 CSS -->
<%@ include file="../commons/cssConf.jsp"%>
</head>
<body>

	<div class="layout-wrapper layout-content-navbar">
		<div class="layout-container">
			<div class="layout-page">
	<%@include file="./common/nav.jsp"%>
				<div class="container-xxl flex-grow-1 container-p-y">
					<h4 class="fw-bold py-3 mb-4">
						<span class="text-muted fw-light">Community /</span>
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
									<a href="?category=소식"
										class="btn btn-sm btn-outline-primary <c:if test='${param.category == "소식"}'>active</c:if>'">소식</a>
									<a href="?category=공지"
										class="btn btn-sm btn-outline-primary <c:if test='${param.category == "공지"}'>active</c:if>'">공지</a>
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
										<tr>
											<th>Project</th>
											<th>Client</th>
											<th>Date</th>
											<th>Status</th>
											<th>Actions</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td><span class="badge bg-primary me-2">공지</span> <strong>Angular
													Project</strong></td>
											<td>Albert Cook</td>
											<td>2025.09.15 ~ 2025.09.31</td>
											<td><span class="badge bg-label-primary me-1">Active</span></td>
											<td>
												<a href="/user/chat/room/${chatRoomId}" class="btn btn-primary btn-sm">입장</a>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<!--/ Bordered Table -->
						<!-- 페이징 -->
						<div class="demo-inline-spacing">
							<!-- Basic Pagination -->
							<nav aria-label="Page navigation">
								<ul class="pagination justify-content-center">
									<li class="page-item first"><a class="page-link"
										href="javascript:void(0);"><i
											class="tf-icon bx bx-chevrons-left"></i></a></li>
									<li class="page-item prev"><a class="page-link"
										href="javascript:void(0);"><i
											class="tf-icon bx bx-chevron-left"></i></a></li>
									<li class="page-item"><a class="page-link"
										href="javascript:void(0);">1</a></li>
									<li class="page-item"><a class="page-link"
										href="javascript:void(0);">2</a></li>
									<li class="page-item active"><a class="page-link"
										href="javascript:void(0);">3</a></li>
									<li class="page-item"><a class="page-link"
										href="javascript:void(0);">4</a></li>
									<li class="page-item"><a class="page-link"
										href="javascript:void(0);">5</a></li>
									<li class="page-item next"><a class="page-link"
										href="javascript:void(0);"><i
											class="tf-icon bx bx-chevron-right"></i></a></li>
									<li class="page-item last"><a class="page-link"
										href="javascript:void(0);"><i
											class="tf-icon bx bx-chevrons-right"></i></a></li>
								</ul>
							</nav>
							<!--/ Basic Pagination -->
						</div>
					</div>
				</div>
	<%@include file="./common/footer.jsp"%>
			</div>
		</div>
	</div>


	<%@include file="../commons/jsConf.jsp"%>
</body>
</html>