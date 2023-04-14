<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../layout/layout_header.jsp" />

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="list" value="${List}" />


<script type="text/javascript">$("#nav-reserv").addClass("now");</script>
<div class="d-flex justify-content flex-wrap flex-md-nowrap align-items-center pt-4 pb-2 mb-4 border-bottom">
    <h2>예약 목록</h2>
    <small>접수된 예약을 확인하고 관리 할 수 있습니다.</small>
</div>


<div>
    <form name="search_form" method="post" action="reservList.do">
    <input type="hidden" name="ps_order" value="${map.ps_order}" />
    <table class="table-form ml-0 mb-3 border rounded-lg">
        <colgroup>
            <col width="10%" />
            <col width="22%" />
            <col width="10%" />
            <col width="22%" />
            <col width="10%" />
            <col />
        </colgroup>
        <tr>
            <th>예약 상태</th>
            <td>
                <div class="form-check form-check-inline ml-1">
                    <label class="form-check-label"><input type="radio" name="ps_status" value="all" class="form-check-input"<c:if test="${map.ps_status == 'all'}"> checked="checked"</c:if> /> 전체</label>
                </div>
                <div class="form-check form-check-inline">
                    <label class="form-check-label"><input type="radio" name="ps_status" value="reserv" class="form-check-input"<c:if test="${map.ps_status == 'reserv'}"> checked="checked"</c:if> /> 진행</label>
                </div>
                <div class="form-check form-check-inline">
                    <label class="form-check-label"><input type="radio" name="ps_status" value="cancel" class="form-check-input"<c:if test="${map.ps_status == 'cancel'}"> checked="checked"</c:if> /> 취소</label>
                </div>
            </td>
            <th>숙박 일자</th>
            <td colspan="3">
                <div class="row">
                    <div class="col-4">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                            </div>
                            <input type="text" name="ps_start" value="${map.ps_start}" id="startDt" class="form-control text-center eng" />
                        </div>
                    </div>

                    <div class="pt-2">~</div>

                    <div class="col-4">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                            </div>
                            <input type="text" name="ps_end" value="${map.ps_end}" id="endDt" class="form-control text-center eng" />
                        </div>
                    </div>

                    <div class="col-3 pt-2">
                        <label><input type="checkbox" name="ps_duse" value="1"<c:if test="${map.ps_duse == '1'}"> checked="checked"</c:if> /> 모든 기간 검색</label>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <th>예약 번호</th>
            <td><input type="text" name="ps_sess" value="${map.ps_sess}" maxlength="50" class="form-control w-90" /></td>
            <th>예약자 이름</th>
            <td><input type="text" name="ps_name" value="${map.ps_name}" maxlength="30" class="form-control w-90" /></td>
            <th>숙소 이름</th>
            <td><input type="text" name="ps_stay" value="${map.ps_stay}" maxlength="50" class="form-control w-90" /></td>
        </tr>
    </table>

    <div class="text-center mb-5">
        <a href="<%=request.getContextPath()%>/admin/reservList.do" class="btn btn-outline-secondary"><i class="fa fa-power-off"></i> 검색 초기화</a>
        <button type="submit" class="btn btn-secondary mx-2"><i class="fa fa-search"></i> 예약 검색</button>
    </div>
    </form>





    <div class="table-top clear">
        <div class="tt-left">총 <b><fmt:formatNumber value="${listCount}" /></b> 개의 예약</div>
        <div class="tt-right">
            <select name="ps_order" class="form-select" onChange="location.href='<%=request.getContextPath()%>/admin/reservList.do?ps_status=${map.ps_status}&ps_start=${map.ps_start}&ps_end=${map.ps_end}&ps_sess=${map.ps_sess}&ps_name=${map.ps_name}&ps_stay=${map.ps_stay}&ps_duse=${map.ps_duse}&ps_order='+this.value;">
                <option value="register_desc"<c:if test="${map.ps_order == 'register_desc'}"> selected="selected"</c:if>>예약일자 최신</option>
                <option value="register_asc"<c:if test="${map.ps_order == 'register_asc'}"> selected="selected"</c:if>>예약일자 예전</option>
                <option value="" disabled="disabled">---------------</option>
                <option value="enddate_desc"<c:if test="${map.ps_order == 'enddate_desc'}"> selected="selected"</c:if>>숙박일자 최신</option>
                <option value="enddate_asc"<c:if test="${map.ps_order == 'enddate_asc'}"> selected="selected"</c:if>>숙박일자 예전</option>
                <option value="" disabled="disabled">---------------</option>
                <option value="name_desc"<c:if test="${map.ps_order == 'name_desc'}"> selected="selected"</c:if>>예약자 역순</option>
                <option value="name_asc"<c:if test="${map.ps_order == 'name_asc'}"> selected="selected"</c:if>>예약자 순</option>
                <option value="" disabled="disabled">---------------</option>
                <option value="price_desc"<c:if test="${map.ps_order == 'price_desc'}"> selected="selected"</c:if>>결제금액 높은</option>
                <option value="price_asc"<c:if test="${map.ps_order == 'price_asc'}"> selected="selected"</c:if>>결제금액 낮은</option>
                <option value="" disabled="disabled">---------------</option>
                <option value="stay_desc"<c:if test="${map.ps_order == 'stay_desc'}"> selected="selected"</c:if>>숙소명 역순</option>
                <option value="stay_asc"<c:if test="${map.ps_order == 'stay_asc'}"> selected="selected"</c:if>>숙소명 순</option>
            </select>
        </div>
    </div>



    <table class="table-list hover">
        <colgroup>
            <col width="6.5%">
            <col width="13.5%">
            <col width="16.2%">
            <col />
            <col width="13.5%">
            <col width="11%">
            <col width="11%">
            <col width="6.2%">
        </colgroup>

        <thead>
            <tr>
                <th>상태</th>
                <th>예약번호</th>
                <th>숙박일자</th>
                <th>숙소명</th>
                <th>결제금액</th>
                <th>예약자</th>
                <th>예약일자</th>
                <th>기능</th>
            </tr>
        </thead>

        <tbody>
            <c:choose>
            <c:when test="${!empty list }">
            <c:forEach items="${list}" var="dto">
            <c:set var="showLink" value="onclick=\"popWindow('../admin/reservView.do?sess=${dto.reserv_sess}', '700', '900');\"" />
            <tr>
                <td ${showLink}>
                    <c:choose>
                    <c:when test="${dto.reserv_status == 'cancel'}"><span class="text-danger">취소</span></c:when>
                    <c:otherwise><span class="text-primary">진행</span></c:otherwise>
                    </c:choose>
                </td>
                <td ${showLink} class="eng">${dto.reserv_sess}</td>
                <td ${showLink}>
                    <p class="eng">${dto.reserv_start.substring(0, 10)} ~ ${dto.reserv_end.substring(0, 10)}</p>
                    <p>(${dto.reserv_daycount}박 ${dto.reserv_daycount+1}일)</p>
                </td>
                <td ${showLink} class="py-4">
                    <p><b>${dto.reserv_stayname}</b></p>
                    <p>${dto.reserv_roomname}</p>
                </td>
                <td ${showLink}><b class="eng"><fmt:formatNumber value="${dto.reserv_total_price}" /></b>원</td>
                <td ${showLink}>
                    <p><b>${dto.reserv_memname}</b></p>
                    <p class="eng">${dto.reserv_memphone}</p>
                </td>
                <td ${showLink} class="eng">${dto.reserv_date.substring(0, 10)}<br />${dto.reserv_date.substring(11)}</td>
                <td><a href="<%=request.getContextPath()%>/admin/reservModify.do?sess=${dto.reserv_sess}" class="btn btn-sm btn-outline-primary">수정</a></td>
            </tr>
            </c:forEach>
            </c:when>

            <c:otherwise>
            <tr>
                <td colspan="8" class="nodata">접수된 예약 내역이 없습니다.</td>
            </tr>
            </c:otherwise>
            </c:choose>
        </tbody>


        <tfoot>
            <tr>
                <td colspan="8">
                    <table class="paging-table">
                        <tbody>
                            <tr>
                                <td class="text-center">
                                    ${map.pagingWrite}
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
        </tfoot>
    </table>
</div>




<jsp:include page="../layout/layout_footer.jsp" />