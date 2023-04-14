<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% long time = System.currentTimeMillis(); %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="stayList" value="${ stayList }" />
<c:set var="stayType" value="${ stayType }" />

<jsp:include page="../layout/layout_header.jsp" />
<script type="text/javascript">$("#nav-stay").addClass("now");</script>
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/asset/css/stay.css?<%=time%>" />
<script language="javascript" src="<%=request.getContextPath()%>/asset/js/stay.js?<%=time%>"></script>

<div class="container page-title">
    <h2>find stay</h2>
    <h4>머무는 것 자체로 여행이 되는 공간</h4>
</div>


<div class="container stay-search">
    <form name="stay_search" method="post" action="<%=request.getContextPath()%>/stayList.do">
    <div class="row">
        <div class="col-auto">
            <label for="ps_stay">여행지/숙소</label>
            <input type="text" name="ps_stay" id="ps_stay" value="${ map.ps_stay }" class="ss-input" />
        </div>
        <div class="col-auto">
            <label for="ps_start">체크인</label>
            <c:choose>
	            <c:when test="${ empty map.ps_start }">
	            <button type="button" class="ss-button" id="ps_start">선택하세요</button>
	            </c:when>
	            <c:otherwise>
	            <button type="button" class="ss-button" id="ps_start">
	            <fmt:parseDate value="${ map.ps_start }" var="startDate" pattern="yyyy-MM-dd"/>
	            <fmt:formatDate pattern="yyyy. MM. dd" value="${ startDate }"/></button>           
	            </c:otherwise>
            </c:choose>
            <input type="hidden" name="ps_start" value="${ map.ps_start }" />
        </div>
        <div class="col-auto">
            <label for="ps_end">체크아웃</label>
            <c:choose>
	            <c:when test="${ empty map.ps_end }">
	            <button type="button" class="ss-button" id="ps_end">선택하세요</button>
	            </c:when>
	            <c:otherwise>
	            <button type="button" class="ss-button" id="ps_end">
	            <fmt:parseDate value="${ map.ps_end }" var="endDate" pattern="yyyy-MM-dd"/>
	            <fmt:formatDate pattern="yyyy. MM. dd" value="${ endDate }"/></button>           
	            </c:otherwise>
            </c:choose>
            <input type="hidden" name="ps_end" value="${ map.ps_end }" />
        </div>
        <a href="<%=request.getContextPath()%>/stayList.do" class="ss-reset"><i class="fa fa-refresh"></i></a>
    </div>

    <div class="row">
        <div class="col-auto">
            <label for="ps_people">인원</label>
            <c:choose>
	            <c:when test="${ map.ps_people_adult == 0 && map.ps_people_kid == 0 && map.ps_people_baby == 0 }">
	            <button type="button" class="ss-button" id="ps_people" >선택하세요</button>
				</c:when>
				<c:otherwise>
	            <button type="button" class="ss-button" id="ps_people" >성인 : ${map.ps_people_adult}, 아동 : ${map.ps_people_kid}, 영아 : ${map.ps_people_baby}</button>
				</c:otherwise>
			</c:choose>
            <div id="selectNumber" class="layer-select">
                <button type="button" class="btn-close"></button>
                <div class="tit">인원</div>
                <dl>
                    <dt><span>성인</span></dt>
                    <dd>
                        <div class="number-count">
                            <button type="button" class="btn-minus"><i class="fa fa-minus"></i></button>
                            <span class="input-num">
                            	<c:if test="${ empty map.ps_people_adult }">
                                <input type="number" name="ps_people_adult" value="0" min="0" max="30" />
                                </c:if>
                                <c:if test="${ !empty map.ps_people_adult }">
                                <input type="number" name="ps_people_adult" value="${ map.ps_people_adult }" min="0" max="30" />
                                </c:if>                                     
                                <span class="person-count">명</span>
                            </span>
                            <button type="button" class="btn-plus"><i class="fa fa-plus"></i></button>
                        </div>
                    </dd>
                    <dt><span>아동<small>24개월~12세</small></span></dt>
                    <dd>
                        <div class="number-count">
                            <button type="button" class="btn-minus"><i class="fa fa-minus"></i></button>
                            <span class="input-num">
                            	<c:if test="${ empty map.ps_people_kid }">
                                <input type="number" name="ps_people_kid" value="0" min="0" max="7" />
                                </c:if>
                                <c:if test="${ !empty map.ps_people_kid }">
                                <input type="number" name="ps_people_kid" value="${ map.ps_people_kid }" min="0" max="7" />
                                </c:if>
                                <span class="person-count">명</span>
                            </span>
                            <button type="button" class="btn-plus"><i class="fa fa-plus"></i></button>
                        </div>
                    </dd>
                    <dt><span>영아<small>24개월 미만</small></span></dt>
                    <dd>
                        <div class="number-count">
                            <button type="button" class="btn-minus"><i class="fa fa-minus"></i></button>
                            <span class="input-num">
                            	<c:if test="${ empty map.ps_people_baby }">
                                <input type="number" name="ps_people_baby" value="0" min="0" max="7" />
                                </c:if>
                                <c:if test="${ !empty map.ps_people_baby }">
                                <input type="number" name="ps_people_baby" value="${ map.ps_people_baby }" min="0" max="7" />
                                </c:if>                                
                                <span class="person-count">명</span>
                            </span>
                            <button type="button" class="btn-plus"><i class="fa fa-plus"></i></button>
                        </div>
                    </dd>
                </dl>
                <div class="btn-wrapper"><button type="button" class="btn-number-search">적용하기</button></div>
            </div>
        </div>


        <div class="col-auto">
            <label for="ps_price">가격범위</label>
            <c:choose>
	            <c:when test="${ map.ps_price_min == 0 && map.ps_price_max == 100 }">
	            <button type="button" class="ss-button" id="ps_price" >전체</button>
	            </c:when>
	            <c:otherwise>
	            <button type="button" class="ss-button" id="ps_price" >
	            <fmt:formatNumber value="${ map.ps_price_min*10000 }"></fmt:formatNumber> ~ <fmt:formatNumber value="${ map.ps_price_max*10000 }"></fmt:formatNumber>
	            </button>
	            </c:otherwise>
			</c:choose>
            <div id="selectPrice" class="layer-select">
                <button type="button" class="btn-close"></button>
                <div class="tit">가격 범위</div>
                <div class="price-input">
                    <div class="input">
                        <small>최저요금</small>                
                        <span>
                        <c:if test="${ empty map.ps_price_min }"><input type="text" name="ps_price_min" value="10" onkeyup="NumberInput(this);" /></c:if>
                        <c:if test="${ !empty map.ps_price_min }"><input type="text" name="ps_price_min" value="${ map.ps_price_min }" onkeyup="NumberInput(this);" /></c:if>만원</span>
                    </div>
                    <span class="divider">-</span>
                    <div class="input">
                        <small>최고요금</small>
                        <span>
                        <c:if test="${ empty map.ps_price_max }"><input type="text" name="ps_price_max" value="100" onkeyup="NumberInput(this);" /></c:if>
                        <c:if test="${ !empty map.ps_price_max }"><input type="text" name="ps_price_max" value="${ map.ps_price_max }" onkeyup="NumberInput(this);" /></c:if>만원</span>
                    </div>
                </div>
                <div class="btn-wrapper"><button type="button" class="btn-number-search">적용하기</button></div>
            </div>
        </div>


        <div class="col-auto">
            <label for="ps_type">스테이 유형</label>
            <c:choose>
	            <c:when test="${ map.ps_type.contains('all') }">
	            <button type="button" class="ss-button" id="ps_type">전체</button>
	            </c:when>        
	            <c:otherwise>
	            <button type="button" class="ss-button" id="ps_type">${wType}</button> 
		        </c:otherwise>
			</c:choose>
            <div id="selectType" class="layer-select">
                <button type="button" class="btn-close">닫기</button>
                <div class="tit">스테이 유형</div>
                <div class="btn-wrapper"><button type="button" class="btn-number-search">적용하기</button></div>
                <ul class="check-list">
                    <li>
                        <label>
                            <input type="checkbox" name="ps_type" value="all" <c:if test="${map.ps_type.contains('all')}"> checked="checked"</c:if> />                            
                            <span>전체</span>
                        </label>
                    </li>
                    <c:forEach var="stype" items="${stayType}">
                    <li>
                        <label>
                            <input type="checkbox" name="ps_type" value="${stype}" <c:if test="${map.ps_type.contains(stype)}"> checked="checked"</c:if> />
                            <span>${stype}</span>
                        </label>
                    </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>

    <button type="submit">SEARCH <i class="icon-arrow-right"></i></button>
    </form>
