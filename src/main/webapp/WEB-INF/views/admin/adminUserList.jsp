<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>

<!-- =========================================================
* Sneat - Bootstrap 5 HTML Admin Template - Pro | v1.0.0
==============================================================

* Product Page: https://themeselection.com/products/sneat-bootstrap-html-admin-template/
* Created by: ThemeSelection
* License: You must have a valid license purchased in order to legally use the theme for your project.
* Copyright ThemeSelection (https://themeselection.com)

=========================================================
 -->
<!-- beautify ignore:start -->
<html lang="en" class="light-style layout-menu-fixed" dir="ltr"
	data-theme="theme-default" data-assets-path="../assets/"
	data-template="vertical-menu-template-free">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />

<title>관리자 법안 게시판 관리 페이지</title>

<meta name="description" content="" />
<%@ include file="../commons/cssConf.jsp"%>
<script src="${pageContext.request.contextPath}/resources/assets/js/config.js"></script>
</head>
<body>
	<%@ include file="../commons/aside.jsp"%>
	<%@ include file="../commons/navbar.jsp"%>
	<!-- Layout wrapper -->
				<div class="menu-inner-shadow"></div>

				<!-- Content wrapper -->
				<div class="content-wrapper">
					<!-- Content -->

					<div class="container-xxl flex-grow-1 container-p-y">
						<h4 class="fw-bold py-3 mb-4">
							회원 관리
						</h4>
						<!-- Basic Bootstrap Table -->
						<div class="card">
							<h5 class="card-header d-flex justify-content-between align-items-center">
								<span id="totalCount">Total ${pageDTO.totalCnt}명</span>
							</h5>
							<div class="table-responsive text-nowrap">
								<table class="table">
									<thead>
										<tr>
											<th>번호</th>
											<th>아이디</th>
											<th>성명</th>
											<th>이메일</th>
											<th>생년월일</th>
											<th>가입일</th>
											<th></th>
										</tr>
									</thead>
									<tbody id="noticeTableBody">
										<c:forEach var="user" items="${userList}">
											<tr>
												<td>
													<strong>${user.userSeq}</strong>
												</td>
												<td>
													<span class="badge bg-label-primary me-1">${user.userId}</span>
												</td>
												<td>
													<strong>${user.name}</strong>
												</td>
												<td>
													<span class="badge bg-label-primary me-1">${user.email}</span>
												</td>
												<td>
													<fmt:formatDate value="${user.birthDate}" pattern="yyyy-MM-dd" />
												</td>
												<td>${user.signupDate}</td>
												<td>
													<a class="dropdown-item delete-btn" href="javascript:void(0);"
													data-user-seq="${user.userSeq}">
														<i class="bx bx-trash me-1"></i> 탈퇴
													</a>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
						
						<div class="demo-inline-spacing">
							<!-- Basic Pagination -->
							<nav aria-label="Page navigation">
								<ul class="pagination justify-content-center">
									<!-- '이전' 페이지 그룹으로 이동 -->
									<c:if test="${pageDTO.pageNum > 1}">
										<li class="page-item prev"><a class="page-link"
											href="?page=${pageDTO.pageNum - 1}"><i
												class="tf-icon bx bx-chevron-left"></i></a></li>
									</c:if>

									<!-- 'paginationStart' 값이 0일 경우 1로 시작하도록 보정 -->
									<c:set var="beginPage" value="${pageDTO.paginationStart eq 0 ? 1 : pageDTO.paginationStart}" />

									<c:forEach var="i" begin="${beginPage}" end="${pageDTO.paginationEnd}">
										<li class="page-item ${i == pageDTO.pageNum ? 'active' : ''}">
											<a class="page-link" href="?page=${i}">${i}</a></li>
									</c:forEach>
									
									<c:if test="${pageDTO.pageNum < pageDTO.endPage }">
										<li class="page-item next"><a class="page-link" href="?page=${pageDTO.pageNum + 1}"><i
												class="tf-icon bx bx-chevron-right"></i></a></li>
									</c:if>
								</ul>
							</nav>
							<!--/ Basic Pagination -->
						</div>

					</div>
						<div class="card-body">
					<div class="content-backdrop fade"></div>
				</div>
				<!-- Content wrapper -->
			</div>
			<!-- / Layout page -->
		</div>

		<!-- Overlay -->
		<div class="layout-overlay layout-menu-toggle"></div>
	</div>
	<!-- / Layout wrapper -->
	
	<!-- jQuery를 먼저 로드해야 합니다. -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<%@include file="../commons/jsConf.jsp"%>
	
	<script type="text/javascript">
	$(document).ready(function() {
	    // 삭제 버튼 클릭 이벤트 핸들러
	    $('.delete-btn').on('click', function(e) {
	        e.preventDefault();

	        // user-seq 속성에서 ID 값 가져오기
	        var userSeq = $(this).data('userSeq');
	        console.log("User delete button clicked. userSeq: " + userSeq);
	        
	        // 관리자에게 탈퇴 확인 받기
	        if (confirm("정말로 이 사용자를 탈퇴하시겠습니까?")) {
	            // AJAX를 사용하여 삭제 요청 보내기
	            $.ajax({
	                url: '${pageContext.request.contextPath}/admin/userDelete', // 삭제를 처리할 컨트롤러 URL
	                type: 'POST',
	                data: { userSeq: userSeq },
	                success: function(response) {
	                    if (response.result === 'success') {
	                        // 성공 메시지 표시 및 페이지 새로고침
	                        alert('회원이 성공적으로 탈퇴되었습니다.');
	                        location.reload();
	                    } else {
	                        alert('회원 탈퇴에 실패했습니다.');
	                    }
	                },
	                error: function(xhr, status, error) {
	                    alert('서버 오류로 인해 탈퇴에 실패했습니다.');
	                    console.error("탈퇴 실패:", status, error);
	                }
	            });
	        }
	    });
	});
	</script>
</body>
</html>