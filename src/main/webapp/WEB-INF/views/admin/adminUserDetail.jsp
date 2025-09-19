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
<script
	src="${pageContext.request.contextPath}/resources/assets/js/config.js"></script>
</head>
<body>
	<%@ include file="../commons/aside.jsp"%>
	<%@ include file="../commons/navbar.jsp"%>
	<!-- Layout wrapper -->
	<div class="layout-wrapper layout-content-navbar">
		<div class="layout-container">
			<div class="layout-page">
				<div class="content-wrapper">
					<!-- Content -->
					<div class="container-xxl flex-grow-1 container-p-y">
						<h4 class="fw-bold py-3 mb-4">
							<span class="text-muted fw-light">사용자 /</span> 상세 보기
						</h4>

						<!-- 법안 상세 정보 카드 -->
						<div class="card mb-4">
							<div
								class="card-header d-flex justify-content-between align-items-center">
								<h5 class="mb-0">${billBoardDetail.title}</h5>
								<a href="${pageContext.request.contextPath}/admin/userList"
									class="btn btn-secondary"> <i class="bx bx-list-ul me-1"></i>
									목록으로
								</a>
							</div>
							<div class="card-body">
								<div class="row">
									<div class="col-md-6 mb-3">
										<label class="form-label fw-bold">사용자명</label>
										<p class="form-control-plaintext">${userDetail.name}</p>
									</div>
									<div class="col-md-6 mb-3">
										<label class="form-label fw-bold">아이디</label>
										<p class="form-control-plaintext">
											<span class="badge bg-label-primary me-1">${UserDetail.id}</span>
										</p>
									</div>
									<div class="col-md-6 mb-3">
										<label class="form-label fw-bold">이메일</label>
										<p class="form-control-plaintext">${userDetail.email}</p>
									</div>
									<div class="col-md-6 mb-3">
										<label class="form-label fw-bold">가입일</label>
										<p class="form-control-plaintext">${userDetail.signupDate}</p>
									</div>
									<hr class="my-4">
									<div class="col-12 mb-3">
										<label class="form-label fw-bold">사용자 제재</label>
										<div class="d-flex flex-wrap gap-2">
											<a href="${billBoardDetail.relatedUrl}" target="_blank"
												class="btn btn-sm btn-info">
												<i class="bx bx-link me-1"></i>탈퇴
											</a>
										</div>
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
		</div>
		<!-- Overlay -->
		<div class="layout-overlay layout-menu-toggle"></div>
	</div>
	<!-- / Layout wrapper -->

	<%@include file="../commons/jsConf.jsp"%>

</body>
</html>