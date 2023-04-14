<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../layout/layout_header.jsp" />

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("newLine", "\n"); %>

<c:set var="view" value="${reservView}" />
<c:set var="stay" value="${stayCont}" />
<c:set var="room" value="${roomCont}" />


<script type="text/javascript">
$("#nav-reserv").addClass("now");


// 인원 선택 계산
$(function(){
    $("select[name='reserv_people_adult'], select[name='reserv_people_kid'], select[name='reserv_people_baby']").on("change", function(){
        const maxPeople = Number($("#max-people").text().trim());

        let p_adult = Number($("select[name='reserv_people_adult']").val());
        let p_kid = Number($("select[name='reserv_people_kid']").val());
        let p_baby = Number($("select[name='reserv_people_baby']").val());

        let p_sum = p_adult + p_kid + p_baby;
        if(p_sum > maxPeople){
            alert("최대 "+maxPeople+"명 까지 숙박이 가능합니다.");
            $(this).val(0);
        }

        if(p_sum <= 0){
            alert("최소 1명 이상 숙박인원을 선택하세요.");
            $(this).val(1);
        }
    });
});
</script>



<div class="d-flex justify-content flex-wrap flex-md-nowrap align-items-center pt-4 pb-2 mb-4 border-bottom">
    <h2>예약 수정</h2>
    <small>예약 내역의 정보를 수정 할 수 있습니다.</small>
</div>




