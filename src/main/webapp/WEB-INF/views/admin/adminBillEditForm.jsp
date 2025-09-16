<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

<title>관리자 법안 게시글 수정 페이지</title>

<meta name="description" content="" />
<%@ include file="../commons/cssConf.jsp"%>
<script src="${pageContext.request.contextPath}/resources/assets/js/config.js"></script>
</head>
<body>
	<%@ include file="../commons/aside.jsp"%>
	<%@ include file="../commons/navbar.jsp"%>
	<!-- Layout wrapper -->
	<div class="layout-wrapper layout-content-navbar">
		<div class="layout-container">
			<!-- Layout page -->
			<div class="layout-page">
				<div class="content-wrapper">
					<!-- Content -->

					<div class="container-xxl flex-grow-1 container-p-y">
						<h4 class="fw-bold py-3 mb-4">
							<span class="text-muted fw-light">법안 게시판 /</span> 게시글 수정
						</h4>
						
						<!-- Basic Layout -->
						<div class="row">
							<div class="col-xl">
								<div class="card mb-4">
									<div
										class="card-header d-flex justify-content-between align-items-center">
										<!-- 법안 조회하기 버튼은 수정 페이지에서는 필요 없으므로 제거 -->
										<h5 class="mb-0">법안 게시글 수정</h5>
									</div>
									
									<div class="card-body">
										<form action="${pageContext.request.contextPath}/admin/billUpdate" method="post">
											<!-- billboardId를 전송하기 위한 hidden input -->
											<input type="hidden" name="billboardId" value="${billBoard.billboardId}" />
											
											<!-- 이 부분은 수정 불가 -->
											<div class="mb-3">
												<label class="form-label" for="basic-default-fullname">법안명</label>
												<input type="text" class="form-control"
													id="basic-default-fullname" name="title" value="${billBoard.title}" readonly/>
											</div>
											<div class="mb-3">
												<label class="form-label" for="basic-default-company">의안번호</label>
												<input type="text" class="form-control"
													id="basic-default-company" name="billNumber" value="${billBoard.billNumber}" readonly/>
											</div>
											<div class="mb-3">
												<label class="form-label" for="basic-default-email">관련
													URL</label>
												<div class="input-group input-group-merge">
													<input type="text" class="form-control"
														id="basic-default-url" name="relatedUrl" value="${billBoard.relatedUrl}" readonly/>
												</div>
											</div>
											<div class="mb-3">
												<label class="form-label" for="basic-default-committee">소관위원회</label>
												<input type="text" class="form-control"
													id="basic-default-committee" name="committee" value="${billBoard.committee}" readonly/>
											</div>
											
											<!-- 이 부분만 수정 가능 -->
											<div class="mb-3">
												<label class="form-label" for="basic-default-message">자세한 설명</label>
												<textarea id="basic-default-message" class="form-control"
													name="content" placeholder="ex)이 ㅇㅇ법 일부개정법률안은  ~~한 목적으로 입안되었습니다.">${billBoard.content}</textarea>
											</div>

											<button type="submit" class="btn btn-primary">수정</button>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- / Content -->

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
</body>
</html>
