<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../layout/layout_header_popup.jsp" />

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="view" value="${reservView}" />

<c:if test="${empty view}"><script>alert('잘못된 주문번호입니다.'); window.close();</script></c:if>
<style type="text/css">body { padding: 0 30px !important; }</style>
<div class="d-flex justify-content flex-wrap flex-md-nowrap align-items-center pt-4 pb-2 mb-4 border-bottom">
    <h2>예약 상세 정보</h2>
    <small>예약된 정보를 확인 할 수 있습니다.</small>
</div>



<div class="view-form">
    <!-- 내용 //START -->
    <div class="row vf-body">
        <div class="col-lg mb-4">
            <table class="table-form w-100">
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
    <div class="row vf-body">
        <div class="col-lg mb-4">
            <h4>예약자 정보</h4>

            <table class="table-form w-100">
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



    <!-- 숙박 정보 //START -->
    <div class="row vf-body">
        <div class="col-lg mb-4">
            <h4>숙박 정보</h4>

            <table class="table-form w-100">
                <colgroup>
                    <col width="17%" />
                    <col />
                </colgroup>

                <tbody>
                    <tr>
                        <th>숙소</th>
                        <td colspan="3">
                            <p class="pb-1" style="font-size: 16px;"><i class="icon-home"></i> ${view.reserv_stayname}</p>
                            <p>- ${view.reserv_roomname}</p>
                        </td>
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
                            <c:if test="${view.reserv_people_adult > 0}"><span class="mx-2">성인 ${view.reserv_people_adult}명</span></c:if>
                            <c:if test="${view.reserv_people_kid > 0}"><span class="mx-2">아동 ${view.reserv_people_kid}명</span></c:if>
                            <c:if test="${view.reserv_people_baby > 0}"><span class="mx-2">영아 ${view.reserv_people_baby}명</span></c:if>
                            )
                        </td>
                    </tr>
                    <c:if test="${!empty view.reserv_option1_name or !empty view.reserv_option2_name or !empty view.reserv_option3_name}">
                    <tr>
                        <th>옵션 신청</th>
                        <td>
                            <c:if test="${!empty view.reserv_option1_name}"><p class="my-2">${view.reserv_option1_name} (<fmt:formatNumber value="${view.reserv_option1_price}" />원)</p></c:if>
                            <c:if test="${!empty view.reserv_option2_name}"><p class="my-2">${view.reserv_option2_name} (<fmt:formatNumber value="${view.reserv_option2_price}" />원)</p></c:if>
                            <c:if test="${!empty view.reserv_option3_name}"><p class="my-2">${view.reserv_option3_name} (<fmt:formatNumber value="${view.reserv_option3_price}" />원)</p></c:if>
                        </td>
                    </tr>
                    </c:if>
                    <tr>
                        <th>픽업 여부</th>
                        <td colspan="3"><c:choose><c:when test="${view.reserv_pickup == 'N'}">X 요청 안함</c:when><c:otherwise>O 픽업 요청</c:otherwise></c:choose></td>
                    </tr>
                    <tr>
                        <th>요청 사항</th>
                        <td colspan="3">${view.reserv_request}</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <!-- 숙박 정보 //END -->



    <!-- 결제 정보 //START -->
    <div class="row vf-body">
        <div class="col-lg mb-4">
            <h4>결제 정보</h4>

            <table class="table-form w-100">
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
    <div class="d-flex justify-content-center mb-4">
        <button type="button" class="btn btn-outline-secondary" onclick="window.print();"><i class="fa fa-print"></i> 인쇄하기</button>
        <button type="button" class="btn btn-secondary ml-2" onclick="window.close();"><i class="fa fa-times"></i> 창닫기</button>
    </div>
    <!-- 버튼 //END -->

</div>



<jsp:include page="../layout/layout_footer.jsp" />