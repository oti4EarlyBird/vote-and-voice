<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" 
      class="light-style customizer-hide" 
      dir="ltr" 
      data-theme="theme-default"
      data-assets-path="${pageContext.request.contextPath}/resources/assets/"
      data-template="vertical-menu-template-free">

<head>
  <meta charset="utf-8" />
  <meta name="viewport" 
        content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"/>

  <title>회원 로그인 | Vote&Voice</title>

   <!-- Favicon -->
  <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/assets/img/favicon/favicon.ico" />

  <!-- Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link
    href="https://fonts.googleapis.com/css2?family=Public+Sans:wght@300;400;500;600;700&display=swap"
    rel="stylesheet"
  />

  <!-- Icons -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/vendor/fonts/boxicons.css" />

  <!-- Core CSS -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/vendor/css/core.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/vendor/css/theme-default.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/demo.css" />

  <!-- Vendors CSS -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

  <!-- Page CSS -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/vendor/css/pages/page-auth.css" />

  <!-- Helpers -->
  <script src="${pageContext.request.contextPath}/resources/assets/vendor/js/helpers.js"></script>
  <%-- <script src="${pageContext.request.contextPath}/resources/assets/js/config.js"></script>  --%>

</head>

<body>
<!-- Header -->
<%@include file="./common/nav.jsp" %>
  <!-- Content -->
  <div class="container-xxl">
    <div class="authentication-wrapper authentication-basic container-p-y">
      <div class="authentication-inner">
        <!-- Login Card -->
        <div class="card">
          <div class="card-body">
            <!-- Logo -->
            <div class="app-brand justify-content-center">
              <a href="/" class="app-brand-link gap-2">
                <span class="app-brand-text demo text-body fw-bolder">Vote&Voice</span>
              </a>
            </div>
            <!-- /Logo -->

            <h4 class="mb-2 text-center">회원 로그인 🔑</h4>
            <p class="mb-4 text-center">Vote&Voice에 오신 것을 환영합니다.</p>

            <% String error = (String) request.getAttribute("error");
               if (error != null) { %>
              <div class="alert alert-danger" role="alert">
                <%= error %>
              </div>
            <% } %>

            <!-- Login Form -->
            <form id="formAuthentication" class="mb-3" 
                  action="${pageContext.request.contextPath}/user/login" method="POST">

              <div class="mb-3">
                <label for="userid" class="form-label">아이디</label>
                <input type="text" class="form-control" id="userid" name="userid" placeholder="아이디를 입력하세요" required autofocus/>
              </div>

              <div class="mb-3 form-password-toggle">
                <div class="d-flex justify-content-between">
                  <label class="form-label" for="password">비밀번호</label>
                  <a href="${pageContext.request.contextPath}/resetPw">
                    <small>비밀번호 재설정</small>
                  </a>
                </div>
                <div class="input-group input-group-merge">
                  <input type="password" id="password" class="form-control" name="password"
                         placeholder="********" aria-describedby="password" required/>
                  <span class="input-group-text cursor-pointer"><i class="bx bx-hide"></i></span>
                </div>
              </div>

              <div class="mb-3">
                <button class="btn btn-primary d-grid w-100" type="submit">로그인</button>
              </div>
            </form>

            <p class="text-center">
              <span>아직 회원이 아니신가요?</span>
              <a href="${pageContext.request.contextPath}/user/signup">
                <span>회원가입</span>
              </a>
              <span class="mx-2">|</span>
              <a href="${pageContext.request.contextPath}/findId">아이디 찾기</a>
            </p>
          </div>
        </div>
        <!-- /Login Card -->
      </div>
    </div>
  </div>
  <!-- / Content -->
<c:if test="${not empty sessionScope.loginUser}">
    <span>${sessionScope.loginUser.name}님 환영합니다!</span>
</c:if>

  <!-- Footer -->
	<%@include file="./common/footer.jsp" %>
	<%-- <%@include file="../commons/jsConf.jsp"%> --%>

</body>
</html>