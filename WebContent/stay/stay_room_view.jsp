<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% long time = System.currentTimeMillis(); %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="room" value="${ roomView }" />
<c:set var="stay" value="${ stayView }" />
<c:set var="list" value="${ roomList }" />

<c:if test="${empty roomView}"><script>alert('잘못된 Room 번호입니다.'); history.back();</script></c:if>

<jsp:include page="../layout/layout_header.jsp" />
<script type="text/javascript">$("#nav-stay").addClass("now");</script>
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/asset/css/stay.css?<%=time%>" />
<script language="javascript" src="<%=request.getContextPath()%>/asset/js/stay.js?<%=time%>"></script>




<div class="container page-title">
    <h2>BOOKING</h2>
</div>




<div class="container stay-room">

    <!-- 상단 예약하기 //START -->
    <div class="sr-top">
        <h3 class="srt-name">${stay.stay_name}</h3>
        <div class="srt-date">날짜를 선택해주세요.</div>
        <c:choose>
            <c:when test="${empty login_id}"><button type="button" class="reserv-go" start="" end="" onclick="alert('회원 로그인 후 예약 할 수 있습니다.'); location.href='<%=request.getContextPath()%>/memberLogin.do';">예약하기</button></c:when>
            <c:otherwise><button type="button" class="reserv-go" start="" end="" onclick="reservGo(${stay.stay_no}, ${room.room_no});">예약하기</button></c:otherwise>
        </c:choose>
    </div>
    <!-- 상단 예약하기 //START -->




    <!-- Room 정보 //START -->
    <div class="sr-info">
        <div class="sri-left">
            <div class="tit">ROOM INFORMATION</div>
            <div class="name">${room.room_name}</div>
            <div class="price"><fmt:setLocale value="ko_kr" /><fmt:formatNumber value="${room.room_price}" type="currency" />~</div>
            <div class="txt">${room.room_desc}</div>
            <div class="etc">
                <div class="tag">
                    <c:forTokens items="${room.room_tag}" delims="," var="tag"><span>#${tag}</span></c:forTokens>
                </div>
                <div class="option">
                    <p>체크인 ${room.room_checkin} / 체크아웃 ${room.room_checkout}</p>
                    <p>기준 인원 <fmt:formatNumber value="${room.room_people_min}" />명 (최대 인원 <fmt:formatNumber value="${room.room_people_max}" />명)</p>
                    <p>객실면적 ${room.room_size}㎡</p>
                    <p>${room.room_bed}</p>
                </div>
            </div>
        </div>


        <div class="sri-right">
            <c:if test="${!empty room.room_photo1 or !empty room.room_photo2 or !empty room.room_photo3 or !empty room.room_photo4 or !empty room.room_photo5}">
            <div class="swiper-button-prev"><i class="fa fa-chevron-left"></i></div>
            <div class="swiper-button-next"><i class="fa fa-chevron-right"></i></div>
            <ul class="swiper-wrapper">
                <c:if test="${!empty room.room_photo1}"><li class="swiper-slide"><div class="img" style="background-image: url('<%=request.getContextPath()%>${room.room_photo1}');"></div></li></c:if>
                <c:if test="${!empty room.room_photo2}"><li class="swiper-slide"><div class="img" style="background-image: url('<%=request.getContextPath()%>${room.room_photo2}');"></div></li></c:if>
                <c:if test="${!empty room.room_photo3}"><li class="swiper-slide"><div class="img" style="background-image: url('<%=request.getContextPath()%>${room.room_photo3}');"></div></li></c:if>
                <c:if test="${!empty room.room_photo4}"><li class="swiper-slide"><div class="img" style="background-image: url('<%=request.getContextPath()%>${room.room_photo4}');"></div></li></c:if>
                <c:if test="${!empty room.room_photo5}"><li class="swiper-slide"><div class="img" style="background-image: url('<%=request.getContextPath()%>${room.room_photo5}');"></div></li></c:if>
            </ul>
            <script type="text/javascript">
            var visualSwiper = new Swiper(".stay-room .sr-info .sri-right", {
                effect: "slide",
                slidesPerView: 1,
                spaceBetween: 0,
                speed: 500,
                loop: true,
                touchEnabled: true,
                navigation: {
                    nextEl: '.stay-room .sr-info .sri-right .swiper-button-next',
                    prevEl: '.stay-room .sr-info .sri-right .swiper-button-prev',
                }
            });
            </script>
            </c:if>
        </div>
    </div>
    <!-- Room 정보 //START -->




    <!-- 서비스 정보 //START -->
    <div class="sr-service">
        <c:if test="${!empty room.room_features}">
        <div class="row">
            <div class="srs-tit">FEATURES</div>
            <ul class="srs-list">
                <c:forTokens items="${room.room_features}" delims="/" var="features"><li><i title="${features}"></i>${features}</li></c:forTokens>
            </ul>
        </div>
        </c:if>

        <c:if test="${!empty room.room_amenities}">
        <div class="row">
            <div class="srs-tit">AMENITIES</div>
            <ul class="srs-list">
                <c:forTokens items="${room.room_amenities}" delims="/" var="amenities"><li>${amenities}</li></c:forTokens>
            </ul>
        </div>
        </c:if>

        <c:if test="${!empty room.room_service}">
        <div class="row">
            <div class="srs-tit">ADD-ON SERVICES</div>
            <ul class="srs-list">
                <c:forTokens items="${room.room_service}" delims="/" var="service"><li>${service}</li></c:forTokens>
            </ul>
        </div>
        </c:if>
    </div>
    <!-- 서비스 정보 //START -->




    <!-- 하단 예약하기 //START -->
    <div class="sr-reserv">
        <c:choose>
            <c:when test="${empty login_id}"><button type="button" class="reserv-go" start="" end="" onclick="alert('회원 로그인 후 예약 할 수 있습니다.'); location.href='<%=request.getContextPath()%>/memberLogin.do';">예약하기</button></c:when>
            <c:otherwise><button type="button" class="reserv-go" start="" end="" onclick="reservGo(${stay.stay_no}, ${room.room_no});">예약하기</button></c:otherwise>
        </c:choose>
    </div>
    <!-- 하단 예약하기 //START -->



    <div class="clear"></div>



    <!-- 다른 Room //START -->
    <div class="sr-other">
        <div class="sro-title">OTHER ROOMS</div>
        <div class="sro-list">
            <c:if test="${list.size() > 4}">
            <button type="button" class="swiper-button-prev"><i class="fa fa-angle-left"></i></button>
            <button type="button" class="swiper-button-next"><i class="fa fa-angle-right"></i></button>
            </c:if>
            <ul class="swiper-wrapper<c:if test="${list.size() < 5}"> nomove</c:if>">
                <c:forEach items="${list}" var="list">
                <c:if test="${room.room_no != list.room_no}">
                <li class="swiper-slide">
                    <a href="<%=request.getContextPath()%>/stayRoom.do?stay_no=${stay.stay_no}&room_no=${list.room_no}">
                        <c:choose>
                            <c:when test="${!empty list.room_photo1}"><div class="img" style="background-image: url('<%=request.getContextPath()%>${ list.room_photo1 }');"></div></c:when>
                            <c:when test="${!empty list.room_photo2}"><div class="img" style="background-image: url('<%=request.getContextPath()%>${ list.room_photo2 }');"></div></c:when>
                            <c:when test="${!empty list.room_photo3}"><div class="img" style="background-image: url('<%=request.getContextPath()%>${ list.room_photo3 }');"></div></c:when>
                            <c:when test="${!empty list.room_photo4}"><div class="img" style="background-image: url('<%=request.getContextPath()%>${ list.room_photo4 }');"></div></c:when>
                            <c:when test="${!empty list.room_photo5}"><div class="img" style="background-image: url('<%=request.getContextPath()%>${ list.room_photo5 }');"></div></c:when>
                            <c:otherwise><div class="img none">no img</div></c:otherwise>
                        </c:choose>
                        <div class="name">${list.room_name}</div>
                        <div class="price">₩<fmt:formatNumber value="${list.room_price}" /></div>
                        <div class="people">최대 인원 ${list.room_people_max}명</div>
                        <div class="bed">${list.room_bed}</div>
                    </a>
                </li>
                </c:if>
                </c:forEach>
            </ul>
        </div>
    </div>
    <c:if test="${list.size() > 4}">
    <script type="text/javascript">
    var stayviewRoomSwiper = new Swiper(".stay-room .sr-other .sro-list", {
        effect: "slide",
        slidesPerView: 3,
        width: 1288,
        spaceBetween: 80,
        speed: 500,
        loop: true,
        touchEnabled: true,
        autoplay: false,
        navigation: {
            nextEl: '.stay-room .sr-other .sro-list .swiper-button-next',
            prevEl: '.stay-room .sr-other .sro-list .swiper-button-prev',
        }
    });
    </script>
    </c:if>
    <!-- 다른 Room //START -->

</div>




<!-- 숙소 안내사항 //START -->
<div class="container-full stay-view">
    <c:if test="${!empty stay.stay_info1 or !empty stay.stay_info2 or !empty stay.stay_info3}">
    <div class="sv-caution">
        <div class="container">
            <div class="faq_tit">
                <div class="left">안내사항</div>
                <div class="right">숙소 이용에 대한 상세한 안내를 확인해 보세요.</div>
            </div>

            <div class="faq_cont">
                <ul class="tab_btn">
                    <li num="1" class="active">예약 안내</li>
                    <li num="2">이용 안내</li>
                    <li num="3">환불규정</li>
                </ul>

                <div class="tab_cont">
                    <c:if test="${!empty stay.stay_info1}">${stay.stay_info1}</c:if>

                    <c:if test="${!empty stay.stay_info2}">${stay.stay_info2}</c:if>

                    <c:if test="${!empty stay.stay_info3}">${stay.stay_info3}</c:if>
                </div>
            </div>
        </div>
    </div>
    </c:if>
</div>
<!-- 숙소 안내사항 //START -->




<jsp:include page="../layout/layout_footer.jsp" />