<div class="view-form pb100 w-70 m-auto">
    <form name="write_form" method="post"action="<%=request.getContextPath() %>/admin/reservModifyOk.do">
    <input type="hidden" name="reserv_no" value="${view.reserv_no}" />
    <input type="hidden" name="reserv_sess" value="${view.reserv_sess}" />
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
                        <th>예약번호</th>
                        <td class="eng">${view.reserv_sess}</td>
                        <th>예약일자</th>
                        <td class="eng">${view.reserv_date}</td>
                    </tr>
                    <tr>
                        <th>예약 상태</th>
                        <td colspan="3">
                            <div class="form-check form-check-inline">
                                <label class="form-check-label"><input type="radio" name="reserv_status" value="reserv" class="form-check-input"<c:if test="${view.reserv_status == 'reserv'}"> checked="checked"</c:if> /> 진행</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <label class="form-check-label"><input type="radio" name="reserv_status" value="cancel" class="form-check-input"<c:if test="${view.reserv_status == 'cancel'}"> checked="checked"</c:if> /> 취소</label>
                            </div>
                        </td>
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
                        <td>${view.reserv_memphone}</td>
                        <th>이메일</th>
                        <td>${view.reserv_mememail}</td>
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
                        <td colspan="3">
                            <div class="row">
                                <div class="col-4">
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                        </div>
                                        <input type="text" name="reserv_start" value="${view.reserv_start.substring(0,10)}" id="startDt" class="form-control text-center eng" />
                                    </div>
                                </div>

                                <div class="pt-2">~</div>

                                <div class="col-4">
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                        </div>
                                        <input type="text" name="reserv_end" value="${view.reserv_end.substring(0,10)}" id="endDt" class="form-control text-center eng" />
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th>숙박인원</th>
                        <td colspan="3">
                            <span class="align-middle mr-4">기준인원 최대 <b id="max-people">${room.room_people_max}</b>명</span>
                            <span class="align-middle">성인</span>
                            <select name="reserv_people_adult" class="form-select">
                                <c:forEach begin="0" end="6" var="i">
                                <option value="${i}"<c:if test="${view.reserv_people_adult == i}"> selected="selected"</c:if>>${i}명</option>
                                </c:forEach>
                            </select>
                            <span class="align-middle ml-3">아동</span>
                            <select name="reserv_people_kid" class="form-select">
                                <c:forEach begin="0" end="5" var="j">
                                <option value="${j}"<c:if test="${view.reserv_people_kid == j}"> selected="selected"</c:if>>${j}명</option>
                                </c:forEach>
                            </select>
                            <span class="align-middle ml-3">영아</span>
                            <select name="reserv_people_baby" class="form-select">
                                <c:forEach begin="0" end="5" var="k">
                                <option value="${k}"<c:if test="${view.reserv_people_baby == k}"> selected="selected"</c:if>>${k}명</option>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                    <c:if test="${!empty stay.stay_option1_name or !empty stay.stay_option2_name or !empty stay.stay_option3_name}">
                    <tr>
                        <th>옵션 신청</th>
                        <td>
                            <div class="row">
                                <c:if test="${!empty stay.stay_option1_name}">
                                <div class="col-auto my-2">
                                    <div>${stay.stay_option1_name} (<fmt:formatNumber value="${stay.stay_option1_price}" />원)</div>
                                    <div>
                                        <div class="form-check form-check-inline">
                                            <label class="form-check-label"><input type="radio" name="reserv_option1_name" value="${stay.stay_option1_name}♣${stay.stay_option1_price}" class="form-check-input"<c:if test="${!empty view.reserv_option1_name}"> checked="checked"</c:if> /> 선택</label>
                                        </div>
                                        <div class="form-check form-check-inline">
                                            <label class="form-check-label"><input type="radio" name="reserv_option1_name" value="" class="form-check-input"<c:if test="${empty view.reserv_option1_name}"> checked="checked"</c:if> /> 안함</label>
                                        </div>
                                    </div>
                                </div>
                                </c:if>

                                <c:if test="${!empty stay.stay_option2_name}">
                                <div class="col-auto my-2">
                                    <div>${stay.stay_option2_name} (<fmt:formatNumber value="${stay.stay_option2_price}" />원)</div>
                                    <div>
                                        <div class="form-check form-check-inline">
                                            <label class="form-check-label"><input type="radio" name="reserv_option2_name" value="${stay.stay_option2_name}♣${stay.stay_option2_price}" class="form-check-input"<c:if test="${!empty view.reserv_option2_name}"> checked="checked"</c:if> /> 선택</label>
                                        </div>
                                        <div class="form-check form-check-inline">
                                            <label class="form-check-label"><input type="radio" name="reserv_option2_name" value="" class="form-check-input"<c:if test="${empty view.reserv_option2_name}"> checked="checked"</c:if> /> 안함</label>
                                        </div>
                                    </div>
                                </div>
                                </c:if>

                                <c:if test="${!empty stay.stay_option3_name}">
                                <div class="col-auto my-2">
                                    <div>${stay.stay_option3_name} (<fmt:formatNumber value="${stay.stay_option3_price}" />원)</div>
                                    <div>
                                        <div class="form-check form-check-inline">
                                            <label class="form-check-label"><input type="radio" name="reserv_option3_name" value="${stay.stay_option3_name}♣${stay.stay_option3_price}" class="form-check-input"<c:if test="${!empty view.reserv_option3_name}"> checked="checked"</c:if> /> 선택</label>
                                        </div>
                                        <div class="form-check form-check-inline">
                                            <label class="form-check-label"><input type="radio" name="reserv_option3_name" value="" class="form-check-input"<c:if test="${empty view.reserv_option3_name}"> checked="checked"</c:if> /> 안함</label>
                                        </div>
                                    </div>
                                </div>
                                </c:if>
                            </div>
                        </td>
                    </tr>
                    </c:if>
                    <tr>
                        <th>픽업 여부</th>
                        <td colspan="3">
                            <div class="form-check form-check-inline">
                                <label class="form-check-label"><input type="radio" name="reserv_pickup" value="Y" class="form-check-input"<c:if test="${view.reserv_pickup == 'Y'}"> checked="checked"</c:if> /> 픽업 요청</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <label class="form-check-label"><input type="radio" name="reserv_pickup" value="N" class="form-check-input"<c:if test="${view.reserv_pickup == 'N'}"> checked="checked"</c:if> /> 요청 안함</label>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th>요청 사항</th>
                        <td colspan="3"><textarea name="reserv_request" cols="20" rows="4" class="form-control">${view.reserv_request.replace('<br />', newLine)}</textarea></td>
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



    <div class="gw-button">
        <div class="gwb-wrap">
            <div class="gwb-left"></div>

            <div class="gwb-center">
                <button type="button" class="btn btn-lg btn-outline-secondary mx-1" onclick="history.back();"><i class="fa fa-bars"></i> 취소하기</button>
                <button type="submit" class="btn btn-lg btn-success mx-1"><i class="fa fa-save"></i> 수정하기</button>
            </div>

            <div class="gwb-right"></div>
        </div>
    </div>
    </form>
</div>





<jsp:include page="../layout/layout_footer.jsp" />