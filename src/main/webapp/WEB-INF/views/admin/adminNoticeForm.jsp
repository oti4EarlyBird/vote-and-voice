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

<title>관리자 공지사항 작성 폼</title>

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
						<h4 class="fw-bold py-3 mb-4">공지사항 작성</h4>

						<!-- Basic Layout -->
						<div class="row">
							<div class="col-xl">
								<div class="card mb-4">
									<div class="card-body">
										<form action="${pageContext.request.contextPath}/admin/noticeWriteForm" method="post" id="notice-write-form">
											<!-- 경고 메시지를 표시할 공간 -->
											<div id="validation-message" class="alert alert-danger" style="display: none;"></div>
											
											<!-- 이렇게 해야 모달에서 DB row를 선택해서 noticeId라는 notices의 dto 값으로 저장이 된다 -->
											<div class="mb-3">
												<label for="noticeCategorySelect" class="form-label">카테고리 설정</label>
						                        <select class="form-select" id="noticeCategorySelect" name="category" aria-label="Default select example">
						                          <option value="" selected disabled>카테고리를 설정해주세요</option>
						                          <option value="EVENT">EVENT</option>
						                          <option value="UPDATE">UPDATE</option>
						                          <option value="INFO">INFO</option>
						                        </select>
											</div>
											<div class="mb-3">
												<label class="form-label" for="noticeTitle">제목</label>
												<input type="text" class="form-control"
													id="noticeTitle" name="title" placeholder="2차 소비쿠폰 9월 22일부터 접수"/>
											</div>
											<div class="mb-3">
												<label class="form-label" for="noticePinnedSelect">고정 여부</label>
												<select class="form-select" id="noticePinnedSelect" name="isPinned" aria-label="Default select example">
						                          <option value="" selected disabled>상단 고정 여부를 설정해주세요</option>
						                          <option value="Y">YES</option>
						                          <option value="N">NO</option>
						                        </select>
												<div class="form-text">이 글을 Yes로 선택하면 상단에 올라가게 됩니다.</div>
											</div>
											<div class="mb-3">
												<label class="form-label" for="basic-default-message">자세한 설명</label>
												<textarea id="basic-default-message" class="form-control"
													name="content" placeholder="ex)이 ㅇㅇ법 일부개정법률안은  ~~한 목적으로 입안되었습니다."></textarea>
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
	<!-- 스크립트 코드 -->
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- TinyMCE CDN 추가 -->
	<script src="https://cdn.tiny.cloud/1/d4dunx94a24kbtnp0p9psueei0y88h8656a2vh45b6f7y5ht/tinymce/6/tinymce.min.js" referrerpolicy="origin"></script>

	<script>
	
	// DOM이 완전히 로드된 후에만 코드를 실행하도록 합니다.
	$(document).ready(function() {
		// TinyMCE 에디터 초기화
		tinymce.init({
			selector: '#basic-default-message',
			height: 300,
			menubar: false,
			plugins: [
				'advlist', 'autolink', 'lists', 'link', 'image', 'charmap', 'preview',
				'anchor', 'searchreplace', 'visualblocks', 'code', 'fullscreen',
				'insertdatetime', 'media', 'table', 'code', 'help', 'wordcount'
			],
			toolbar: 'undo redo | formatselect | ' +
			'bold italic | alignleft aligncenter alignright alignjustify | ' +
			'bullist numlist outdent indent | link image table | preview media | ' +
			'forecolor backcolor | code',
			content_style: 'body { font-family:Helvetica,Arial,sans-serif; font-size:14px }'
		});
		
		// 폼 제출 이벤트 핸들러를 추가하여 TinyMCE 내용을 <textarea>에 저장
        $('#notice-write-form').submit(function(event) {
        	// 메시지 박스 초기화
			$('#validation-message').hide().text('');

			// 1. 제목 유효성 검사
			if ($('#noticeTitle').val().trim() === '') {
				$('#validation-message').text('제목을 입력해주세요.').show();
				event.preventDefault();
				return;
			}

			// 2. 카테고리 유효성 검사
			if ($('#noticeCategorySelect').val() === '') {
				$('#validation-message').text('카테고리를 설정해주세요.').show();
				event.preventDefault();
				return;
			}

			// 3. 고정 여부 유효성 검사
			if ($('#noticePinnedSelect').val() === '') {
				$('#validation-message').text('고정 여부를 설정해주세요.').show();
				event.preventDefault();
				return;
			}
        	
            // TinyMCE 에디터 내용 유효성 검사
            let content = tinymce.get('basic-default-message').getContent({format: 'text'});
            if (!content || content.trim() === '') {
                alert("자세한 설명을 입력해주세요.");
                // 폼 제출 막기
                event.preventDefault();
                return; 
            }
            
         	// 모든 유효성 검사 통과 시
         	// TinyMCE 인스턴스의 내용을 <textarea>에 강제로 저장
            tinymce.triggerSave();
            console.log("TinyMCE 내용이 텍스트 영역에 성공적으로 저장되었습니다.");
        });
	});
	</script>
	<%@include file="../commons/jsConf.jsp"%>
</body>
</html>