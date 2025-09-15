<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko" class="light-style customizer-hide" dir="ltr"
	data-theme="theme-default"
	data-assets-path="${pageContext.request.contextPath}/resources/assets/"
	data-template="vertical-menu-template-free">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />

<title>회원가입 | Sneat Template</title>

<!-- Favicon -->
<link rel="icon" type="image/x-icon"
	href="${pageContext.request.contextPath}/resources/assets/img/favicon/favicon.ico" />

<!-- Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
	rel="stylesheet" />

<!-- Icons -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets/vendor/fonts/boxicons.css" />

<!-- Core CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets/vendor/css/core.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets/vendor/css/theme-default.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets/css/demo.css" />

<!-- Vendors CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

<!-- Page CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets/vendor/css/pages/page-auth.css" />

<!-- Helpers -->
<script
	src="${pageContext.request.contextPath}/resources/assets/vendor/js/helpers.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/assets/js/config.js"></script>
</head>

<body>

	<!-- Header -->
	<%@include file="./common/nav.jsp"%>

	<!-- Content -->
	<div class="container-xxl">
		<div class="authentication-wrapper authentication-basic container-p-y">
			<div class="authentication-inner">
				<!-- Register Card -->
				<div class="card">
					<div class="card-body">
						<!-- Logo -->
						<div class="app-brand justify-content-center">
							<a href="${pageContext.request.contextPath}/resources/"
								class="app-brand-link gap-2"> <span
								class="app-brand-text demo text-body fw-bolder">회원가입</span>
							</a>
						</div>
						<!-- /Logo -->
						<h4 class="mb-2">Vote and Voice 🚀</h4>
						<p class="mb-4">지금 회원가입하고 서비스를 시작하세요</p>

						<!-- 에러 메시지 출력 -->
						<c:if test="${not empty error}">
							<div class="alert alert-danger">${error}</div>
						</c:if>

						<form id="formAuthentication" class="mb-3"
							action="${pageContext.request.contextPath}/user/signup"
							method="POST">

							<div class="mb-3">
								<label class="form-label">이름</label> <input type="text"
									class="form-control" name="name" value="${userDTO.name}" placeholder="이름을 입력하세요"
									required />
							</div>

						    <div class="mb-3">
								<label class="form-label">생년월일</label> <input type="date"
									class="form-control" name="birthDate" value="${userDTO.birth}" 
									id="birthInput" />
							</div> 

							<div class="mb-3">
								<label class="form-label">이메일</label> <input type="email"
									class="form-control" name="email" value="${userDTO.email}" placeholder="이메일을 입력하세요"
									required />
							</div>

							<div class="mb-3">
								<label class="form-label">아이디</label> <input type="text"
									class="form-control" name="userId" value="${userDTO != null ? userDTO.userId : ''}" placeholder="아이디를 입력하세요"
									required />
							</div>

							<div class="mb-3 form-password-toggle">
								<label class="form-label">비밀번호</label>
								<div class="input-group input-group-merge">
									<input type="password" class="form-control" id="pwd" name="password"
										placeholder="비밀번호를 입력하세요" required /> <span
										class="input-group-text cursor-pointer"><i
										class="bx bx-hide"></i></span>
								</div>
							</div>

							<div class="mb-3 form-password-toggle">
								<label class="form-label">비밀번호 확인</label>
								<div class="input-group input-group-merge">
									<input type="password" class="form-control" id="pwdConf" name="passwordConfirm"
										placeholder="비밀번호를 다시 입력하세요" required />
									<span class="input-group-text cursor-pointer"><i
										class="bx bx-hide"></i></span>
								</div>
								<small id="passwordMessage" class="form-text"></small>
							</div>

							<div class="mb-3">
								<label class="form-label">관심 키워드</label>
								<div class="row">
									<c:forEach var="keyword" items="${keywords}">
										<div class="col-md-4">
											<div class="form-check">
												<input class="form-check-input" 
													type="checkbox"
													name="selectedKeywords" 
													value="${keyword.seq}"
													id="keyword${keyword.seq}" /> 
													<label class="form-check-label" for="keyword${keyword.seq}">
														${keyword.keywordContent} </label>
											</div>
										</div>
									</c:forEach>
								</div>
							</div>

							<button class="btn btn-primary d-grid w-100">회원가입 완료</button>
						</form>

						<p class="text-center">
							<span>이미 계정이 있나요?</span> <a
								href="${pageContext.request.contextPath}/user/login"> <span>로그인</span>
							</a>
						</p>
					</div>
				</div>
				<!-- /Register Card -->
			</div>
		</div>
	</div>
	<!-- 가입 성공/실패 메시지 모달 -->
	<div class="modal fade" id="messageModal" tabindex="-1" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-body" id="modalMessage"></div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">확인</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- / Content -->

	<!-- Footer -->
	<%@include file="./common/footer.jsp"%>

	<!-- Core JS -->
	<script
		src="${pageContext.request.contextPath}/resources/assets/vendor/libs/jquery/jquery.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/assets/vendor/libs/popper/popper.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/assets/vendor/js/bootstrap.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/assets/vendor/js/menu.js"></script>
	<!-- Main JS -->
	<script
		src="${pageContext.request.contextPath}/resources/assets/js/main.js"></script>
	<!-- 실시간 비번 확인 메시지 -->
	<script>
		const pwd = document.getElementById("pwd");
		const pwdConfirm = document.getElementById("pwdConf");
		const message = document.getElementById("passwordMessage");
		
		function passwordMatch() {
			if(pwdConfirm.value.length === 0) {
				message.textContent="";
				return;
			}
			if(pwd.value === pwdConfirm.value) {
				message.textContent="비밀번호가 일치합니다.";
				message.style.color="green";
			}
			else {
				message.textContent="비밀번호가 일치하지 않습니다.";
				message.style.color="red";
			}
		}
		pwd.addEventListener("keyup", passwordMatch);
		pwdConfirm.addEventListener("keyup", passwordMatch);
	</script>
	<!-- 가입 성공 실패 시 모달 -->
	<script>
		function showModal(message) {
		    document.getElementById('modalMessage').innerText = message;
		    var myModal = new bootstrap.Modal(document.getElementById('messageModal'));
		    myModal.show();
		}
	</script>
	<c:if test="${not empty successMessage}">
	<script>
	    const message = '<c:out value="${successMessage}" />';
	    showModal(message);
	    setTimeout(function() {
	        location.href = '${pageContext.request.contextPath}/user/login';
	    }, 2000);
	</script>
	</c:if>
	
	<c:if test="${not empty errorMessage}">
	<script>
	    const error = '<c:out value="${errorMessage}" />';
	    showModal(error);
	</script>
</c:if>

	
</body>
</html>
