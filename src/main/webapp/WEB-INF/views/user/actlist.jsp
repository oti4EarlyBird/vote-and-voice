<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en"
      class="light-style"
      dir="ltr"
      data-theme="theme-default"
      data-assets-path="resources/assets/"
      data-template="vertical-menu-template-free">

<head>
    <meta charset="utf-8" />
    <title>의안 정보</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <!-- Sneat CSS -->
    <link rel="stylesheet" href="resources/assets/vendor/css/core.css" />
    <link rel="stylesheet" href="resources/assets/vendor/css/theme-default.css" />
    <link rel="stylesheet" href="resources/assets/css/demo.css" />

    <!-- Vendors CSS -->
    <link rel="stylesheet" href="resources/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

    <!-- Custom CSS -->
    <link rel="stylesheet" href="resources/assets/css/actlist.css" />

    <!-- Helpers -->
    <script src="resources/assets/vendor/js/helpers.js"></script>
    <script src="resources/assets/js/config.js"></script>
</head>

<body>

    <!-- Header -->


    <!-- Main Content -->
    <div class="container-xxl flex-grow-1 container-p-y">
	<h4 class="fw-bold mb-4">의안 정보</h4>
	<div class="btn-container">
		<button type="button" class="btn rounded-pill btn-primary">청년</button>
		<button type="button" class="btn rounded-pill btn-primary">노인</button>
		<button type="button" class="btn rounded-pill btn-primary">복지</button>
		<button type="button" class="btn rounded-pill btn-primary">교육</button>
	</div>
	
        <!-- 검색 박스 -->
        <div class="card p-3 mb-4">
            <form class="row g-2" action="billList.jsp" method="get">
                <div class="col-md-10">
                    <input type="text" name="keyword" class="form-control" placeholder="검색어를 입력하세요">
                </div>
                <div class="col-md-2">
                    <button type="submit" class="btn btn-primary w-100">검색</button>
                </div>
            </form>
        </div>

        <!-- 목록  -->
        <div class="card">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th class="text-center">번호</th>
                            <th class="text-center">제목</th>
                            <th class="text-center">의안번호</th>
                            <th class="text-center">소관위원회</th>
                            <th class="text-center">본회의 의결 결과</th>
                            <th class="text-center">본회의 의결일</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="act" items="${actList}">
                            <tr>
                                <td class="text-center">${act.num}</td>
                                <td class="text-center">
                                    <a href="resources/user/actdetail?actnum=${act.num}">
                                        ${act.title}
                                    </a>
                                </td>
                                <td class="text-center">${act.billnum}</td>
                                <td class="text-center">${act.where}</td>
                                <td class="text-center">${act.result}</td>
                                <td class="text-center">${act.date}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- 페이징 -->
        <nav aria-label="Page navigation" class="mt-4">
            <ul class="pagination justify-content-center">
                <c:forEach var="i" begin="1" end="${totalPages}">
                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                        <a class="page-link" href="?page=${i}">${i}</a>
                    </li>
                </c:forEach>
            </ul>
        </nav>

    </div>

    <!-- Footer -->


    <!-- Core JS -->
    <script src="resources/assets/vendor/libs/jquery/jquery.js"></script>
    <script src="resources/assets/vendor/libs/popper/popper.js"></script>
    <script src="resources/assets/vendor/js/bootstrap.js"></script>
    <script src="resources/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
    <script src="resources/assets/vendor/js/menu.js"></script>
    <script src="resources/assets/js/main.js"></script>

</body>
</html>
