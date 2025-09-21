<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
							법안 게시판 리스트
						</h4>

						<!-- Basic Bootstrap Table -->
						<div class="card">
							<h5 class="card-header d-flex justify-content-between align-items-center">
								<span><span style="color: red;"> ${fn:length(billBoardList)}</span> 개의 글이 있습니다.</span>
								<!-- 오른쪽 정렬하기 -->
								<button class="btn btn-primary" onclick="location.href='billWriteForm'">
									작성
								</button>
							</h5>
							
							<div class="table-responsive text-nowrap">
								<table class="table">
									<thead>
										<tr>
											<th>번호</th>
											<th>법안명</th>
											<th>의안번호</th>
											<th>소관위원회</th>
											<th>본회의 의결 결과</th>
											<th>본회의 의결일</th>
											<th>Actions</th>
										</tr>
									</thead>
									<tbody class="table-border-bottom-0">
										<c:forEach var="billBoard" items="${billBoardList}">
											<tr>
												<td>
													<strong>${billBoard.billboardId}</strong>
												</td>
												<td>
													<strong>${billBoard.title}</strong>
												</td>
												<td>
													${billBoard.billNumber}
												</td>
												<td><span class="badge bg-label-primary me-1">${billBoard.committee}</span></td>
												<td>${billBoard.decisionResult}</td>
												<td>${billBoard.decisionDate}</td>
												<td>
													<div class="dropdown">
														<button type="button"
															class="btn p-0 dropdown-toggle hide-arrow"
															data-bs-toggle="dropdown">
															<i class="bx bx-dots-vertical-rounded"></i>
														</button>
														<div class="dropdown-menu">
															<a class="dropdown-item"
																href="${pageContext.request.contextPath}/admin/billEditForm?billboardId=${billBoard.billboardId}"
															>
																<i class="bx bx-edit-alt me-1"></i> 수정
															</a>
															<a class="dropdown-item delete-btn" href="javascript:void(0);"
																data-billboard-id="${billBoard.billboardId}">
																<i class="bx bx-trash me-1"></i> 삭제
															</a>
														</div>
													</div>
												</td>
											</tr>
										</c:forEach>
										<c:if test="${empty billBoardList}">
											<tr>
												<td colspan="7" class="text-center">등록된 법안 게시글이 없습니다.</td>
											</tr>
										</c:if>
									</tbody>
								</table>
							</div>
						</div>

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
	
	<%@include file="../commons/jsConf.jsp"%>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
		$(document).ready(function() {
		    // 삭제 버튼 클릭 이벤트 핸들러
		    $('.delete-btn').on('click', function(e) {
		        e.preventDefault();
	
		        // data-billboard-id 속성에서 ID 값 가져오기
		        var billboardId = $(this).data('billboardId');
		        
		        // 사용자에게 삭제 확인 받기
		        if (confirm("정말로 이 게시글을 삭제하시겠습니까?")) {
		            // AJAX를 사용하여 삭제 요청 보내기
		            $.ajax({
		                url: '${pageContext.request.contextPath}/admin/billDelete', // 삭제를 처리할 컨트롤러 URL
		                type: 'POST',
		                data: { billboardId: billboardId },
		                success: function(response) {
		                    if (response.result === 'success') {
		                        // 성공 메시지 표시 및 페이지 새로고침
		                        alert('게시글이 성공적으로 삭제되었습니다.');
		                        location.reload();
		                    } else {
		                        alert('게시글 삭제에 실패했습니다.');
		                    }
		                },
		                error: function(xhr, status, error) {
		                    alert('서버 오류로 인해 삭제에 실패했습니다.');
		                    console.error("삭제 실패:", status, error);
		                }
		            });
		        }
		    });
		});
	</script>
</body>
</html>