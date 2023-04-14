<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="view" value="${reservView}" />
<c:set var="stay" value="${stayView}" />
<c:set var="room" value="${roomView}" />

<c:if test="${empty view}"><script type="text/javascript">alert('잘못된 예약 내역입니다.'); history.back();</script></c:if>
<c:if test="${login_id != view.reserv_memid}"><script type="text/javascript">alert('잘못된 접근입니다.'); history.back();</script></c:if>

<jsp:include page="../layout/layout_header.jsp" />
<jsp:include page="../mypage/mypage_header.jsp" />

<script type="text/javascript">$("#mymenu-reserv").addClass("now");</script>



<div class="reserv-view">


    <!-- 내용 //START -->
    <div class="row rv-body">
        <div class="col-lg mb-5">
            <table class="table-form">
                <colgroup>
                    <col width="17%" />
                    <col width="32%" />
                    <col width="17%" />
                    <col />
                </colgroup>

                <tbody>
                    <tr>
                        <th>상태</th>
                        <td colspan="3">
                            <c:choose>
                            <c:when test="${view.reserv_status == 'cancel'}"><span class="text-danger">예약취소</span></c:when>
                            <c:otherwise><span class="text-primary">진행</span></c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <th>예약번호</th>
                        <td class="eng">${view.reserv_sess}</td>
                        <th>예약일자</th>
                        <td class="eng">${view.reserv_date}</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <!-- 내용 //END -->



    <!-- 예약자 정보 //START -->
    <div class="row rv-body">
        <div class="col-lg mb-5">
            <h4>예약자 정보</h4>

            <table class="table-form">
                <colgroup>
                    <col width="17%" />
                    <col width="32%" />
                    <col width="17%" />
                    <col />
                </colgroup>

                <tbody>
                    <tr>
                        <th>이름</th>
                        <td colspan="3">${view.reserv_memname}</td>
                    </tr>
                    <tr>
                        <th>전화번호</th>
                        <td class="eng">${view.reserv_memphone}</td>
                        <th>이메일</th>
                        <td class="eng">${view.reserv_mememail}</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <!-- 예약자 정보 //END -->



    <!-- 숙소 정보 //START -->
    <div class="row rv-body">
        <div class="col-lg mb-5">
            <h4>숙소 정보</h4>

            <table class="table-form">
                <colgroup>
                    <col width="17%" />
                    <col width="32%" />
                    <col width="17%" />
                    <col />
                </colgroup>

                <tbody>
                    <tr>
                        <th>숙소명</th>
                        <td colspan="3">${stay.stay_name}</td>
                    </tr>
                    <tr>
                        <th>주소</th>
                        <td colspan="3">${stay.stay_location.replace(" / ", " ")} ${stay.stay_addr}</td>
                    </tr>
                    <tr>
                        <th>전화번호</th>
                        <td class="eng">${stay.stay_phone}</td>
                        <th>이메일</th>
                        <td class="eng">${stay.stay_email}</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <!-- 숙소 정보 //END -->



    <!-- 숙박 정보 //START -->
    <div class="row rv-body">
        <div class="col-lg mb-5">
            <h4>숙박 정보</h4>

            <table class="table-form">
                <colgroup>
                    <col width="17%" />
                    <col />
                </colgroup>

                <tbody>
                    <tr>
                        <td colspan="4" class="stay-info">
                    		<div class="si-wrap">
                    			<c:if test="${!empty room.room_photo1 or !empty room.room_photo2 or !empty room.room_photo3 or !empty room.room_photo4 or !empty room.room_photo5}">
                    			<div class="siw-left">
                    				<c:choose>
                    				<c:when test="${!empty room.room_photo1}"><div class="photo" style="background-image: url('<%=request.getContextPath()%>${room.room_photo1}');"></div></c:when>
                    				<c:when test="${!empty room.room_photo2}"><div class="photo" style="background-image: url('<%=request.getContextPath()%>${room.room_photo2}');"></div></c:when>
                    				<c:when test="${!empty room.room_photo3}"><div class="photo" style="background-image: url('<%=request.getContextPath()%>${room.room_photo3}');"></div></c:when>
                    				<c:when test="${!empty room.room_photo4}"><div class="photo" style="background-image: url('<%=request.getContextPath()%>${room.room_photo4}');"></div></c:when>
                    				<c:when test="${!empty room.room_photo5}"><div class="photo" style="background-image: url('<%=request.getContextPath()%>${room.room_photo5}');"></div></c:when>
                    				</c:choose>
                    			</div>
                    			</c:if>

                    			<div class="siw-right">
						            <div class="tit">ROOM INFORMATION</div>
						            <div class="name">${room.room_name}</div>
						            <div class="txt">
                                        <c:choose>
                                        <c:when test="${room.room_desc.length() >= 150}">${room.room_desc.substring(0,150)} ...</c:when>
                                        <c:otherwise>${room.room_desc}</c:otherwise>
                                        </c:choose>
                                    </div>
						            <div class="etc">
					                    <p>체크인 ${room.room_checkin} / 체크아웃 ${room.room_checkout}</p>
					                    <p>기준 인원 <fmt:formatNumber value="${room.room_people_min}" />명 (최대 인원 <fmt:formatNumber value="${room.room_people_max}" />명)</p>
					                    <p>객실면적 ${room.room_size}㎡</p>
					                    <p>${room.room_bed}</p>
						            </div>
                    			</div>
                    		</div>
                        </td>
                    </tr>

                    <tr>
                    	<td colspan="4" class="space"></td>
                    </tr>

                    <tr>
                        <th>숙박기간</th>
                        <td colspan="3" class="eng">${view.reserv_start.substring(0,16)} ~ ${view.reserv_end.substring(0,16)} (${view.reserv_daycount}박 ${view.reserv_daycount+1}일)</td>
                    </tr>
                    <tr>
                        <th>숙박인원</th>
                        <td colspan="3">
                            총 <strong>${view.reserv_people_adult + view.reserv_people_kid + view.reserv_people_baby}</strong>명
                            (
                            <c:if test="${view.reserv_people_adult > 0}"><span class="mx-1">성인 ${view.reserv_people_adult}명</span></c:if>
                            <c:if test="${view.reserv_people_kid > 0}"><span class="mx-1">아동 ${view.reserv_people_kid}명</span></c:if>
                            <c:if test="${view.reserv_people_baby > 0}"><span class="mx-1">영아 ${view.reserv_people_baby}명</span></c:if>
                            )
                        </td>
                    </tr>
                    <c:if test="${!empty view.reserv_option1_name or !empty view.reserv_option2_name or !empty view.reserv_option3_name}">
                    <tr>
                        <th>옵션 신청</th>
                        <td>
                            <c:if test="${!empty view.reserv_option1_name}"><p class="my-2">${view.reserv_option1_name} <span class="eng pl-2">(<fmt:formatNumber value="${view.reserv_option1_price}" />원)</span></p></c:if>
                            <c:if test="${!empty view.reserv_option2_name}"><p class="my-2">${view.reserv_option2_name} <span class="eng pl-2">(<fmt:formatNumber value="${view.reserv_option2_price}" />원)</span></p></c:if>
                            <c:if test="${!empty view.reserv_option3_name}"><p class="my-2">${view.reserv_option3_name} <span class="eng pl-2">(<fmt:formatNumber value="${view.reserv_option3_price}" />원)</span></p></c:if>
                        </td>
                    </tr>
                    </c:if>
                    <tr>
                        <th>픽업 여부</th>
                        <td colspan="3"><c:choose><c:when test="${view.reserv_pickup == 'N'}">X 요청 안함</c:when><c:otherwise>O 픽업 요청</c:otherwise></c:choose></td>
                    </tr>
                    <tr>
                        <th>요청 사항</th>
                        <td colspan="3" class="request">${view.reserv_request}</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <!-- 숙박 정보 //END -->



    <!-- 결제 정보 //START -->
    <div class="row rv-body">
        <div class="col-lg mb-5">
            <h4>결제 정보</h4>

            <table class="table-form">
                <colgroup>
                    <col width="17%" />
                    <col />
                </colgroup>

                <tbody>
                    <tr>
                        <th>숙박 금액</th>
                        <td colspan="3" class="d-flex">
                            <div class="text-black">숙박 금액<br /><b class="eng"><fmt:formatNumber value="${view.reserv_basic_price}" /></b>원</div>
                            <div class="pl-3 text-success">옵션 금액<br /><b class="eng">+ <fmt:formatNumber value="${view.reserv_option1_price + view.reserv_option2_price + view.reserv_option3_price}" /></b>원</div>
                        </td>
                    </tr>
                    <tr>
                        <th>최종 결제 금액</th>
                        <td colspan="3" class="text-primary"><b class="eng" style="font-size: 16px;"><fmt:formatNumber value="${view.reserv_total_price}" /></b>원</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <!-- 결제 정보 //END -->




    <!-- 버튼 //START -->
    <div class="rv-btn">
    	<c:if test="${cancel_ok == 'Y'}"><button type="button" class="cancel" data-toggle="modal" data-target="#reserv-cancel">예약취소</button></c:if>
    	<button type="button" onclick="location.href='<%=request.getContextPath()%>/mypageReservList.do'">목록보기</button>
    </div>
    <!-- 버튼 //END -->
