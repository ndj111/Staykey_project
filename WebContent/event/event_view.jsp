<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<% long time = System.currentTimeMillis(); %>
<jsp:include page="../layout/layout_header.jsp" />

<script type="text/javascript">$("#nav-event").addClass("now");</script>
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/asset/css/event.css?<%=time%>" />
<script language="javascript" src="<%=request.getContextPath()%>/asset/js/event.js?<%=time%>"></script>

<c:set var="view" value="${event}"/>
<c:set var="stay" value="${stayList}" />




<div class="event-view">


    <div class="container ev-title">
        <h3>${view.bbs_title.replace("<br />", "").replace("<br>", "")}<small>${view.bbs_stayname}</small></h3>
    </div>



    <!-- 상단 내용 //START -->
    <div class="container ev-top">
        <div class="evt-wrap clear">
            <div class="deal_img" style="background-image: url('<%=request.getContextPath()%>${view.bbs_file1}');"></div>
            ${view.bbs_content.replaceAll("스테이폴리오", "스테이:키")}
        </div>
    </div>
    <!-- 상단 내용 //START -->




    <!-- 등록 숙소 //START -->
    <c:if test="${!empty stay}">
    <div class="container ev-room">
        <div class="evr-title">Weekly Deals</div>

        <div class="evr-list">
            <ul class="swiper-wrapper">
                <c:forEach items="${stay}" var="list">
                <li class="swiper-slide">
                    <a href="<%=request.getContextPath()%>/stayView.do?stay_no=${list.stay_no}">
                        <c:choose>
                        <c:when test="${!empty list.stay_file1}"><div class="img" style="background-image: url('<%=request.getContextPath()%>${ list.stay_file1 }');"></div></c:when>
                        <c:otherwise><div class="img none">no img</div></c:otherwise>
                        </c:choose>
                        <div class="name">${list.stay_name}</div>
                        <div class="other">${list.stay_desc}</div>
                        <div class="link">예약하기</div>
                    </a>
                </li>
                </c:forEach>
            </ul>
        </div>
    </div>

    <script type="text/javascript">
    $(document).ready(function(){
        var visualSwiper = new Swiper(".event-view .ev-room .evr-list", {
            effect: "slide",
            slidesPerView: 3,
            spaceBetween: 0,
            speed: 500,
            loop: true,
            touchEnabled: false,
            autoplay: {
                delay: 3000,
                disableOnInteraction: false,
            }
        });
    });
    </script>
    </c:if>
    <!-- 등록 숙소 //END -->




    <!-- 내용 이미지 //START -->
    <c:if test="${!empty view.bbs_file2}">
    <div class="container ev-detail"><img src="<%=request.getContextPath()%>${view.bbs_file2}" alt="" /></div>
    </c:if>
    <!-- 내용 이미지 //END -->



    <!-- 안내사항 //START -->
    <div class="container ev-caution">
        <div class="evc-notice clear">
            <div class="title">안내사항</div>
            <ul class="cont">
                <li>- 스테이 별로 혜택 적용 조건이 다를 수 있습니다.</li>
                <li>- 할인 혜택의 경우 스테이에 따라 연박 할인이 적용되지 않을 수 있습니다.</li>
                <li>- 스테이에 따라 욕조 구비 유무가 다를 수 있으며 스테이 이용 관련 문의는 스테이 측으로 연락하시면 정확한 안내를 받으실 수 있습니다.</li>
            </ul>
        </div>
    </div>
    <!-- 안내사항 //END -->
</div>




<jsp:include page="../layout/layout_footer.jsp" />