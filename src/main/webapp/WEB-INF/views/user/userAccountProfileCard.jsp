<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="card mb-4">
						<h5 class="card-header">프로필</h5>
						<!-- Account -->
						<!-- 
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
						-->
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
					</div>