</div>


<!-- ps_order -->
<c:set var="ps_link" value="stayList.do?ps_stay=${map.ps_stay}&ps_start=${map.ps_start}&ps_end=${map.ps_end}&ps_people_adult=${map.ps_people_adult}&ps_people_kid=${map.ps_people_kid}&ps_people_baby=${map.ps_people_baby}&ps_price_min=${map.ps_price_min}&ps_price_max=${map.ps_price_max}&ps_type=${map.ps_type}&ps_order=" />

<ul class="container stay-order">
    <li><a href="${ ps_link }reserv_desc"<c:choose><c:when test="${map.ps_order == 'reserv_desc'}"> class="now"</c:when><c:when test="${map.ps_order == 'no_desc'}"> class="now"</c:when></c:choose>>추천순</a></li>
    <li><a href="${ ps_link }date_desc"<c:if test="${map.ps_order == 'date_desc'}"> class="now"</c:if>>최신순</a></li>
    <li><a href="${ ps_link }hit_desc"<c:if test="${map.ps_order == 'hit_desc'}"> class="now"</c:if>>인기순</a></li>
    <li><a href="${ ps_link }room_price_max_desc"<c:if test="${map.ps_order == 'room_price_max_desc'}"> class="now"</c:if>>높은 가격순</a></li>
    <li><a href="${ ps_link }room_price_min_asc"<c:if test="${map.ps_order == 'room_price_min_asc'}"> class="now"</c:if>>낮은 가격순</a></li>
