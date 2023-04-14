<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${!empty login_id}"><script type="text/javascript">alert('이미 로그인 되어 있습니다.\n이전 페이지로 돌아갑니다.'); history.back();</script></c:if>

<% long time = System.currentTimeMillis(); %>
<jsp:include page="../layout/layout_header.jsp" />
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/asset/css/member.css?<%=time%>" />
<script language="javascript" src="<%=request.getContextPath()%>/asset/js/member.js?<%=time%>"></script>

<c:choose>
<c:when test="${ not empty findId }">
	<c:set var="find" value="아이디" />
	<c:set var="findVar" value="${ findId }"/>
</c:when>
<c:otherwise>
	<c:set var="find" value="비밀번호" />
	<c:set var="findVar" value="${ findPwd }" />
</c:otherwise>
</c:choose>

<div class="container page-title">
    <h2>FIND RESULT</h2>
    <h4>${ find } 찾기 결과</h4>
</div>



<div class="container member-form result">
    <div class="mf-wrap">
        <legend>${ find } 찾기 결과</legend>

        <div class="mf-result">회원님의 <br />${ find }는 <strong>${ findVar }</strong> 입니다.</div>

        <div class="mf-btn">
            <p><a href="memberLogin.do">로그인</a></p>
        </div>
    </div>
</div>



<jsp:include page="../layout/layout_footer.jsp" />