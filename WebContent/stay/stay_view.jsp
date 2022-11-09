<%@page import="com.model.WishDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% long time = System.currentTimeMillis(); %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="view" value="${stayView}" />
<c:set var="list" value="${roomList}" />

<jsp:include page="../layout/layout_header.jsp" />
<script type="text/javascript">$("#nav-stay").addClass("now");</script>
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/asset/css/stay.css?<%=time%>" />
<script language="javascript" src="<%=request.getContextPath()%>/asset/js/stay.js?<%=time%>"></script>




<div class="container-full stay-view">

    <h2 class="sv-name">${view.stay_name}</h2>


    <!-- 숙소 상단정보 //START -->
    <div class="sv-top">
        <div class="svt-info">
            <div class="name">${view.stay_name}<small>${view.stay_location}</small></div>
            <div class="desc">${view.stay_desc}</div>

            <button type="button" class="wish<c:if test="${wishChk == 'Y'}"> on</c:if>" onclick="stayWish(this, '${view.stay_no}', '${login_id}');"><i class="fa fa-heart<c:if test="${wishChk == 'N'}">-o</c:if>"></i> 찜하기</button>
        </div>

        <div class="svt-photo">
            <button type="button" class="swiper-button-prev"><i class="fa fa-angle-left"></i></button>
            <button type="button" class="swiper-button-next"><i class="fa fa-angle-right"></i></button>
            <ul class="swiper-wrapper">
                <c:if test="${!empty view.stay_file1}"><li class="swiper-slide"><div class="img" style="background-image: url('<%=request.getContextPath()%>${view.stay_file1}');"></div></li></c:if>
                <c:if test="${!empty view.stay_file2}"><li class="swiper-slide"><div class="img" style="background-image: url('<%=request.getContextPath()%>${view.stay_file2}');"></div></li></c:if>
                <c:if test="${!empty view.stay_file3}"><li class="swiper-slide"><div class="img" style="background-image: url('<%=request.getContextPath()%>${view.stay_file3}');"></div></li></c:if>
                <c:if test="${!empty view.stay_file4}"><li class="swiper-slide"><div class="img" style="background-image: url('<%=request.getContextPath()%>${view.stay_file4}');"></div></li></c:if>
                <c:if test="${!empty view.stay_file5}"><li class="swiper-slide"><div class="img" style="background-image: url('<%=request.getContextPath()%>${view.stay_file5}');"></div></li></c:if>
            </ul>
        </div>
    </div>
    <!-- 숙소 상단정보 //START -->



    <!-- 숙소 Room목록 //START -->
    <div class="sv-room">
        <div class="svr-info container">
            <div class="tit">ROOMS</div>
            <div class="txt">${view.stay_desc}</div>
            <c:if test="${list.size() > 2}">
            <div class="swiper-button">
                <button type="button" class="swiper-button-prev"><i class="fa fa-angle-left"></i></button>
                <button type="button" class="swiper-button-next"><i class="fa fa-angle-right"></i></button>
            </div>
            </c:if>
        </div>


        <div class="svr-list<c:if test="${list.size() <= 2}"> nomore</c:if>">
            <ul class="swiper-wrapper">
                <c:choose>
                <c:when test="${!empty list}">
                <c:forEach items="${list}" var="room">
                <li class="swiper-slide">
                    <c:choose>
                        <c:when test="${!empty room.room_photo1}"><a href="<%=request.getContextPath()%>/stayRoom.do?stay_no=${view.stay_no}&room_no=${room.room_no}" style="background-image: url('<%=request.getContextPath()%>${room.room_photo1}');"></c:when>
                        <c:when test="${!empty room.room_photo2}"><a href="<%=request.getContextPath()%>/stayRoom.do?stay_no=${view.stay_no}&room_no=${room.room_no}" style="background-image: url('<%=request.getContextPath()%>${room.room_photo2}');"></c:when>
                        <c:when test="${!empty room.room_photo3}"><a href="<%=request.getContextPath()%>/stayRoom.do?stay_no=${view.stay_no}&room_no=${room.room_no}" style="background-image: url('<%=request.getContextPath()%>${room.room_photo3}');"></c:when>
                        <c:when test="${!empty room.room_photo4}"><a href="<%=request.getContextPath()%>/stayRoom.do?stay_no=${view.stay_no}&room_no=${room.room_no}" style="background-image: url('<%=request.getContextPath()%>${room.room_photo4}');"></c:when>
                        <c:when test="${!empty room.room_photo5}"><a href="<%=request.getContextPath()%>/stayRoom.do?stay_no=${view.stay_no}&room_no=${room.room_no}" style="background-image: url('<%=request.getContextPath()%>${room.room_photo5}');"></c:when>
                        <c:otherwise><a href="<%=request.getContextPath()%>/stayRoom.do?stay_no=${view.stay_no}&room_no=${room.room_no}"></c:otherwise>
                    </c:choose>
                        <div class="room-info">
                            <p class="name">${room.room_name}<small>${room.room_type}</small></p>
                            <p class="price">₩<fmt:formatNumber value="${room.room_price}" /> ~</p>
                            <p class="etc">
                                <span>기준 ${room.room_people_min}명 (최대 ${room.room_people_max}명)</span>
                                <span>${room.room_bed}</span>
                            </p>
                            <p class="reserv">예약하기</p>
                        </div>
                    </a>
                </li>
                </c:forEach>
                </c:when>

                <c:otherwise>
                <li class="nodata">이 숙소에 등록된 Room이 없습니다.</li>
                </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>

    <c:if test="${list.size() > 2}">
    <script type="text/javascript">
    var stayviewRoomSwiper = new Swiper(".stay-view .sv-room .svr-list", {
        effect: "slide",
        slidesPerView: 2,
        width: 970,
        spaceBetween: 50,
        speed: 500,
        loop: true,
        touchEnabled: true,
        autoplay: false,
        navigation: {
            nextEl: '.stay-view .sv-room .svr-info .swiper-button .swiper-button-next',
            prevEl: '.stay-view .sv-room .svr-info .swiper-button .swiper-button-prev',
        }
    });
    </script>
    </c:if>
    <!-- 숙소 Room목록 //START -->





    <!-- 숙소 상세정보 //START -->
    <c:if test="${!empty view.stay_content1 or !empty view.stay_content2 or !empty view.stay_content3}">
    <div class="sv-detail">

        <div class="stay-view-cont">
            <!-- 내용 컨텐츠 1 (소개) //start -->
            <c:if test="${!empty view.stay_content1}">
            <div>${view.stay_content1}</div>
            </c:if>
            <!-- 내용 컨텐츠 1 (소개) //end -->


            <!-- 내용 컨텐츠 2 (스페셜) //start -->
            <c:if test="${!empty view.stay_content2}">
            <div>${view.stay_content2}</div>
            </c:if>
            <!-- 내용 컨텐츠 2 (스페셜) //end -->


            <!-- 내용 컨텐츠 3 (구글맵) //start -->
            <c:if test="${!empty view.stay_content3}">
            <div class="fdetail_map">
                <div class="map_tit">
                    <div class="title">
                        <p>HELLO.</p>
                        <p>${view.stay_name}</p>
                    </div>
                    <div class="desc">
                        <p>${view.stay_addr}</p>
                        <p>${view.stay_phone}</p>
                        <p>${view.stay_email}</p>
                    </div>
                </div>
                ${view.stay_content3}
            </div>
            </c:if>
            <!-- 내용 컨텐츠 3 (구글맵) //end -->
        </div>

    </div>
    </c:if>
    <!-- 숙소 상세정보 //START -->





    <!-- 숙소 안내사항 //START -->
    <c:if test="${!empty view.stay_info1 or !empty view.stay_info2 or !empty view.stay_info3}">
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
                    <c:if test="${!empty view.stay_info1}">${view.stay_info1}</c:if>

                    <c:if test="${!empty view.stay_info2}">${view.stay_info2}</c:if>

                    <c:if test="${!empty view.stay_info3}">${view.stay_info3}</c:if>
                </div>
            </div>
        </div>
    </div>
    </c:if>
    <!-- 숙소 안내사항 //START -->

</div>




<jsp:include page="../layout/layout_footer.jsp" />