</ul>


<div class="container stay-list">
    <ul class="sl-wrap">
    <c:choose>
        <c:when test="${!empty stayList }">
        <c:forEach items="${stayList}" var="list">
        <li id="stay_${list.stay_no}">
            <button type="button" class="slw-wish<c:if test="${list.stay_wish_check == 'Y'}"> on</c:if>" onclick="addWish(this, '${list.stay_no}', '${login_id}');"><i class="fa fa-heart<c:if test="${list.stay_wish_check == 'N'}">-o</c:if>"></i></button>

            <a href="<%=request.getContextPath()%>/stayView.do?stay_no=${list.stay_no}">
                <div class="slw-name">${list.stay_name}<span>${list.stay_type}</span></div>
                <div class="clear"></div>
                <div class="slw-info">
                    <p class="address">${list.stay_location}</p>
                    <c:if test="${list.stay_room_people_min > 0}"><p class="people">기준 ${list.stay_room_people_min}명 (최대 ${list.stay_room_people_max}명)</p></c:if>
                    <c:if test="${list.stay_room_price_min > 0}">
                    <p class="price">
                        <fmt:setLocale value="ko_kr" /><fmt:formatNumber value="${list.stay_room_price_min}" type="currency" /> ~ 
                        <c:if test="${list.stay_room_price_min != list.stay_room_price_max}"><fmt:setLocale value="ko_kr" /><fmt:formatNumber value="${list.stay_room_price_max}" type="currency" /></c:if>
                    </p>
                    </c:if>
                    <p class="reserv">예약하기</p>
                </div>

                <c:choose>
                    <c:when test="${!empty list.stay_file1}"><div class="slw-photo" style="background-image: url('<%=request.getContextPath()%>${list.stay_file1}');"></div></c:when>
                    <c:when test="${!empty list.stay_file2}"><div class="slw-photo" style="background-image: url('<%=request.getContextPath()%>${list.stay_file2}');"></div></c:when>
                    <c:when test="${!empty list.stay_file3}"><div class="slw-photo" style="background-image: url('<%=request.getContextPath()%>${list.stay_file3}');"></div></c:when>
                    <c:when test="${!empty list.stay_file4}"><div class="slw-photo" style="background-image: url('<%=request.getContextPath()%>${list.stay_file4}');"></div></c:when>
                    <c:when test="${!empty list.stay_file5}"><div class="slw-photo" style="background-image: url('<%=request.getContextPath()%>${list.stay_file5}');"></div></c:when>
                </c:choose>
            </a>
        </li>
        </c:forEach>
        </c:when>

        <c:otherwise>
        <li class="nodata">등록된 숙소가 없습니다.</li>
        </c:otherwise>
    </c:choose>
    </ul>
</div>



${map.pagingWrite}




<jsp:include page="../layout/layout_footer.jsp" />