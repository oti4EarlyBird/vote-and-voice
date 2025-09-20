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
			세션loginUser ${sessionScope.loginUser }
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
					<%-- <div class="card mb-4">
						<h5 class="card-header">프로필</h5>
						<!-- Account -->
						<div class="card-body">
							<div class="d-flex align-items-start align-items-sm-center gap-4">
								<img src="../assets/img/avatars/1.png" alt="user-avatar"
									class="d-block rounded" height="100" width="100"
									id="uploadedAvatar" />
								<div class="button-wrapper">
									<label for="upload" class="btn btn-primary me-2 mb-4"
										tabindex="0"> <span class="d-none d-sm-block">Upload
											new photo</span> <i class="bx bx-upload d-block d-sm-none"></i> <input
										type="file" id="upload" class="account-file-input" hidden
										accept="image/png, image/jpeg" />
									</label>
									<button type="button"
										class="btn btn-outline-secondary account-image-reset mb-4">
										<i class="bx bx-reset d-block d-sm-none"></i> <span
											class="d-none d-sm-block">Reset</span>
									</button>
								</div>
							</div>
						</div>
						<hr class="my-0" />
						<div class="card-body">
							<form id="formAccountSettings" method="POST"
								onsubmit="return false">
								<div class="row">
									<div class="mb-3 col-md-6">
										<label for="id" class="form-label">ID</label> <input
											class="form-control" type="text" id="id" name="id"
											value="${sessionScope.loginUser.userid}" readonly />
									</div>
									<div class="mb-3 col-md-6">
										<label for="name" class="form-label">이름(Name)</label> <input
											class="form-control" type="text" id="name" name="name"
											value="${loginUser.name}" />
									</div>
									<div class="mb-3 col-md-6">
										<label for="password" class="form-label">비밀번호(Password)</label>
										<input class="form-control" type="password" id="password"
											name="password" value="" autofocus />
									</div>


									<div class="form-password-toggle b-3 col-md-6">
										<label class="form-label" for="passwordCheck">비밀번호
											확인(Password Check)</label>
										<div class="input-group">
											<input type="password" class="form-control"
												id="passwordCheck" aria-describedby="passwordCheckHelp" />
											<span id="basic-default-password2"
												class="input-group-text cursor-pointer"><i
												class="bx bx-hide"></i></span>
										</div>
										<div id="passwordCheckHelp" class="form-text text-danger"
											style="display: none">비밀번호가 일치하지 않습니다.</div>
									</div>

									<div class="mb-3 col-md-6">
										<label for="email" class="form-label">이메일 (E-mail)</label> <input
											class="form-control" type="email" id="email" name="email"
											value="${loginUser.email }" />
									</div>
									<div class="mb-3 col-md-6">
										<label for="birthday" class="form-label">생년월일
											(Birthday)</label> <input class="form-control" type="date"
											id="birthday" name="birthday" value="${loginUser.birthDate }" />
									</div>
								</div>
								<div class="mt-2">
									<button id="AccountBtn" type="button"
										class="btn btn-primary me-2">Save changes</button>
									<button type="reset" class="btn btn-outline-secondary">Cancel</button>
								</div>
							</form>
						</div>
						<!-- /Account -->
					</div> --%>
					
					<!-- 키워드  -->
					<div id="keywordCardContainer">
						<jsp:include page="/WEB-INF/views/user/userAccountKeywordCard.jsp"></jsp:include>
					</div>
					<%-- <!-- 키워드  -->
					<div class="card mb-4">
						<!-- Notifications -->
						<h5 class="card-header">관심 키워드</h5>
						<form action="javascript:void(0);">
							<div class="card-body">
								<span> 관심 키워드를 설정하시면, 관련된 의안 정보를 먼저 받아보실 수 있습니다. </span>
								<div class="error"></div>
							</div>
							<div class="table-responsive m-3">
								<table
									class="table table-striped table-borderless border-bottom">
									<thead>
										<tr>
											<c:forEach var="keyword" items="${allKeywords }">
												<th class="text-nowrap text-center">
													${keyword.keywordContent}</th>
											</c:forEach>
										</tr>
									</thead>
									<tbody>
										<tr>
											<c:forEach var="keyword" items="${allKeywords }">
												<td class="text-nowrap text-center"><input
													class="form-check-input" type="checkbox"
													id="${keyword.keywordContent}"
													name="${keyword.keywordContent}"
													<c:if test="${fn:contains(loginUser.interestKeyword, keyword.keywordContent)}">checked</c:if>>
												</td>
											</c:forEach>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="card-body">
								<h6>When should we send you notifications?</h6>
								<!--  <form action="javascript:void(0);"> -->
								<div class="row">
									<div class="col-sm-6">
										<select id="sendNotification" class="form-select"
											name="sendNotification">
											<option selected>Only when I'm online</option>
											<option>Anytime</option>
										</select>
									</div>
									<div class="mt-4">
										<button id="AccountKeywordBtn" type="button"
											class="btn btn-primary me-2">Save changes</button>
										<button type="reset" class="btn btn-outline-secondary">Cancle</button>
									</div>
								</div>
							</div>
						</form>
						<!-- /Notifications -->
					</div> --%>



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