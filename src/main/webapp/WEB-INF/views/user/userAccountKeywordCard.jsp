<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- 키워드  -->
<div class="card mb-4">
	<!-- Notifications -->
	<h5 class="card-header">관심 키워드</h5>
	<form action="javascript:void(0);">
		<div class="card-body">
			<span> 관심 키워드를 설정하시면, 관련된 의안 정보를 먼저 받아보실 수 있습니다. </span>
			<div class="error"></div>
		</div>
		<div class="table-responsive m-3">
			<table class="table table-striped table-borderless border-bottom">
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
								id="${keyword.keywordContent}" name="${keyword.keywordContent}"
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
</div>