<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% long time = System.currentTimeMillis(); %>
<jsp:include page="../layout/layout_header.jsp" />

<script type="text/javascript">$("#nav-magazine").addClass("now");</script>
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/asset/css/magazine.css?<%=time%>" />
<script language="javascript" src="<%=request.getContextPath()%>/asset/js/magazine.js?<%=time%>"></script>

<c:set var="view" value="${magazine}"/>
<c:set var="stay" value="${sdto}"/>



<div class="magazine-view">

    <div class="container mv-title">
        <h3>${stay_name}</h3>
    </div>



    <!-- 상단 이미지 //START -->
    <c:if test="${!empty view.bbs_top_img}">
    <div class="container_wide mv-top" style="background-image: url('<%=request.getContextPath()%>${view.bbs_top_img}');">
        <p class="title"><c:forTokens items="${view.bbs_title}" delims="<" var="title" begin="0" end="0">${title}</c:forTokens></p>
        <p class="stay">${stay_name}</p>
    </div>
    </c:if>
    <!-- 상단 이미지 //END -->



    <!-- 유튜브 //START -->
    <c:if test="${!empty view.bbs_youtube}">
    <div class="container mv-youtube">
        <div class="youtube-show">
            <iframe width="800" height="450" src="https://www.youtube.com/embed/${view.bbs_youtube}" frameborder="0" allow="accelerometer; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
        </div>
    </div>
    </c:if>
    <!-- 유튜브 //END -->



    <!-- 글 내용 1 //START -->
    <c:if test="${!empty view.bbs_content1}">
    <c:if test="${!empty view.bbs_detail_img1}">
    <div class="container">
        <div class="mdetail_img" style="background-image: url('<%=request.getContextPath()%>${view.bbs_detail_img1}');"></div>
    </div>
    </c:if>
    ${view.bbs_content1}
    </c:if>
    <!-- 글 내용 1 //END -->



    <!-- 글 내용 2 //START -->
    <c:if test="${!empty view.bbs_content2}">
    <c:if test="${!empty view.bbs_detail_img2}">
    <div class="container">
        <div class="mdetail_img" style="background-image: url('<%=request.getContextPath()%>${view.bbs_detail_img2}');"></div>
    </div>
    </c:if>
    ${view.bbs_content2}
    </c:if>
    <!-- 글 내용 2 //END -->



    <!-- 글 내용 3 //START -->
    <c:if test="${!empty view.bbs_content3}">
    <c:if test="${!empty view.bbs_map}">
    <div class="container mdetail_cont gmap">${view.bbs_map}</div>
    ${view.bbs_content3}
    </c:if>
    </c:if>
    <!-- 글 내용 3 //END -->



    <c:if test="${!empty stay}">
    <div class="container mv-stay">
        <div class="mvs-info">
            <dl>
                <dt>스테이명</dt>
                <dd>${stay.stay_name}</dd>
                <hr />
                <dt>전화</dt>
                <dd class="eng">${stay.stay_phone}</dd>
                <hr />
                <dt>주소</dt>
                <dd>${stay.stay_location.replace(" / ", " ")} ${stay.stay_addr}</dd>
                <hr />
            </dl>
            <dl>
                <dt>숙소타입</dt>
                <dd>${stay.stay_type}</dd>
                <hr />
                <dt>인원</dt>
                <dd>${stay.stay_room_people_min}명 ~ <c:if test="${stay.stay_room_people_min != stay.stay_room_people_max}">${stay.stay_room_people_max}명</c:if></dd>
                <hr />
                <dt>가격대</dt>
                <dd class="eng"><fmt:setLocale value="ko_kr" /><fmt:formatNumber value="${stay.stay_room_price_min}" type="currency" /> ~ <c:if test="${stay.stay_room_price_min != stay.stay_room_price_max}"><fmt:setLocale value="ko_kr" /><fmt:formatNumber value="${stay.stay_room_price_max}" type="currency" /></c:if></dd>
                <hr />
            </dl>
        </div>

        <div class="mvs-btn"><a href="<%=request.getContextPath()%>/stayView.do?stay_no=${stay_no}">예약하기</a></div>
    </div>
    </c:if>

</div>



<jsp:include page="../layout/layout_footer.jsp" />