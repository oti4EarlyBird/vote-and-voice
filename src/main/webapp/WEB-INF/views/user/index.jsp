<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
				<%@include file="./common/nav.jsp"%>
				<div class="container-xxl flex-grow-1 container-p-y">
					<!-- 
               <h4 class="fw-bold py-3 mb-4">
                  <span class="text-muted fw-light">MAIN /</span>
               </h4>
-->            
            <jsp:include page="./mainImage.jsp"></jsp:include>
				</div>
				<%@include file="./common/footer.jsp"%>
			</div>
		</div>
	</div>



	<%@include file="../commons/jsConf.jsp"%>
</body>
</html>
