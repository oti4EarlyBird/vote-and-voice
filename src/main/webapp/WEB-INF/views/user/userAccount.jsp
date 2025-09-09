<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<%@include file="./common/nav.jsp" %>

	<!-- Content wrapper -->
	<div class="content-wrapper">
		<!-- Content -->

		<div class="container-xxl flex-grow-1 container-p-y">
			<h4 class="fw-bold py-3 mb-4">
				<span class="text-muted fw-light">Account Settings /</span> Account
			</h4>

			<div class="row">
				<div class="col-md-12">
					<ul class="nav nav-pills flex-column flex-md-row mb-3">
						<li class="nav-item"><a class="nav-link active"
							href="javascript:void(0);"><i class="bx bx-user me-1"></i>
								Account</a></li>
						<li class="nav-item"><a class="nav-link"
							href="pages-account-settings-notifications.html"><i
								class="bx bx-bell me-1"></i> Notifications</a></li>
						<li class="nav-item"><a class="nav-link"
							href="pages-account-settings-connections.html"><i
								class="bx bx-link-alt me-1"></i> Connections</a></li>
					</ul>
					
					
					<div class="card mb-4">
						<h5 class="card-header">Profile Details</h5>
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

									<p class="text-muted mb-0">Allowed JPG, GIF or PNG. Max
										size of 800K</p>
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
											class="form-control" type="text" id="id"
											name="id" value="John1234" autofocus />
									</div>
									<div class="mb-3 col-md-6">
										<label for="name" class="form-label">Name</label> <input
											class="form-control" type="text" id="name"
											name="name" value="John" autofocus />
									</div>
									<div class="mb-3 col-md-6">
										<label for="password" class="form-label">Password</label> <input
											class="form-control" type="password" id="password"
											name="password" value="" autofocus />
									</div>
									<div class="mb-3 col-md-6">
										<label for="passwordCheck" class="form-label">Password Check</label> <input
											class="form-control" type="password" id="passwordCheck"
											name="passwordCheck" value="" autofocus />
									</div>
									<div class="mb-3 col-md-6">
										<label for="email" class="form-label">E-mail</label> <input
											class="form-control" type="text" id="email" name="email"
											value="john.doe@example.com"
											placeholder="john.doe@example.com" />
									</div>
									<div class="mb-3 col-md-6">
										<label for="birthday" class="form-label">Birthday</label> <input
											class="form-control" type="date" id="birthday" name="birthday"
											value="2025-09-09"/>
									</div>
								
								<!-- 
									<div class="mb-3 col-md-6">
										<label for="currency" class="form-label">Currency</label> <select
											id="currency" class="select2 form-select">
											<option value="">Select Currency</option>
											<option value="usd">USD</option>
											<option value="euro">Euro</option>
											<option value="pound">Pound</option>
											<option value="bitcoin">Bitcoin</option>
										</select>
									</div>
									 -->
								</div>
								<div class="mt-2">
									<button type="submit" class="btn btn-primary me-2">Save
										changes</button>
									<button type="reset" class="btn btn-outline-secondary">Cancel</button>
								</div>
							</form>
						</div>
						<!-- /Account -->
					</div>
					
					<!-- 키워드  -->
					<div class="card mb-4">
                    <!-- Notifications -->
                    <h5 class="card-header">Recent Devices</h5>
                    <div class="card-body">
                      <span
                        >We need permission from your browser to show notifications.
                        <span class="notificationRequest"><strong>Request Permission</strong></span></span
                      >
                      <div class="error"></div>
                    </div>
                    <div class="table-responsive">
                      <table class="table table-striped table-borderless border-bottom">
                        <thead>
                          <tr>
                            <th class="text-nowrap">Type</th>
                            <th class="text-nowrap text-center">✉️ Email</th>
                            <th class="text-nowrap text-center">🖥 Browser</th>
                            <th class="text-nowrap text-center">👩🏻‍💻 App</th>
                          </tr>
                        </thead>
                        <tbody>
                          <tr>
                            <td class="text-nowrap">New for you</td>
                            <td>
                              <div class="form-check d-flex justify-content-center">
                                <input class="form-check-input" type="checkbox" id="defaultCheck1" checked />
                              </div>
                            </td>
                            <td>
                              <div class="form-check d-flex justify-content-center">
                                <input class="form-check-input" type="checkbox" id="defaultCheck2" checked />
                              </div>
                            </td>
                            <td>
                              <div class="form-check d-flex justify-content-center">
                                <input class="form-check-input" type="checkbox" id="defaultCheck3" checked />
                              </div>
                            </td>
                          </tr>
                          <tr>
                            <td class="text-nowrap">Account activity</td>
                            <td>
                              <div class="form-check d-flex justify-content-center">
                                <input class="form-check-input" type="checkbox" id="defaultCheck4" checked />
                              </div>
                            </td>
                            <td>
                              <div class="form-check d-flex justify-content-center">
                                <input class="form-check-input" type="checkbox" id="defaultCheck5" checked />
                              </div>
                            </td>
                            <td>
                              <div class="form-check d-flex justify-content-center">
                                <input class="form-check-input" type="checkbox" id="defaultCheck6" checked />
                              </div>
                            </td>
                          </tr>
                          <tr>
                            <td class="text-nowrap">A new browser used to sign in</td>
                            <td>
                              <div class="form-check d-flex justify-content-center">
                                <input class="form-check-input" type="checkbox" id="defaultCheck7" checked />
                              </div>
                            </td>
                            <td>
                              <div class="form-check d-flex justify-content-center">
                                <input class="form-check-input" type="checkbox" id="defaultCheck8" checked />
                              </div>
                            </td>
                            <td>
                              <div class="form-check d-flex justify-content-center">
                                <input class="form-check-input" type="checkbox" id="defaultCheck9" />
                              </div>
                            </td>
                          </tr>
                          <tr>
                            <td class="text-nowrap">A new device is linked</td>
                            <td>
                              <div class="form-check d-flex justify-content-center">
                                <input class="form-check-input" type="checkbox" id="defaultCheck10" checked />
                              </div>
                            </td>
                            <td>
                              <div class="form-check d-flex justify-content-center">
                                <input class="form-check-input" type="checkbox" id="defaultCheck11" />
                              </div>
                            </td>
                            <td>
                              <div class="form-check d-flex justify-content-center">
                                <input class="form-check-input" type="checkbox" id="defaultCheck12" />
                              </div>
                            </td>
                          </tr>
                        </tbody>
                      </table>
                    </div>
                    <div class="card-body">
                      <h6>When should we send you notifications?</h6>
                      <form action="javascript:void(0);">
                        <div class="row">
                          <div class="col-sm-6">
                            <select id="sendNotification" class="form-select" name="sendNotification">
                              <option selected>Only when I'm online</option>
                              <option>Anytime</option>
                            </select>
                          </div>
                          <div class="mt-4">
                            <button type="submit" class="btn btn-primary me-2">Save changes</button>
                            <button type="reset" class="btn btn-outline-secondary">Discard</button>
                          </div>
                        </div>
                      </form>
                    </div>
                    <!-- /Notifications -->
                  </div>
					
					
					
					<!-- 계정 삭제 -->
					<div class="card">
						<h5 class="card-header">Delete Account</h5>
						<div class="card-body">
							<div class="mb-3 col-12 mb-0">
								<div class="alert alert-warning">
									<h6 class="alert-heading fw-bold mb-1">Are you sure you
										want to delete your account?</h6>
									<p class="mb-0">Once you delete your account, there is no
										going back. Please be certain.</p>
								</div>
							</div>
							<form id="formAccountDeactivation" onsubmit="return false">
								<div class="form-check mb-3">
									<input class="form-check-input" type="checkbox"
										name="accountActivation" id="accountActivation" />
									<label class="form-check-label" for="accountActivation">I
										confirm my account deactivation</label>
								</div>
								<button type="submit" class="btn btn-danger deactivate-account">Deactivate
									Account</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- / Content -->


		<%@include file="./common/footer.jsp" %>
		<%@include file="../commons/jsConf.jsp"%>
</body>
</html>