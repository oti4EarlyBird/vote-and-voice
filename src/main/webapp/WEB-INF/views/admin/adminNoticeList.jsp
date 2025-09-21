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
							공지사항
						</h4>
						<ul>Vote-and-Voice의 소식 자료입니다.</ul>
						<ul>사용자 분들께 신속히 알려드릴 필요성이 있는 자료를 제공해드립니다.</ul>
						<div class="card d-flex flex-row justify-content-start p-3 mb-4">
						<button class="btn btn-outline-primary me-2 category-btn" data-category="ALL">ALL</button>
							<button class="btn btn-outline-primary me-2 category-btn" data-category="EVENT">EVENT</button>
							<button class="btn btn-outline-primary me-2 category-btn" data-category="UPDATE">UPDATE</button>
							<button class="btn btn-outline-primary me-2 category-btn" data-category="INFO">INFO</button>
						</div>
						<!-- Basic Bootstrap Table -->
						<div class="card">
							<h5 class="card-header d-flex justify-content-between align-items-center">
								<span id="totalCount">Total ${fn:length(noticeList)}건</span>
								<!-- 오른쪽 정렬하기 -->
								<button class="btn btn-primary" onclick="location.href='noticeWriteForm'">
									작성
								</button>
							</h5>
							<div class="table-responsive text-nowrap">
								<table class="table">
									<thead>
										<tr>
											<th>번호</th>
											<th>카테고리</th>
											<th>제목</th>
											<th>글쓴이</th>
											<th>조회수</th>
											<th>작성일</th>
										</tr>
									</thead>
									<tbody id="noticeTableBody">
										<c:forEach var="notice" items="${noticeList}">
											<tr>
												<td>
													<strong>${notice.noticeId}</strong>
												</td>
												<td>
													<span class="badge bg-label-primary me-1">${notice.category}</span>
												</td>
												<td>
													<strong>${notice.title}</strong>
												</td>
												<td>
													<span class="badge bg-label-primary me-1">${notice.writer}</span>
												</td>
												<td>${notice.viewNum}</td>
												<td>${notice.content}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
						<div class="card-body">
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
	
	<!-- jQuery를 먼저 로드해야 합니다. -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<%@include file="../commons/jsConf.jsp"%>
	
	<script type="text/javascript">
		$(document).ready(function() {
			// 페이지 로딩 시 기본적으로 'ALL' 버튼을 활성화합니다.
		    // 이 코드를 통해 페이지가 로드되자마자 ALL 버튼이 선택된 상태로 보입니다.
		    $('.category-btn[data-category="ALL"]').removeClass('btn-outline-primary').addClass('btn-primary');

		    // 모든 카테고리 버튼에 클릭 이벤트를 연결합니다.
		    $('.category-btn').on('click', function() {
		        // 기존에 활성화된 버튼의 스타일을 비활성화로 변경합니다.
		        $('.category-btn.btn-primary').removeClass('btn-primary').addClass('btn-outline-primary');
		        
		        // 클릭된 버튼의 스타일을 활성화로 변경합니다.
		        $(this).removeClass('btn-outline-primary').addClass('btn-primary');
	
		        // data-category 속성에서 카테고리 이름을 가져옵니다.
		        const category = $(this).data('category');
		        
		        // Ajax 요청을 통해 데이터를 불러옵니다.
		        loadNotices(category);
		    });
	
		    // 공지사항 데이터를 Ajax로 불러오는 함수
		    function loadNotices(category) {
		        // 로딩 상태 메시지 표시
		        $('#noticeTableBody').empty().append('<tr><td colspan="7" class="text-center">데이터를 불러오는 중...</td></tr>');
		        
		        $.ajax({
		            url: '${pageContext.request.contextPath}/admin/noticesByCategory',
		            type: 'GET',
		            dataType: 'json',
		            data: { category: category }, // 카테고리 값을 컨트롤러로 보냅니다.
		            cache: false, // 캐시 무효화 옵션 추가
		            success: function(response) {
		            	console.log("[AJAX 성공] 서버로부터 받은 응답:", response);
		                // 성공적으로 데이터를 받아오면 테이블을 업데이트합니다.
		                $('#noticeTableBody').empty();
		                $('#totalCount').text('Total ' + (response ? response.length : 0) + '건');
						
		             	// 응답 데이터가 유효한 배열인지 확인합니다.
		                if (response && Array.isArray(response) && response.length > 0) {
		                	try {
		                        $.each(response, function(index, notice) {
		                        	// 데이터가 null 또는 undefined일 경우 빈 문자열로 처리
		                            const title = notice.title ? notice.title.trim() : '';
		                            const writer = notice.writer ? notice.writer.trim() : '';
		                            const category = notice.category ? notice.category.trim() : '';
		                            
		                            // 제목 또는 작성자가 빈 문자열일 경우 대체 텍스트를 사용
		                            const displayTitle = title === '' ? '(제목 없음)' : title.replace(/`/g, '&#x60;');
		                            const displayWriter = writer === '' ? '(작성자 없음)' : writer.replace(/`/g, '&#x60;');
		                            const displayCategory = category === '' ? '(미정)' : category.replace(/`/g, '&#x60;');

		                            const row = '<tr><td><strong>' 
		                            			+ notice.noticeId
		                            			+ '</strong></td><td><span class="badge bg-label-primary me-1">'
		                            			+ displayCategory + '</span></td><td><strong>'
		                            			+ displayTitle 
		                            			+ '</strong></td><td><span class="badge bg-label-primary me-1">'
		                            			+ displayWriter + '</span></td><td>'
		                            			+ notice.viewNum
		                            			+ '</td><td>'
		                            			+ notice.postDate
		                            			+ '</td><td><button class="btn btn-primary" onclick="location.href=\'noticeWriteForm\'">삭제</button></td></tr>';
		                    		$('#noticeTableBody').append(row);
		                        });
		                        console.log("[렌더링 성공] 테이블에 데이터가 성공적으로 추가되었습니다.");
		                    } catch (e) {
		                    	//렌더링 과정에서 에러가 발생한 경우
		                        console.error("데이터 렌더링 중 오류 발생:", e);
		                        $('#noticeTableBody').empty().append('<tr><td colspan="7" class="text-center">데이터를 표시하는 중 오류가 발생했습니다.</td></tr>');
		                    }
		                } else {
		                	// 렌더링은 성공적이나 게시글이 없는 경우
		                	console.log("[응답 데이터 없음] 반환된 게시글이 없거나 데이터가 유효하지 않습니다.");
		                    $('#noticeTableBody').append('<tr><td colspan="7" class="text-center">해당 카테고리의 게시글이 없습니다.</td></tr>');
		                }
		            },
		            error: function(xhr, status, error) {
		                console.error("데이터 로딩 실패:", status, error);
		                $('#noticeTableBody').empty().append('<tr><td colspan="7" class="text-center">데이터를 불러오는 데 실패했습니다.</td></tr>');
		            }
		        });
		    }
		});
	</script>
</body>
</html>