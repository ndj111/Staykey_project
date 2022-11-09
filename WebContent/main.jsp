<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<% long time = System.currentTimeMillis(); %>
<jsp:include page="layout/layout_header.jsp" />
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/asset/css/main.css?<%=time%>" />
<script language="javascript" src="<%=request.getContextPath()%>/asset/js/main.js?<%=time%>"></script>


<c:set var="rStay" value="${ randomStay }"/>
<c:set var="rBanner" value="${ randomBanner }"/>
<c:set var="eList" value="${ eList }"/>
<c:set var="sList" value="${ sList }"/>
<c:set var="mList" value="${ magazineList }"/>
<c:set var="keyword" value="${ keyword }"/>
<c:set var="kStay" value="${ keywordStay }"/>



<div id="main-contents" class="main-contents">


    <c:if test="${!empty rStay }">
    <!-------- 메인 비주얼//START --------->
    <div class="container-wide">
        <div id="main-visual" class="main-visual">
            <ul class="swiper-wrapper">
                <c:forEach items="${ rStay }" var="list">
                <li class="swiper-slide">
                    <c:choose>
                    <c:when test="${ !empty list.stay_file1 }"><a href="<%=request.getContextPath()%>/stayView.do?stay_no=${ list.stay_no }" style="background-image: url('<%=request.getContextPath()%>${list.stay_file1}');"></c:when>
                    <c:when test="${ !empty list.stay_file2 }"><a href="<%=request.getContextPath()%>/stayView.do?stay_no=${ list.stay_no }" style="background-image: url('<%=request.getContextPath()%>${list.stay_file2}');"></c:when>
                    </c:choose>
                        <div class="mv-info">
                            <p class="tit">${ list.stay_name }</p>
                            <p class="sub">${ list.stay_desc }</p>
                        </div>
                    </a>
                </li>
                </c:forEach>
            </ul>
            <div class="swiper-button">
                <button type="button" class="swiper-button-prev"><i class="fa fa-angle-left"></i></button>
                <button type="button" class="swiper-button-next"><i class="fa fa-angle-right"></i></button>
            </div>
        </div>
    </div>
    <!-------- 메인 비주얼//END --------->




    <!-------- 새로운 경험//START --------->
    <div class="container main-new">
        <div class="mn-title">Stay:Key로 여는 새로운 경험</div>

        <div class="mn-container">
            <ul class="swiper-wrapper">
                <c:forEach items="${ rStay }" var="list">
                <li class="swiper-slide">
                    <c:if test="${ !empty list.stay_file2}"><a href="<%=request.getContextPath()%>/stayView.do?stay_no=${ list.stay_no }"><img src="<%=request.getContextPath()%>${list.stay_file2}" alt="${ list.stay_name }" /></c:if>
                        <p class="title">${ list.stay_name }</p>
                        <p class="subtitle">${ list.stay_location }</p>
                        <p class="other">${ list.stay_desc }</p>
                    </a>
                </li>
                </c:forEach>
            </ul>
        </div>
    </div>
    <!-------- 새로운 경험//END --------->
	</c:if>





    <c:if test="${!empty rBanner }">
    <!-------- 배너 //START --------->
    <div class="main-banner">
        <a href="<%=request.getContextPath()%>/stayView.do?stay_no=${rBanner.stay_no}" style="background-image: url('<%=request.getContextPath()%>${rBanner.stay_file1}');">
            <p>${rBanner.stay_name}</p>
            <small>${rBanner.stay_desc}</small>
        </a>
    </div>
    <!-------- 배너 //END --------->
    </c:if>




    <c:if test="${!empty eList }">
    <!-------- 프로모션 //START -------------->
    <div class="main-promo">
        <div class="mp-wrap container">
            <div class="swiper-pagination"></div>
            <div class="swiper-button-prev"><i class="fa fa-chevron-left"></i></div>
            <div class="swiper-button-next"><i class="fa fa-chevron-right"></i></div>
            <ul class="swiper-wrapper">
                <c:forEach var="elist" items="${eList}">
                <li class="swiper-slide">
                    <a href="<%=request.getContextPath()%>/eventView.do?bbs_no=${elist.bbs_no}">
                        <div class="e_info">
                            <p class="txt">PROMOTION</p>
                            <p class="tit">${elist.bbs_title}</p>
                            <c:if test="${!empty elist.bbs_stayname}"><p class="stay">${elist.bbs_stayname}</p></c:if>
                        </div>
                        <div class="e_img" style="background-image:url('<%=request.getContextPath()%>${elist.bbs_file1}');"><c:if test="${elist.bbs_showstart != 'N'}"><span>${elist.bbs_showstart} days<br />left!</span></c:if></div>
                    </a>
                </li>
                </c:forEach>
            </ul>
        </div>
    </div>
    <!-------- 프로모션 //END -------------->
    </c:if>





    <c:if test="${!empty sList }">
    <!-------- 이벤트 숙소 //START --------->
    <div class="container main-event">
        <h4 class="me-title">EVENT</h4>

        <div class="me-wrap">
            <div class="swiper-pagination"></div>
            <div class="swiper-button-prev"><i class="fa fa-chevron-left"></i></div>
            <div class="swiper-button-next"><i class="fa fa-chevron-right"></i></div>
            <ul class="swiper-wrapper">
                <c:forEach var="list" items="${sList}">
                <li class="swiper-slide">
                    <a href="<%=request.getContextPath()%>/stayView.do?stay_no=${list.stay_no}">
                        <c:if test="${!empty list.stay_photo}"><div class="e_img" style="background-image:url('<%=request.getContextPath()%>${list.stay_photo}');"><c:if test="${list.bbs_day != 'N'}"><span>${list.bbs_day} days<br />left!</span></c:if></div></c:if>
                        <div class="e_info">
                            <p class="stay">${list.stay_name}</p>
                            <p class="location">${list.stay_location}</p>
                            <p class="title">${list.bbs_title}</p>
                            <p class="more">자세히 보기</p>
                        </div>
                    </a>
                </li>
                </c:forEach>
            </ul>
        </div>
    </div>
    <!-------- 이벤트 숙소 //END --------->
    </c:if>





    <c:if test="${!empty mList }">
    <!-------- 매거진 //START --------->
    <div class="main-magazine">
        <div class="mm-wrap">
            <ul class="swiper-wrapper">
            	<c:forEach var="mgz" items="${ mList }">
                <li class="swiper-slide">
                    <a href="<%=request.getContextPath()%>/magazineView.do?bbs_no=${ mgz.bbs_no }" style="background-image: url('<%=request.getContextPath()%>${ mgz.bbs_top_img }');">
                        <div class="mm-info">
                            <p class="mag">MAGAZINE</p>
                            <p class="tit">
                                <c:forTokens items="${ mgz.bbs_title }" delims="<" var="title" begin="1" end="1">${ fn:substringBefore(title, ">") }</c:forTokens>
                                <span><c:forTokens items="${ mgz.bbs_title }" delims="<" var="desc" begin="0" end="0">${ desc }</c:forTokens></span>
                            </p>
                            <p class="more">Read more</p>
                        </div>
                    </a>
                </li>
                </c:forEach>
            </ul>
            <div class="swiper-button">
                <button type="button" class="swiper-button-prev"><i class="fa fa-angle-left"></i></button>
                <button type="button" class="swiper-button-next"><i class="fa fa-angle-right"></i></button>
            </div>
        </div>
    </div>
    <!-------- 매거진 //END --------->
    </c:if>



    <c:if test="${!empty rStay }">
    <!-------- 트래블 창 // START --------->
    <div class="container main-travel">
        <div class="sec-title">TRAVEL</div>
        <ul class="stay-list">
            <c:forEach items="${ rStay }" var="list" begin="0" end="5">
			<li class="stay-box">
                <c:choose>
                <c:when test="${ !empty list.stay_file3 }"><a href="<%=request.getContextPath()%>/stayView.do?stay_no=${ list.stay_no }"><img class="img" src="<%=request.getContextPath()%>${ list.stay_file3 }" /></c:when>
                <c:when test="${ !empty list.stay_file4 }"><a href="<%=request.getContextPath()%>/stayView.do?stay_no=${ list.stay_no }"><img class="img" src="<%=request.getContextPath()%>${ list.stay_file4 }" /></c:when>
                </c:choose>
                    <p class="text">${ list.stay_desc }</p>
                    <p class="other"><span>${ list.stay_location }</span></p>
                    <p class="more">Read more</p>
                </a>
			</li>
            </c:forEach>
        </ul>
    </div>
    <!-------- 트래블 //END --------->
    </c:if>





    <c:if test="${!empty kStay }">
    <!-------- 추천 지역 //START --------->
    <div class="main-recom">
        <h4 class="mr-title">
            <p>지금 바로 떠나는</p>
            <p><strong>${ keyword }</strong></p>
        </h4>

        <div class="container mr-wrap">
            <ul class="swiper-wrapper">
            	<c:forEach var="list" items="${ kStay }">
                <li class="swiper-slide">
                    <c:choose>
                    <c:when test="${ !empty list.stay_file4}"><a href="<%=request.getContextPath()%>/stayView.do?stay_no=${ list.stay_no }"><img src="<%=request.getContextPath()%>${list.stay_file4}" alt="${ list.stay_name }" /></c:when>
                    <c:when test="${ !empty list.stay_file5}"><a href="<%=request.getContextPath()%>/stayView.do?stay_no=${ list.stay_no }"><img src="<%=request.getContextPath()%>${list.stay_file5}" alt="${ list.stay_name }" /></c:when>
                    <c:when test="${ !empty list.stay_file1}"><a href="<%=request.getContextPath()%>/stayView.do?stay_no=${ list.stay_no }"><img src="<%=request.getContextPath()%>${list.stay_file1}" alt="${ list.stay_name }" /></c:when>
                    </c:choose>
                        <p class="title">${ list.stay_name }</p>
                        <p class="subtitle">${ list.stay_location }</p>
                        <p class="other">${ list.stay_desc }</p>
                    </a>
                </li>
				</c:forEach>                
            </ul>
        </div>
    </div>
    <!-------- 추천 지역 //END --------->
    </c:if>


</div>



<jsp:include page="layout/layout_footer.jsp" />