<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko" class="light-style" dir="ltr" data-theme="theme-default"
	data-assets-path="resources/assets/"
	data-template="vertical-menu-template-free">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
<title>User Mypage</title>
<%@ include file="../commons/cssConf.jsp"%>
</head>
<body>
	<%@include file="./common/nav.jsp"%>

	<!-- Content wrapper -->
	<div class="content-wrapper">
		<!-- Content -->
		<div class="container-xxl flex-grow-1 container-p-y">
			<h4 class="fw-bold py-3 mb-4">
				<span class="text-muted fw-light">마이페이지 / </span> 내 정보 수정
			</h4>
			<div class="row">
				<div class="col-md-12">
					<ul class="nav nav-pills flex-column flex-md-row mb-3">
						<li class="nav-item"><a class="nav-link active"
							href="javascript:void(0);"><i class="bx bx-user me-1"></i>
								Account</a></li>
						<!-- 						<li class="nav-item"><a class="nav-link"
							href="pages-account-settings-notifications.html"><i
								class="bx bx-bell me-1"></i> Notifications</a></li>
						<li class="nav-item"><a class="nav-link"
							href="pages-account-settings-connections.html"><i
								class="bx bx-link-alt me-1"></i> Connections</a></li> -->
					</ul>

					<div id="profileCardContainer">
						<jsp:include page="/WEB-INF/views/user/userAccountProfileCard.jsp"></jsp:include>
					</div>
					
					<!-- 키워드  -->
					<div id="keywordCardContainer">
						<jsp:include page="/WEB-INF/views/user/userAccountKeywordCard.jsp"></jsp:include>
					</div>



					<!-- 계정 삭제 -->
					<div class="card">
						<h5 class="card-header">계정 삭제</h5>
						<div class="card-body">
							<div class="mb-3 col-12 mb-0">
								<div class="alert alert-warning">
									<h6 class="alert-heading fw-bold mb-1">정말로 계정을 삭제하시겠습니까?</h6>
									<p class="mb-0">계정을 삭제하면 복구할 수 없으니 신중히 결정해 주세요.</p>
								</div>
							</div>
							<form id="formAccountDeactivation" onsubmit="return false">
								<div class="form-check mb-3">
									<input class="form-check-input" type="checkbox"
										name="accountActivation" id="accountActivation" /> <label
										class="form-check-label" for="accountActivation"> 계정
										삭제에 동의 합니다.</label>
								</div>
								<button id="AccountDeleteBtn" type="button"
									class="btn btn-danger deactivate-account">Deactivate
									Account</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- / Content -->

	</div>

	<%@include file="./common/footer.jsp"%>
	<%@include file="../commons/jsConf.jsp"%>
	
	
	<script type="text/javascript">
		$(function() {
			$('#passwordCheck').on('input', function(){
				if($('#password').val() !== $(this).val()){
					$('#passwordCheckHelp').show();
				}else {
					$('#passwordCheckHelp').hide();
				}
			});
			
			// 계정 정보 수정 버튼 클릭
			$('#AccountBtn').click(function() {
				alert('계정정보수정버튼 클릭');
				if($('#password').val() === $('#passwordCheck').val()){
					let data = {
							id: $('#id').val(),
							name: $('#name').val(),
							password: $('#password').val(),
							email: $('#email').val(),
							birthday: $('#birthday').val(),
					};
					
					$.ajax({
						url:'${pageContext.request.contextPath}/user/mypage/updateProfile',
						type: 'POST',
						contentType: 'application/json',
						data: JSON.stringify(data),
						success: function(res) {
							alert('프로필 업데이트 성공');
							
							// 프로필 카드 영역 리로드 
							$('#profileCardContainer').load('${pageContext.request.contextPath}/user/mypage/userAccountProfileCard');
						},
						error: function(){
							alert('실패');
						},
							
					});
					
				}else {
					alert('비밀번호가 일치하지 않습니다.');
				}
				
				
				
				
			});
			
			// 관심 키워드 수정 버튼 클릭
			$('#keywordCardContainer').on('click','#AccountKeywordBtn', function() {
				alert('키워드 수정 버튼 클릭');
				let selectedKeyword = [];
				$('input.form-check-input[type=checkbox]:checked').each(function() {
					selectedKeyword.push($(this).attr('name'));
				});
				
				$.ajax({
					url:'${pageContext.request.contextPath}/user/mypage/updateKeyword',
					type: 'POST',
					contentType: 'application/json',
					data: JSON.stringify({keywords: selectedKeyword}),
					success: function(res){
						alert('관심 키워드가 수정되었습니다.');
						
						// 관심 키워드 카드 영역 리로드 : UI갱신
						$('#keywordCardContainer').load('${pageContext.request.contextPath}/user/mypage/userAccountKeywordCard');
					},
					error: function(){
						alert('오류 발생');
					}, 
				});
			});
		/* 	$('#AccountKeywordBtn').click(function() {
				alert('키워드 수정 버튼 클릭');
				let selectedKeyword = [];
				$('input.form-check-input[type=checkbox]:checked').each(function() {
					selectedKeyword.push($(this).attr('name'));
				});
				
				$.ajax({
					url:'${pageContext.request.contextPath}/user/mypage/updateKeyword',
					type: 'POST',
					contentType: 'application/json',
					data: JSON.stringify({keywords: selectedKeyword}),
					success: function(res){
						alert('관심 키워드가 수정되었습니다.');
						
						//refreshKeywordCheckboxes(); // UI갱신 
					},
					error: function(){
						alert('오류 발생');
					}, 
				});
			});
			 */
			// 계정 삭제 버튼 클릭 
			$('#AccountDeleteBtn').click(function() {
				if(!$('#accountActivation').is(':checked')){
					alert('삭제 동의 체크안됨');
					return;
				}
				if(confirm('정말로 계정을 삭제하시겠습니까?')) {
					$.ajax({
						url: '${pageContext.request.contextPath}/user/mypage/deleteAccount',
						type: 'POST',
						success: function(data) {
							if(data === 'success'){
								alert('삭제성공');
								window.location.href = '${pageContext.request.contextPath}/user/';
							}else {
								alert('삭제 실패');								
							}
						},
						error: function() {
							alert('계정 삭제 중 오류가 발생하였습니다. ')
						},
					});
				}	
			});
		
			
			
			
		});
		
		
	</script>
	
</body>
</html>