<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko" class="light-style" dir="ltr" data-theme="theme-default"
	data-assets-path="resources/assets/"
	data-template="vertical-menu-template-free">
<head>
<meta charset="UTF-8" />
<!-- 반응형 웹페이지 -->
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />

<title>Vote&Voice</title>
<!-- Sneat 템플릿 CSS -->
<%@ include file="../commons/cssConf.jsp"%>

</head>
<body>
	<c:set var="loginUser" value="${sessionScope.loginUser }" />
	
	<div class="layout-wrapper layout-content-navbar">
		<div class="layout-container">
			<div class="layout-page">
				<!-- 상단 NavBar -->
				<nav class="navbar navbar-expand-xl navbar-light bg-white shadow-sm">
					<div class="container-fluid d-flex align-items-center">

						<!-- 토글 버튼 -->
						<button class="navbar-toggler me-3" type="button"
							data-bs-toggle="collapse"
							data-bs-target="#navbarSupportedContent"
							aria-controls="navbarSupportedContent" aria-expanded="false"
							aria-label="Toggle navigation">
							<span class="navbar-toggler-icon"></span>
						</button>

						<!-- 브랜드 로고 -->
						<a class="navbar-brand fw-bold text-primary" href="index.jsp">vote&voice</a>

						<!-- 오른쪽 Login/Register 버튼 (항상 우측 상단 고정) -->
						<div class="d-flex d-xl-none ms-auto align-items-center">
							<button class="btn btn-primary ms-2" type="button">
								<i class="bx bx-log-in"></i>
							</button>
						</div>

						<!-- 메뉴 항목 (Collapse) -->
						<div class="collapse navbar-collapse justify-content-between"
							id="navbarSupportedContent">

							<ul class="navbar-nav me-auto mb-2 mb-xl-0">
								<li class="nav-item"><a class="nav-link" href="#">Home</a></li>
								<li class="nav-item"><a class="nav-link" href="#">의안</a></li>
								<li class="nav-item"><a class="nav-link" href="#">커뮤니티</a></li>
								<li class="nav-item"><a class="nav-link" href="#">공지사항</a></li>
								<li class="nav-item"><a class="nav-link" href="#">Contact
										us</a></li>
								<li class="nav-item dropdown"><a
									class="nav-link dropdown-toggle" href="#" id="pagesDropdown"
									role="button" data-bs-toggle="dropdown" aria-expanded="false">Pages</a>
									<ul class="dropdown-menu" aria-labelledby="pagesDropdown">
										<li><a class="dropdown-item" href="#">Page 1</a></li>
										<li><a class="dropdown-item" href="#">Page 2</a></li>
									</ul></li>
								<li class="nav-item"><a class="nav-link" href="#">Admin</a></li>
							</ul>

							<!-- 큰 화면용 버튼 (xl 이상일 때만 보임) -->
							<div class="d-none d-xl-flex">
									<button class="btn btn-primary ms-3" type="button">Login/Register</button>								

							</div>
						</div>
						
					</div>
				</nav>
			</div>
		</div>
	</div>
	<!-- 푸터 -->
	<footer class="bg-dark text-light py-4">
		<div class="container text-center">
			<p class="mb-1">© 2025 내 블로그 | Powered by Sneat</p>
			<div>
				<a href="#" class="text-light me-3">GitHub</a> <a href="#"
					class="text-light me-3">Instagram</a> <a href="#"
					class="text-light">Email</a>
			</div>
		</div>
	</footer>
	<%@include file="../commons/jsConf.jsp"%>
</body>
</html>
