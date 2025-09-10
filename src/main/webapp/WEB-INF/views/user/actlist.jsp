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
		<div class="btn-container">
			<button type="button" class="btn rounded-pill btn-primary">청년</button>
			<button type="button" class="btn rounded-pill btn-primary">노인</button>
			<button type="button" class="btn rounded-pill btn-primary">복지</button>
			<button type="button" class="btn rounded-pill btn-primary">교육</button>
		</div>

		<!-- 검색 박스 -->
		<div class="card p-3 mb-4">
			<form class="row g-2" action="billList.jsp" method="get">
				<div class="col-md-10">
					<input type="text" name="keyword" class="form-control"
						placeholder="검색어를 입력하세요">
				</div>
				<div class="col-md-2">
					<button type="submit" class="btn btn-primary w-100">검색</button>
				</div>
			</form>
		</div>

		<!-- 목록  -->
		<!-- Hoverable Table rows -->
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
						<tr>
							<td><i class="fab fa-angular fa-lg text-danger me-3"></i> <strong>Angular
									Project</strong></td>
							<td>Albert Cook</td>
							<td>
								<ul
									class="list-unstyled users-list m-0 avatar-group d-flex align-items-center">
									<li data-bs-toggle="tooltip" data-popup="tooltip-custom"
										data-bs-placement="top" class="avatar avatar-xs pull-up"
										title="Lilian Fuller"><img
										src="${pageContext.request.contextPath}/resources/assets/img/avatars/5.png"
										alt="Avatar" class="rounded-circle" /></li>
									<li data-bs-toggle="tooltip" data-popup="tooltip-custom"
										data-bs-placement="top" class="avatar avatar-xs pull-up"
										title="Sophia Wilkerson"><img
										src="${pageContext.request.contextPath}/resources/assets/img/avatars/6.png"
										alt="Avatar" class="rounded-circle" /></li>
									<li data-bs-toggle="tooltip" data-popup="tooltip-custom"
										data-bs-placement="top" class="avatar avatar-xs pull-up"
										title="Christina Parker"><img
										src="${pageContext.request.contextPath}/resources/assets/img/avatars/7.png"
										alt="Avatar" class="rounded-circle" /></li>
								</ul>
							</td>
							<td><span class="badge bg-label-primary me-1">Active</span></td>
							<td>
								<div class="dropdown">
									<button type="button"
										class="btn p-0 dropdown-toggle hide-arrow"
										data-bs-toggle="dropdown">
										<i class="bx bx-dots-vertical-rounded"></i>
									</button>
									<div class="dropdown-menu">
										<a class="dropdown-item" href="javascript:void(0);"><i
											class="bx bx-edit-alt me-1"></i> Edit</a> <a
											class="dropdown-item" href="javascript:void(0);"><i
											class="bx bx-trash me-1"></i> Delete</a>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<td><i class="fab fa-react fa-lg text-info me-3"></i> <strong>React
									Project</strong></td>
							<td>Barry Hunter</td>
							<td>
								<ul
									class="list-unstyled users-list m-0 avatar-group d-flex align-items-center">
									<li data-bs-toggle="tooltip" data-popup="tooltip-custom"
										data-bs-placement="top" class="avatar avatar-xs pull-up"
										title="Lilian Fuller"><img
										src="${pageContext.request.contextPath}/resources/assets/img/avatars/5.png"
										alt="Avatar" class="rounded-circle" /></li>
									<li data-bs-toggle="tooltip" data-popup="tooltip-custom"
										data-bs-placement="top" class="avatar avatar-xs pull-up"
										title="Sophia Wilkerson"><img
										src="${pageContext.request.contextPath}/resources/assets/img/avatars/6.png"
										alt="Avatar" class="rounded-circle" /></li>
									<li data-bs-toggle="tooltip" data-popup="tooltip-custom"
										data-bs-placement="top" class="avatar avatar-xs pull-up"
										title="Christina Parker"><img
										src="${pageContext.request.contextPath}/resources/assets/img/avatars/7.png"
										alt="Avatar" class="rounded-circle" /></li>
								</ul>
							</td>
							<td><span class="badge bg-label-success me-1">Completed</span></td>
							<td>
								<div class="dropdown">
									<button type="button"
										class="btn p-0 dropdown-toggle hide-arrow"
										data-bs-toggle="dropdown">
										<i class="bx bx-dots-vertical-rounded"></i>
									</button>
									<div class="dropdown-menu">
										<a class="dropdown-item" href="javascript:void(0);"><i
											class="bx bx-edit-alt me-1"></i> Edit</a> <a
											class="dropdown-item" href="javascript:void(0);"><i
											class="bx bx-trash me-1"></i> Delete</a>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<td><i class="fab fa-vuejs fa-lg text-success me-3"></i> <strong>VueJs
									Project</strong></td>
							<td>Trevor Baker</td>
							<td>
								<ul
									class="list-unstyled users-list m-0 avatar-group d-flex align-items-center">
									<li data-bs-toggle="tooltip" data-popup="tooltip-custom"
										data-bs-placement="top" class="avatar avatar-xs pull-up"
										title="Lilian Fuller"><img
										src="${pageContext.request.contextPath}/resources/assets/img/avatars/5.png"
										alt="Avatar" class="rounded-circle" /></li>
									<li data-bs-toggle="tooltip" data-popup="tooltip-custom"
										data-bs-placement="top" class="avatar avatar-xs pull-up"
										title="Sophia Wilkerson"><img
										src="${pageContext.request.contextPath}/resources/assets/img/avatars/6.png"
										alt="Avatar" class="rounded-circle" /></li>
									<li data-bs-toggle="tooltip" data-popup="tooltip-custom"
										data-bs-placement="top" class="avatar avatar-xs pull-up"
										title="Christina Parker"><img
										src="${pageContext.request.contextPath}/resources/assets/img/avatars/7.png"
										alt="Avatar" class="rounded-circle" /></li>
								</ul>
							</td>
							<td><span class="badge bg-label-info me-1">Scheduled</span></td>
							<td>
								<div class="dropdown">
									<button type="button"
										class="btn p-0 dropdown-toggle hide-arrow"
										data-bs-toggle="dropdown">
										<i class="bx bx-dots-vertical-rounded"></i>
									</button>
									<div class="dropdown-menu">
										<a class="dropdown-item" href="javascript:void(0);"><i
											class="bx bx-edit-alt me-1"></i> Edit</a> <a
											class="dropdown-item" href="javascript:void(0);"><i
											class="bx bx-trash me-1"></i> Delete</a>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<td><i class="fab fa-bootstrap fa-lg text-primary me-3"></i>
								<strong>Bootstrap Project</strong></td>
							<td>Jerry Milton</td>
							<td>
								<ul
									class="list-unstyled users-list m-0 avatar-group d-flex align-items-center">
									<li data-bs-toggle="tooltip" data-popup="tooltip-custom"
										data-bs-placement="top" class="avatar avatar-xs pull-up"
										title="Lilian Fuller"><img
										src="${pageContext.request.contextPath}/resources/assets/img/avatars/5.png"
										alt="Avatar" class="rounded-circle" /></li>
									<li data-bs-toggle="tooltip" data-popup="tooltip-custom"
										data-bs-placement="top" class="avatar avatar-xs pull-up"
										title="Sophia Wilkerson"><img
										src="${pageContext.request.contextPath}/resources/assets/img/avatars/6.png"
										alt="Avatar" class="rounded-circle" /></li>
									<li data-bs-toggle="tooltip" data-popup="tooltip-custom"
										data-bs-placement="top" class="avatar avatar-xs pull-up"
										title="Christina Parker"><img
										src="${pageContext.request.contextPath}/resources/assets/img/avatars/7.png"
										alt="Avatar" class="rounded-circle" /></li>
								</ul>
							</td>
							<td><span class="badge bg-label-warning me-1">Pending</span></td>
							<td>
								<div class="dropdown">
									<button type="button"
										class="btn p-0 dropdown-toggle hide-arrow"
										data-bs-toggle="dropdown">
										<i class="bx bx-dots-vertical-rounded"></i>
									</button>
									<div class="dropdown-menu">
										<a class="dropdown-item" href="javascript:void(0);"><i
											class="bx bx-edit-alt me-1"></i> Edit</a> <a
											class="dropdown-item" href="javascript:void(0);"><i
											class="bx bx-trash me-1"></i> Delete</a>
									</div>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<!--/ Hoverable Table rows -->

		<!-- 페이징 -->
		<nav aria-label="Page navigation" class="mt-4">
			<ul class="pagination justify-content-center">

				<!-- 이전 버튼 -->
				<li class="page-item ${currentPage == 1 ? 'disabled' : 'prev'}">
					<a class="page-link" href="?page=${currentPage - 1}"
					aria-label="Previous"> <i class="tf-icon bx bx-chevrons-left"></i>
				</a>
				</li>

				<!-- 페이지 번호 -->
				<c:forEach var="i" begin="1" end="${totalPages}">
					<li class="page-item ${i == currentPage ? 'active' : ''}"><a
						class="page-link" href="?page=${i}">${i}</a></li>
				</c:forEach>

				<!-- 다음 버튼 -->
				<li
					class="page-item ${currentPage == totalPages ? 'disabled' : 'next'}">
					<a class="page-link" href="?page=${currentPage + 1}"
					aria-label="Next"> <i class="tf-icon bx bx-chevrons-right"></i>
				</a>
				</li>

			</ul>
		</nav>

	</div>

	<!-- Footer -->
	<%@include file="./common/footer.jsp"%>
	<%@include file="../commons/jsConf.jsp"%>

</body>
</html>
