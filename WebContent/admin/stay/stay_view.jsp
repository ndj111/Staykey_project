<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../layout/layout_header.jsp" />

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="view" value="${stayView}" />
<c:set var="list" value="${roomList}" />

<c:if test="${empty view}"><script>alert('잘못된 숙소 번호입니다.'); history.back();</script></c:if>
<script type="text/javascript">$("#nav-stay").addClass("now");</script>
<div class="d-flex justify-content flex-wrap flex-md-nowrap align-items-center pt-4 pb-2 mb-4 border-bottom">
    <h2>숙소 상세 정보</h2>
    <small>등록된 숙소 정보를 확인 할 수 있습니다.</small>
</div>

${ msg }
<c:remove var="msg"/>

<div class="view-form">
    <!-- 내용 //START -->
    <div class="row vf-body">
        <div class="col-lg mb-4">
            <div class="card">
                <div class="card-body p-4">

                    <h2>
                    	<p>${view.stay_name}</p>
                    	<span>${view.stay_desc}</span>
                   	</h2>

                    <div class="d-flex py-2 border-bottom vfb-info">
                        <div class="col text-left">
                        	<i class="icon-location-pin"></i> ${view.stay_location}
                        	<i class="icon-map ml-3"></i> ${view.stay_addr}
                        </div>

                        <div class="col text-right">
                        	<i class="icon-phone"></i> 전화 : ${view.stay_phone}
                        	<i class="icon-paper-plane ml-3"></i> 이메일 : ${view.stay_email}
                        </div>
                    </div>

                    <div class="d-flex py-2 border-bottom vfb-info">
                        <div class="col text-left">
                        	<i class="icon-magnifier"></i> 조회 <b><fmt:formatNumber value="${view.stay_hit}" /></b>
                        	<i class="icon-plane ml-3"></i> 예약 : <b><fmt:formatNumber value="${view.stay_reserv}" /></b>
                        </div>

                        <div class="col text-right">
                        	<i class="icon-calendar"></i> 등록일 : ${view.stay_date}
                        </div>
                    </div>


                    <c:if test="${!empty view.stay_file1 or !empty view.stay_file2 or !empty view.stay_file3 or !empty view.stay_file4 or !empty view.stay_file5}">
                    <div class="d-flex pt-4 pb-5 border-bottom">
                        <div class="col">
                            <div id="stay-view-photo">
                                <div class="swiper-button-prev"><i class="fa fa-chevron-left"></i></div>
                                <div class="swiper-button-next"><i class="fa fa-chevron-right"></i></div>
                                <ul class="swiper-wrapper">
                                    <c:if test="${!empty view.stay_file1}"><li class="swiper-slide"><div class="img" style="background-image: url('<%=request.getContextPath()%>${view.stay_file1}');"></div></li></c:if>
                                    <c:if test="${!empty view.stay_file2}"><li class="swiper-slide"><div class="img" style="background-image: url('<%=request.getContextPath()%>${view.stay_file2}');"></div></li></c:if>
                                    <c:if test="${!empty view.stay_file3}"><li class="swiper-slide"><div class="img" style="background-image: url('<%=request.getContextPath()%>${view.stay_file3}');"></div></li></c:if>
                                    <c:if test="${!empty view.stay_file4}"><li class="swiper-slide"><div class="img" style="background-image: url('<%=request.getContextPath()%>${view.stay_file4}');"></div></li></c:if>
                                    <c:if test="${!empty view.stay_file5}"><li class="swiper-slide"><div class="img" style="background-image: url('<%=request.getContextPath()%>${view.stay_file5}');"></div></li></c:if>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <script type="text/javascript">
                    $(document).ready(function(){
                        var visualSwiper = new Swiper("#stay-view-photo", {
                            effect: "slide",
                            slidesPerView: 1,
                            spaceBetween: 0,
                            speed: 500,
                            loop: true,
                            touchEnabled: false,
                            autoplay: {
                                delay: 3000,
                                disableOnInteraction: false,
                            },
                            navigation: {
                                nextEl: '#stay-view-photo .swiper-button-next',
                                prevEl: '#stay-view-photo .swiper-button-prev',
                            }
                        });
                    });
                    </script>
                    </c:if>


                    <c:if test="${!empty view.stay_option1_name or !empty view.stay_option2_name or !empty view.stay_option3_name}">
                    <div class="d-flex pt-5 pb-4">
                        <div class="col">
                        	<ul class="stay-view-option">
                        		<c:if test="${!empty view.stay_option1_name}">
                        		<li>
                        			<div>
				                        <c:choose>
				                        <c:when test="${!empty view.stay_option1_photo}"><img src="<%=request.getContextPath()%>${view.stay_option1_photo}" width="200" height="140" alt="" /></c:when>
				                        <c:otherwise>
				                        <svg class="bd-placeholder-img" width="200" height="140" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false" role="img">
				                            <title>${view.stay_name}</title>
				                            <rect width="100%" height="100%" fill="#eee"></rect>
				                            <text x="48%" y="54%" fill="#888" dy=".1em">no img</text>
				                        </svg>
				                        </c:otherwise>
				                        </c:choose>
                        			</div>
                        			<div class="pl-2">
                        				<p><b>${view.stay_option1_name}</b></p>
                        				<p>${view.stay_option1_desc}</p>
                        				<p><fmt:formatNumber value="${view.stay_option1_price}" />원</p>
                        			</div>
                        		</li>
                        		</c:if>

                        		<c:if test="${!empty view.stay_option2_name}">
                        		<li>
                        			<div>
				                        <c:choose>
				                        <c:when test="${!empty view.stay_option2_photo}"><img src="<%=request.getContextPath()%>${view.stay_option2_photo}" width="200" height="140" alt="" /></c:when>
				                        <c:otherwise>
				                        <svg class="bd-placeholder-img" width="200" height="140" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false" role="img">
				                            <title>${view.stay_name}</title>
				                            <rect width="100%" height="100%" fill="#eee"></rect>
				                            <text x="48%" y="54%" fill="#888" dy=".1em">no img</text>
				                        </svg>
				                        </c:otherwise>
				                        </c:choose>
                        			</div>
                        			<div class="pl-2">
                        				<p><b>${view.stay_option2_name}</b></p>
                        				<p>${view.stay_option2_desc}</p>
                        				<p><fmt:formatNumber value="${view.stay_option2_price}" />원</p>
                        			</div>
                        		</li>
                        		</c:if>

                        		<c:if test="${!empty view.stay_option3_name}">
                        		<li>
                        			<div>
				                        <c:choose>
				                        <c:when test="${!empty view.stay_option3_photo}"><img src="<%=request.getContextPath()%>${view.stay_option3_photo}" width="200" height="140" alt="" /></c:when>
                                        <c:otherwise>
                                        <svg class="bd-placeholder-img" width="200" height="140" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false" role="img">
                                            <title>${view.stay_name}</title>
                                            <rect width="100%" height="100%" fill="#eee"></rect>
                                            <text x="48%" y="54%" fill="#888" dy=".1em">no img</text>
                                        </svg>
                                        </c:otherwise>
				                        </c:choose>
                        			</div>
                        			<div class="pl-2">
                        				<p><b>${view.stay_option3_name}</b></p>
                        				<p>${view.stay_option3_desc}</p>
                        				<p><fmt:formatNumber value="${view.stay_option3_price}" />원</p>
                        			</div>
                        		</li>
                        		</c:if>
                        	</ul>
                        </div>
                    </div>
                    </c:if>

                </div>
            </div>
        </div>
    </div>
    <!-- 내용 //END -->



    <!-- 등록된 Room //START -->
    <div class="row vf-body">
        <div class="col-lg mb-4">
            <div class="card">
                <div class="card-body p-4">
                	<h4>등록된 Room 목록<button type="button" onclick="popWindow('<%=request.getContextPath()%>/admin/stayRoomWrite.do?stay_no=${ view.stay_no }', '700', '900');" class="btn btn-sm btn-primary float-right"><i class="fa fa-plus"></i> Room 추가</button></h4>
                	<ul class="stay-room-list justify-content-center">
                        <c:choose>
                        <c:when test="${ !empty list }">
                        <c:forEach items="${ list }" var="room">
                        <li>
                            <c:choose>
                                <c:when test="${!empty room.room_photo1}"><a href="javascript:popWindow('<%=request.getContextPath()%>/admin/stayRoomView.do?room_no=${ room.room_no }&stay_no=${ view.stay_no }', '1400', '900');" style="background-image: url('<%=request.getContextPath()%>${room.room_photo1}');"></c:when>
                                <c:when test="${!empty room.room_photo2}"><a href="javascript:popWindow('<%=request.getContextPath()%>/admin/stayRoomView.do?room_no=${ room.room_no }&stay_no=${ view.stay_no }', '1400', '900');" style="background-image: url('<%=request.getContextPath()%>${room.room_photo2}');"></c:when>
                                <c:when test="${!empty room.room_photo3}"><a href="javascript:popWindow('<%=request.getContextPath()%>/admin/stayRoomView.do?room_no=${ room.room_no }&stay_no=${ view.stay_no }', '1400', '900');" style="background-image: url('<%=request.getContextPath()%>${room.room_photo3}');"></c:when>
                                <c:when test="${!empty room.room_photo4}"><a href="javascript:popWindow('<%=request.getContextPath()%>/admin/stayRoomView.do?room_no=${ room.room_no }&stay_no=${ view.stay_no }', '1400', '900');" style="background-image: url('<%=request.getContextPath()%>${room.room_photo4}');"></c:when>
                                <c:when test="${!empty room.room_photo5}"><a href="javascript:popWindow('<%=request.getContextPath()%>/admin/stayRoomView.do?room_no=${ room.room_no }&stay_no=${ view.stay_no }', '1400', '900');" style="background-image: url('<%=request.getContextPath()%>${room.room_photo5}');"></c:when>
                                <c:otherwise><a href="javascript:popWindow('<%=request.getContextPath()%>/admin/stayRoomView.do?room_no=${ room.room_no }&stay_no=${ view.stay_no }', '1400', '900');"></c:otherwise>
                            </c:choose>
                                <div class="room-info">
                                    <p class="name">${ room.room_name }<small>${ room.room_type }</small></p>
                                    <p class="price">₩<fmt:formatNumber value="${ room.room_price }" /> ~</p>
                                    <p class="etc">
                                        <span>기준 ${ room.room_people_min }명 (최대 ${ room.room_people_max }명)</span>
                                        <span>${ room.room_bed }</span>
                                    </p>
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
        </div>
    </div>
    <!-- 등록된 Room //END -->




    <!-- 버튼 //START -->
    <div class="d-flex justify-content-center mt-4 mb-5">
        <a href="<%=request.getContextPath()%>/admin/stayDeleteOk.do?stay_no=${view.stay_no}" class="btn btn-danger" onclick="return confirm('정말 삭제하시겠습니까?\n※ 이 숙소에 등록된 Room들도 전부 삭제됩니다.');"><i class="fa fa-trash-o"></i> 삭제하기</a>
        <a href="<%=request.getContextPath()%>/admin/stayModify.do?stay_no=${view.stay_no}" class="btn btn-success mx-2"><i class="fa fa-save"></i> 수정하기</a>
        <a href="<%=request.getContextPath()%>/admin/stayList.do" class="btn btn-secondary"><i class="fa fa-bars"></i> 목록보기</a>
    </div>
    <!-- 버튼 //END -->




    <!-- 컨텐츠 //START -->
    <c:if test="${!empty view.stay_content1 or !empty view.stay_content2 or !empty view.stay_content3}">
    <div class="row vf-body">
        <div class="col-lg mb-4">
            <div class="card">
                <div class="card-body px-4 pt-0">

                    <div class="stay-view-cont">
                    	<c:if test="${!empty view.stay_content1}">
                    	<div>${view.stay_content1}</div>
                    	</c:if>

                    	<c:if test="${!empty view.stay_content2}">
                    	<div>${view.stay_content2}</div>
                    	</c:if>

                    	<c:if test="${!empty view.stay_content3}">
                    	<div class="container_full fdetail_map">${view.stay_content3}</div>
                    	</c:if>
                    </div>

                </div>
            </div>
        </div>
    </div>
	</c:if>
    <!-- 컨텐츠 //END -->



    <!-- 안내사항 //START -->
    <c:if test="${!empty view.stay_info1 or !empty view.stay_info2 or !empty view.stay_info3}">
    <div class="row vf-body">
        <div class="col-lg my-4">
            <div class="card">
                <div class="card-body px-4 py-0" style="background: #000;">

                    <div class="stay-view-faq">
                    	<c:if test="${!empty view.stay_info1}">
                    	<div>${view.stay_info1}</div>
                    	</c:if>

                    	<c:if test="${!empty view.stay_info2}">
                    	<div>${view.stay_info2}</div>
                    	</c:if>

                    	<c:if test="${!empty view.stay_info3}">
                    	<div>${view.stay_info3}</div>
                    	</c:if>
                    </div>

                </div>
            </div>
        </div>
    </div>
	</c:if>
    <!-- 안내사항 //END -->
</div>



<jsp:include page="../layout/layout_footer.jsp" />