<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% long time = System.currentTimeMillis(); %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${empty login_id}"><script type="text/javascript">alert("회원 로그인이 필요한 페이지입니다."); location.href='<%=request.getContextPath()%>/memberLogin.do';</script></c:if>

<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/asset/css/mypage.css?<%=time%>" />
<script language="javascript" src="<%=request.getContextPath()%>/asset/js/mypage.js?<%=time%>">
</script>

<div class="container page-title">
    <h2>MY PAGE</h2>
    <h4>마이페이지</h4>
</div>



<div class="container mypage-wrap clear">
    <!-- 마이페이지 정보 //START -->
    <div class="mw-info">
        <div class="tit">${login_name}님 반가워요!</div>

        <div class="count">스테이:키와 함께 <strong>${login_reserv}</strong>번의 여행을 했어요.</div>

        <div class="edit">
            <span>${login_email}</span>
            <a href="<%=request.getContextPath()%>/mypageInfo.do">회원 정보 수정</a>
        </div>
    </div>
    <!-- 마이페이지 정보 //END -->

    <!-- 마이페이지 메뉴 //START -->
    <div class="mw-menu">
        <ul>																					
            <li id="mymenu-reserv"><a href="<%=request.getContextPath()%>/mypageReservList.do">예약 정보</a></li>
            <li id="mymenu-wish"><a href="<%=request.getContextPath()%>/mypageWish.do">관심 스테이</a></li>
            <li id="mymenu-qna"><a href="<%=request.getContextPath()%>/mypageQnaList.do">1:1 문의</a></li>
            <li id="mymenu-info"><a href="<%=request.getContextPath()%>/mypageInfo.do">회원정보 수정</a></li>
        </ul>
    </div>
    <!-- 마이페이지 메뉴 //END -->



    <!-- 마이페이지 내용 //START -->
    <div class="mw-cont">


