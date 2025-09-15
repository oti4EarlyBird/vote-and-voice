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
        <c:out value="${bill.num}" />
    </p>
    <hr>
    <p>
        의안번호 &nbsp;&nbsp;
        <c:out value="${bill.billnum}" />
    </p>
    <hr>
    <p>
        소관위원회 &nbsp;&nbsp;
        <c:out value="${bill.where}" />
    </p>
    <hr>
    <p>
        본회의 의결일 &nbsp;&nbsp;
        <c:out value="${bill.date}" />
    </p>
    <hr>
    <p>
        본회의 의결 결과 &nbsp;&nbsp;
        <c:out value="${bill.result}" />
    </p>
    <hr class="boldhr">

    <div style="white-space: pre-line;">
        <c:out value="${bill.content}" />
    </div>
    <br>
</div>