</div>



<c:if test="${cancel_ok == 'Y'}">
<!-- 예약 취소 Modal // START -->
<div class="modal" id="reserv-cancel" tabindex="-1" aria-labelledby="FindDateLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">정말 이 예약을 취소하시겠습니까?<small>즉시 예약이 취소되며 되돌릴 수 없습니다.</small></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body text-center pt-4 pb-5">
            	<form name="cancel_form" method="post" action="<%=request.getContextPath()%>/mypageReservCancelOk.do">
            	<input type="hidden" name="reserv_no" value="${view.reserv_no}">
            	<input type="hidden" name="reserv_sess" value="${view.reserv_sess}">
            	<input type="hidden" name="login_pw" value="${login_pw}">

            	<p class="text">취소를 하시려면 로그인 비밀번호를 입력해주세요.</p>
            	<p class="input"><input type="password" name="reserv_pw" required /></p>
            	<p class="button">
					<button type="submit">취소하기</button>
            		<button type="button" class="close" data-dismiss="modal" aria-label="Close">닫기</button>
            	</p>
            	</form>
            </div>
        </div>
    </div>
</div>
<!-- 예약 취소 Modal // END -->
</c:if>



<jsp:include page="../mypage/mypage_footer.jsp" />
<jsp:include page="../layout/layout_footer.jsp" />