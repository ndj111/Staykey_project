<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% long time = System.currentTimeMillis(); %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("newLine", "\n"); %>

<c:set var="room" value="${ roomView }" />
<c:set var="stay" value="${ stayView }" />

<jsp:include page="../layout/layout_header.jsp" />
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/asset/css/reserv.css?<%=time%>" />
<script language="javascript" src="<%=request.getContextPath()%>/asset/js/reserv.js?<%=time%>"></script>




<div class="container page-title">
    <h2>BOOKING</h2>
</div>



<div class="container reserv-form">

    <!-- 상단 예약정보 //START -->
    <div class="rf-top">
        <h3 class="rft-name">${stay.stay_name}</h3>
        <div class="rft-date">${start_date} - ${end_date}<em>${daycount}박 ${daycount+1}일</em></div>
        <div class="rft-price"><fmt:setLocale value="ko_kr" /><fmt:formatNumber value="${room.room_price * daycount}" type="currency" /></div>
    </div>
    <!-- 상단 예약정보 //START -->




    <!-- 예약 폼 //START -->
    <div class="rf-wrap">
        <form name="reserv_form" method="post" action="<%=request.getContextPath()%>/stayReservOk.do" onsubmit="return chkReservForm(this);">
        <input type="hidden" name="reserv_stayno" value="${stay.stay_no}" />
        <input type="hidden" name="reserv_stayname" value="${stay.stay_name}" />
        <input type="hidden" name="reserv_roomno" value="${room.room_no}" />
        <input type="hidden" name="reserv_roomname" value="${room.room_name}" />
        <input type="hidden" name="reserv_memid" value="${login_id}" />
        <input type="hidden" name="reserv_start" value="${start_date_full}" />
        <input type="hidden" name="reserv_end" value="${end_date_full}" />
        <input type="hidden" name="reserv_daycount" value="${daycount}" />
        <input type="hidden" name="reserv_option1_name" value="${stay.stay_option1_name}" />
        <input type="hidden" name="reserv_option1_price" value="${stay.stay_option1_price}" />
        <input type="hidden" name="reserv_option2_name" value="${stay.stay_option2_name}" />
        <input type="hidden" name="reserv_option2_price" value="${stay.stay_option2_price}" />
        <input type="hidden" name="reserv_option3_name" value="${stay.stay_option3_name}" />
        <input type="hidden" name="reserv_option3_price" value="${stay.stay_option3_price}" />
        <input type="hidden" name="reserv_basic_price" value="${room.room_price * daycount}" />
        <input type="hidden" name="reserv_total_price" value="${room.room_price * daycount}" />
        <div class="rfw-title">Reservations</div>


        <table class="rfw-list">
            <colgroup>
                <col width="32%" />
                <col />
            </colgroup>

            <tbody>
                <tr>
                    <th>예약 스테이</th>
                    <td>${room.room_name} / ${room.room_type}</td>
                </tr>

                <tr>
                    <th>예약일</th>
                    <td class="day">${start_date} ~ ${end_date}<em>${daycount}박 ${daycount+1}일</em></td>
                </tr>

                <tr>
                    <th>이름</th>
                    <td><input type="text" name="reserv_memname" value="${login_name}" class="input-width" readonly="readonly" /></td>
                </tr>

                <tr>
                    <th>연락처</th>
                    <td><input type="text" name="reserv_memphone" value="${login_phone}" class="input-width" readonly="readonly" /></td>
                </tr>

                <tr>
                    <th>이메일</th>
                    <td><input type="text" name="reserv_mememail" value="${login_email}" class="input-width" readonly="readonly" /></td>
                </tr>

                <tr>
                    <th>인원 (최대 ${room.room_people_max}명)</th>
                    <td class="people">
                        <div class="select">
                            <span>성인</span>
                            <select name="reserv_people_adult" max="${room.room_people_max}">
                                <c:forEach begin="1" end="${room.room_people_max}" var="i">
                                <option value="${i}">${i}명</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="select">
                            <span>아동</span>
                            <select name="reserv_people_kid" max="${room.room_people_max}">
                                <option value="0">0명</option>
                                <c:forEach begin="1" end="${room.room_people_max}" var="j">
                                <option value="${j}">${j}명</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="select">
                            <span>영아</span>
                            <select name="reserv_people_baby" max="${room.room_people_max}">
                                <option value="0">0명</option>
                                <c:forEach begin="1" end="${room.room_people_max}" var="k">
                                <option value="${k}">${k}명</option>
                                </c:forEach>
                            </select>
                        </div>
                        <span class="people-txt">아동 : 24개월 ~ 12세<br />영아 : 24개월 미만</span>
                    </td>
                </tr>

                <c:choose>
                <c:when test="${!empty stay.stay_option1_name or !empty stay.stay_option2_name or !empty stay.stay_option3_name}">
                <tr>
                    <th>추가 옵션 선택</th>
                    <td class="option">
                        <c:choose>
                        <c:when test="${!empty stay.stay_option1_name}">
                            <c:if test="${!empty stay.stay_option1_photo}">
                            <div class="option-img">
                                <div class="img" style="background-image: url('<%=request.getContextPath()%>${stay.stay_option1_photo}');"></div>
                            </div>
                            </c:if>
                            <div class="option-select">
                                <div class="tit">${stay.stay_option1_name}<span class="price"><fmt:setLocale value="ko_kr" /><fmt:formatNumber value="${stay.stay_option1_price}" type="currency" /></span></div>
                                <div class="txt">${stay.stay_option1_desc.replace(newLine, '<br />')}</div>
                                <div class="sel-option">
                                    <label><input type="radio" name="stay_option1_select" value="Y" num="1" /> 선택</label>
                                    <label><input type="radio" name="stay_option1_select" value="N" num="1" checked="checked" /> 선택안함</label>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise><input type="hidden" name="stay_option1_select" value="N" /></c:otherwise>
                        </c:choose>

                        <c:choose>
                        <c:when test="${!empty stay.stay_option2_name}">
                            <c:if test="${!empty stay.stay_option2_photo}">
                            <div class="option-img">
                                <div class="img" style="background-image: url('<%=request.getContextPath()%>${stay.stay_option2_photo}');"></div>
                            </div>
                            </c:if>
                            <div class="option-select">
                                <div class="tit">${stay.stay_option2_name}<span class="price"><fmt:setLocale value="ko_kr" /><fmt:formatNumber value="${stay.stay_option2_price}" type="currency" /></span></div>
                                <div class="txt">${stay.stay_option2_desc.replace(newLine, '<br />')}</div>
                                <div class="sel-option">
                                    <label><input type="radio" name="stay_option2_select" value="Y" num="2" /> 선택</label>
                                    <label><input type="radio" name="stay_option2_select" value="N" num="2" checked="checked" /> 선택안함</label>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise><input type="hidden" name="stay_option2_select" value="N" /></c:otherwise>
                        </c:choose>

                        <c:choose>
                        <c:when test="${!empty stay.stay_option3_name}">
                            <c:if test="${!empty stay.stay_option3_photo}">
                            <div class="option-img">
                                <div class="img" style="background-image: url('<%=request.getContextPath()%>${stay.stay_option3_photo}');"></div>
                            </div>
                            </c:if>
                            <div class="option-select">
                                <div class="tit">${stay.stay_option3_name}<span class="price"><fmt:setLocale value="ko_kr" /><fmt:formatNumber value="${stay.stay_option3_price}" type="currency" /></span></div>
                                <div class="txt">${stay.stay_option3_desc.replace(newLine, '<br />')}</div>
                                <div class="sel-option">
                                    <label><input type="radio" name="stay_option3_select" value="Y" num="3" /> 선택</label>
                                    <label><input type="radio" name="stay_option3_select" value="N" num="3" checked="checked" /> 선택안함</label>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise><input type="hidden" name="stay_option3_select" value="N" /></c:otherwise>
                        </c:choose>
                    </td>
                </tr>
                </c:when>

                <c:otherwise>
                <input type="hidden" name="stay_option1_select" value="N" />
                <input type="hidden" name="stay_option2_select" value="N" />
                <input type="hidden" name="stay_option3_select" value="N" />
                </c:otherwise>
                </c:choose>

                <tr>
                    <th>요청사항</th>
                    <td>
                        <textarea name="reserv_request" cols="80" rows="5"></textarea>
                    </td>
                </tr>

                <tr>
                    <th>픽업 요청</th>
                    <td>
                        <label><input type="radio" name="reserv_pickup" value="Y"> 요청</label>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <label><input type="radio" name="reserv_pickup" value="N" checked="checked"> 요청안함</label>
                    </td>
                </tr>

                <tr>
                    <th>예상 결제금액</th>
                    <td class="total-price">
                        <dl>
                            <dt>객실 요금<span class="stay">${room.room_name} / ${room.room_type} &nbsp; <fmt:setLocale value="ko_kr" /><fmt:formatNumber value="${room.room_price}" type="currency" /> * ${daycount}박</span></dt>
                            <dd><fmt:setLocale value="ko_kr" /><fmt:formatNumber value="${room.room_price * daycount}" type="currency" /></dd>
                            <dt class="opt-show">
                                <span class="plus-option-tit">추가 옵션</span>
                                <ul class="plus-option-wrap"></ul>
                            </dt>
                            <dd class="opt-price">-</dd>
                            <dt class="total"></dt>
                            <dd class="total"><fmt:setLocale value="ko_kr" /><fmt:formatNumber value="${room.room_price * daycount}" type="currency" /></dd>
                        </dl>
                    </td>
                </tr>
            </tbody>
        </table>



        <div class="rfw-agree">
            <div class="title">이용자 약관 동의</div>
            <ul class="fold">
                <li class="agree-all">
                    <label><input type="checkbox" name="agree_all" value="Y" /> 사용자 약관 전체 동의</label>
                </li>

                <li>
                    <label><input type="checkbox" name="agree_service" value="Y" /> 서비스 이용 약관 동의 (필수)</label>
                    <div class="view">
                        <ol>
                            <li>1. 개인정보를 제공받는 자 : ${stay.stay_name}</li>
                            <li>2. 제공하는 개인정보 항목 : [필수] 스테이:키 아이디, 이름, 연락처, 이메일주소, 인원정보</li>
                            <li>3. 개인정보를 제공받는 자의 이용목적 : 사업자회원과 예약이용자의 원활한 거래 진행, 고객상담, 불만처리 등 민원 처리, 분쟁조정 해결을 위한 기록보존</li>
                            <li>4. 개인정보를 제공받는 자의 개인정보 보유 및 이용기간 : 개인정보 이용목적 달성 시 까지 보존합니다.</li>
                            <li>5. 동의 거부권 등에 대한 고지 : 정보주체는 개인정보 제공 동의를 거부할 권리가 있으나, 이 경우 상품 및 서비스 예약이 제한될 수 있습니다.</li>
                        </ol>
                    </div>
                </li>

                <li>
                    <label><input type="checkbox" name="agree_privacy" value="Y" /> 개인정보 처리방침 동의 (필수)</label>
                    <div class="view">
                        <ol>
                            <li>1. 개인정보를 제공받는 자 : ${stay.stay_name}</li>
                            <li>2. 제공하는 개인정보 항목 : [필수] 스테이:키 아이디, 이름, 연락처, 이메일주소, 인원정보</li>
                            <li>3. 개인정보를 제공받는 자의 이용목적 : 사업자회원과 예약이용자의 원활한 거래 진행, 고객상담, 불만처리 등 민원 처리, 분쟁조정 해결을 위한 기록보존</li>
                            <li>4. 개인정보를 제공받는 자의 개인정보 보유 및 이용기간 : "개인정보 이용목적 달성 시 까지 보존합니다. 단, 관계법령에 의하여 보존할 필요성이 있는 경우 그 시점까지 보존 후 지체 없이 폐기합니다."</li>
                        </ol>
                    </div>
                </li>

                <li>
                    <label><input type="checkbox" name="agree_refund" value="Y" /> ${stay.stay_name} - 환불규정에 대한 동의(필수)</label>
                    <div class="view">
                        ${stay.stay_info2}
                    </div>
                </li>
            </ul>
        </div>



        <div class="rfw-button"><button type="submit">예약하기</button></div>
        </form>
    </div>
    <!-- 예약 폼 //END -->

</div>




<jsp:include page="../layout/layout_footer.jsp" />