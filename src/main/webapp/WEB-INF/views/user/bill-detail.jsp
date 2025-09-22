<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- 의안 상세 -->
<div class="bill-detail">
    <h2>
        <c:out value="${bill.title}" />
    </h2>
    <hr class="boldhr">
    <p>
        번호 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <c:out value="${bill.billId}" />
    </p>
    <hr>
    <p>
        의안번호 &nbsp;&nbsp;
        <c:out value="${bill.billNumber}" />
    </p>
    <hr>
    <p>
        소관위원회 &nbsp;&nbsp;
        <c:out value="${bill.committee}" />
    </p>
    <hr>
    <p>
        본회의 의결일 &nbsp;&nbsp;
        <c:out value="${bill.decisionDate}" />
    </p>
    <hr>
    <p>
        본회의 의결 결과 &nbsp;&nbsp;
        <c:out value="${bill.decisionResult}" />
    </p>
    <hr class="boldhr">
 	<%-- <div style="white-space: pre-line;">
        <c:out value="${bill.content}" escapeXml="false"/>
    </div> --%>
    <!-- 관련 링크 -->
    <div class="mt-3">
        <c:if test="${not empty bill.relatedUrl}">
            <a href="${bill.relatedUrl}" target="_blank" class="btn btn-sm btn-info">관련 URL</a>
        </c:if>
        <c:if test="${not empty bill.pdfLink}">
            <a href="${bill.pdfLink}" target="_blank" class="btn btn-sm btn-danger">PDF 문서</a>
        </c:if>
        <c:if test="${not empty bill.videoLink}">
            <a href="${bill.videoLink}" target="_blank" class="btn btn-sm btn-success">영상 보기</a>
        </c:if>
        <div style="white-space: pre-line;">
        	<c:out value="${bill.summary}" escapeXml="false"/>
    	</div>
    </div>
    <br>
    
</div>