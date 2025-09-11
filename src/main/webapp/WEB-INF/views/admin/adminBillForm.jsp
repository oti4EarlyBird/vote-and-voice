<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

<title>관리자 법안 게시판 작성 폼</title>

<meta name="description" content="" />
<%@ include file="/WEB-INF/views/commons/cssConf.jsp"%>

<!-- Favicon -->
<link rel="icon" type="image/x-icon"
	href="../assets/img/favicon/favicon.ico" />
</head>

<body>
	<%@ include file="../commons/aside.jsp"%>
	<%@ include file="../commons/navbar.jsp"%>

	<!-- Layout wrapper -->
	<div class="layout-wrapper layout-content-navbar">
		<div class="layout-container">
			<!-- Layout container -->
			<div class="layout-page">


				<!-- Content wrapper -->
				<div class="content-wrapper">
					<!-- Content -->

					<div class="container-xxl flex-grow-1 container-p-y">
						<h4 class="fw-bold py-3 mb-4">의안 작성</h4>

						<!-- Basic Layout -->
						<div class="row">
							<div class="col-xl">
								<div class="card mb-4">
									<div
										class="card-header d-flex justify-content-between align-items-center">
										<button type="button" class="btn btn-primary"
											data-bs-toggle="modal" data-bs-target="#fullscreenModal">
											Launch modal</button>
									</div>
									
									
									<div class="card-body">
										<form>
											<div class="mb-3">
												<label class="form-label" for="basic-default-fullname">법안명</label>
												<input type="text" class="form-control"
													id="basic-default-fullname" placeholder="ex)00법 일부개정법률안" />
											</div>
											<div class="mb-3">
												<label class="form-label" for="basic-default-company">의안번호</label>
												<input type="text" class="form-control"
													id="basic-default-company" placeholder="ex)2204720" />
											</div>
											<div class="mb-3">
												<label class="form-label" for="basic-default-email">관련
													URL</label>
												<div class="input-group input-group-merge">
													<input type="text" class="form-control"
														id="basic-default-company" placeholder="URL을 적어주세요" />
												</div>
												<div class="form-text">사용자에게 도움이 될만한 정보가 포함된 URL을
													적어주세요</div>
											</div>
											<div class="mb-3">
												<label class="form-label" for="basic-default-fullname">소관위원회</label>
												<input type="text" class="form-control"
													id="basic-default-fullname" placeholder="ex)법사위원회" />
											</div>
											<div class="mb-3">
												<label class="form-label" for="basic-default-message">자세한
													설명</label>
												<textarea id="basic-default-message" class="form-control"
													placeholder="ex)이 ㅇㅇ법 일부개정법률안은  ~~한 목적으로 입안되었습니다."></textarea>
											</div>
											<button type="submit" class="btn btn-primary">작성</button>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- / Content -->

					<%@include file="../commons/footer.jsp"%>

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
	<!-- 모달 코드를 여기로 이동 -->
	<div class="modal fade" id="fullscreenModal" tabindex="-1" aria-labelledby="fullscreenModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-xl">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="fullscreenModalLabel">법안 목록 (페이징)</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="card-body">
						<div class="table-responsive text-nowrap">
							<table class="table card-table">
								<thead>
									<tr>
										<th>번호</th>
										<th>법안명</th>
										<th>의안번호</th>
										<th>소관위원회</th>
										<th>심의결과</th>
										<th>의결일</th>
										<th>동작</th>
									</tr>
								</thead>
								<tbody class="table-border-bottom-0" id="modalTableBody">
									<!-- Ajax로 로드된 데이터가 여기에 들어갑니다 -->
								</tbody>
							</table>
						</div>
						<nav aria-label="Page navigation" class="mt-4">
							<ul class="pagination justify-content-center" id="modalPagination">
								<!-- Ajax로 로드된 페이징이 여기에 들어갑니다 -->
							</ul>
						</nav>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 스크립트 코드 -->
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script>
	// 스크립트 파일이 로드되었는지 확인하는 로그를 추가합니다.
	console.log("스크립트 파일이 실행되고 있습니다.");

	// DOM이 완전히 로드된 후에만 코드를 실행하도록 합니다.
	$(document).ready(function() {
		// Ajax 요청을 위한 함수
		function loadModalData(pageNum) {
			console.log("Ajax 요청 시작. 페이지 번호:", pageNum);

			// 로딩 상태 메시지 표시
			$("#modalTableBody")
					.empty()
					.append(
							'<tr><td colspan="7" class="text-center">데이터를 불러오는 중...</td></tr>');
			$("#modalPagination").empty(); // 기존 페이징 UI 비우기

			$.ajax({
						url : '${pageContext.request.contextPath}/admin/billModalSearch', // 컨트롤러 URL
						type : 'GET',
						data : {
							pageNum : pageNum,
							listSize : 10
						}, // 페이지 번호와 페이지당 개수 전달
						dataType : 'json',
						success : function(response) {
							console.log("데이터 수신 성공:", response);

							var dataList = response.dataList;
							var pageDTO = response.pageDTO;

							// 테이블 tbody를 비우고 데이터로 채움
							$("#modalTableBody").empty();

							if (dataList && dataList.length > 0) {
								$.each(
												dataList,
												function(index, item) {
													// JSON 데이터에 맞게 필드 이름 수정
													var rowHtml = '<tr>'
															+ '<td><strong>'
															+ (pageDTO.startList
																	+ index + 1)
															+ '</strong></td>' // 페이징 번호
															+ '<td>'
															+ item.billTitle
															+ '</td>'
															+ '<td>'
															+ item.billNumber
															+ '</td>'
															+ '<td><span class="badge bg-primary">'
															+ item.committee
															+ '</span></td>'
															+ '<td>'
															+ item.decisionResult
															+ '</td>'
															+ '<td>'
															+ item.decisionDate
															+ '</td>'
															+ '<td>'
															+ '<div class="dropdown">'
															// 부트스트랩 5 문법에 맞게 data-toggle -> data-bs-toggle로 변경
															+ '<button type="button" class="btn p-0 dropdown-toggle hide-arrow" data-bs-toggle="dropdown">'
															+ '<i class="bx bx-dots-vertical-rounded"></i>'
															+ '</button>'
															+ '<div class="dropdown-menu">'
															+ '<a class="dropdown-item" href="#"><i class="bx bx-edit-alt me-1"></i> Select</a>'
															+ '</div>'
															+ '</div>'
															+ '</td>' + '</tr>';
													$("#modalTableBody")
															.append(rowHtml);
												});
							} else {
								$("#modalTableBody")
										.append(
												'<tr><td colspan="7" class="text-center">표시할 데이터가 없습니다.</td></tr>');
							}

							// 페이징 UI 생성
							renderPagination(pageDTO);
						},
						error : function(xhr, status, error) {
							console.error("데이터 로딩 실패:", status, error);
							$("#modalTableBody")
									.empty()
									.append(
											'<tr><td colspan="7" class="text-center">데이터를 불러오는데 실패했습니다.</td></tr>');
						}
					});
		}

		// 페이징 UI를 렌더링하는 함수 (이전 답변에서 누락되었던 부분)
		function renderPagination(pageDTO) {
			var paginationHtml = '';
			if (pageDTO.prev) {
				paginationHtml += '<li class="page-item prev"><a class="page-link" href="#" data-page="' + (pageDTO.startPage - 1) + '"><i class="tf-icon bx bx-chevrons-left"></i></a></li>';
			}

			for (var i = pageDTO.startPage; i <= pageDTO.endPage; i++) {
				paginationHtml += '<li class="page-item ' + (i === pageDTO.pageNum ? 'active' : '') + '"><a class="page-link" href="#" data-page="' + i + '">' + i + '</a></li>';
			}

			if (pageDTO.next) {
				paginationHtml += '<li class="page-item next"><a class="page-link" href="#" data-page="' + (pageDTO.endPage + 1) + '"><i class="tf-icon bx bx-chevrons-right"></i></a></li>';
			}

			$("#modalPagination").html(paginationHtml);
		}

		// 모달이 열리기 전에 Ajax 요청 시작
		$('#fullscreenModal').on('show.bs.modal', function(e) {
			console.log("모달이 열리고 있습니다. Ajax 요청을 보낼 준비가 되었습니다.");
			loadModalData(1); // 모달이 열리면 1페이지 데이터 로드
		});
		
		// 페이징 링크 클릭 이벤트 핸들러
		$(document).on('click', '#modalPagination a.page-link', function(e) {
			e.preventDefault();
			var pageNum = $(this).data('page');
			if (pageNum) {
				loadModalData(pageNum);
			}
		});
	});
	</script>
	<%@include file="../commons/jsConf.jsp"%>
</body>
</html>
