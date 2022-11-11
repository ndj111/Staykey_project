<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../layout/layout_header.jsp" />

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="stayList" value="${stayList}" />

<script type="text/javascript">$("#nav-stay").addClass("now");</script>
<script>
$(document).ready(function(){
	// 체크박스 all 클릭 시 나머지 해체
	$("input[name='ps_type'][value='all']").click(function(){
		if($(this).prop("checked")){
            $("input[name='ps_type']").prop("checked", false);
            $(this).prop("checked", true);
		}
	});
	$("input[name='ps_type'][value!='all']").click(function(){
		$("input[name='ps_type'][value='all']").prop("checked", false);
	});
});
</script>

<div class="d-flex justify-content flex-wrap flex-md-nowrap align-items-center pt-4 pb-2 mb-4 border-bottom">
    <h2>숙소 목록</h2>
    <small>등록된 숙소 목록을 확인하고 관리 할 수 있습니다.</small>
</div>

${ msg }
<c:remove var="msg"/>

<div>
    <form name="search_form" method="post" action="<%=request.getContextPath()%>/admin/stayList.do">
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
            <th>숙소 구분</th>
            <td colspan="5">
                <div class="form-check form-check-inline ml-1">
                    <label class="form-check-label"><input type="checkbox" name="ps_type" value="all" class="form-check-input"<c:if test="${map.ps_type == 'all'}"> checked="checked"</c:if> /> 전체</label>
                </div>
                <div class="form-check form-check-inline">
                    <label class="form-check-label"><input type="checkbox" name="ps_type" value="호텔" class="form-check-input"<c:if test="${map.ps_type.contains('호텔')}"> checked="checked"</c:if> /> 호텔</label>
                </div>
                <div class="form-check form-check-inline">
                    <label class="form-check-label"><input type="checkbox" name="ps_type" value="호스텔" class="form-check-input"<c:if test="${map.ps_type.contains('호스텔')}"> checked="checked"</c:if> /> 호스텔</label>
                </div>
                <div class="form-check form-check-inline">
                    <label class="form-check-label"><input type="checkbox" name="ps_type" value="게스트하우스" class="form-check-input"<c:if test="${map.ps_type.contains('게스트하우스')}"> checked="checked"</c:if> /> 게스트하우스</label>
                </div>
                <div class="form-check form-check-inline">
                    <label class="form-check-label"><input type="checkbox" name="ps_type" value="민박" class="form-check-input"<c:if test="${map.ps_type.contains('민박')}"> checked="checked"</c:if> /> 민박</label>
                </div>
                <div class="form-check form-check-inline">
                    <label class="form-check-label"><input type="checkbox" name="ps_type" value="펜션" class="form-check-input"<c:if test="${map.ps_type.contains('펜션')}"> checked="checked"</c:if> /> 펜션</label>
                </div>
                <div class="form-check form-check-inline">
                    <label class="form-check-label"><input type="checkbox" name="ps_type" value="리조트" class="form-check-input"<c:if test="${map.ps_type.contains('리조트')}"> checked="checked"</c:if> /> 리조트</label>
                </div>
                <div class="form-check form-check-inline">
                    <label class="form-check-label"><input type="checkbox" name="ps_type" value="렌탈하우스" class="form-check-input"<c:if test="${map.ps_type.contains('렌탈하우스')}"> checked="checked"</c:if> /> 렌탈하우스</label>
                </div>
                <div class="form-check form-check-inline">
                    <label class="form-check-label"><input type="checkbox" name="ps_type" value="한옥" class="form-check-input"<c:if test="${map.ps_type.contains('한옥')}"> checked="checked"</c:if> /> 한옥</label>
                </div>
                <div class="form-check form-check-inline">
                    <label class="form-check-label"><input type="checkbox" name="ps_type" value="캠핑&아웃도어" class="form-check-input"<c:if test="${map.ps_type.contains('캠핑&아웃도어')}"> checked="checked"</c:if> /> 캠핑&아웃도어</label>
                </div>
            </td>
        </tr>
        <tr>
            <th>숙소 이름</th>
            <td><input type="text" name="ps_name" value="${map.ps_name}" maxlength="50" class="form-control w-90" /></td>
            <th>숙소 위치</th>
            <td>
            	<select name="ps_location" class="form-select" style="height:34.63px; float: left;">
            		<option value="전체" selected="selected" <c:if test="${map.ps_location.contains('전체')}"> selected="selected"</c:if>> 전체</option>
            		<option value="제주" <c:if test="${map.ps_location.contains('제주')}"> selected="selected"</c:if>> 제주</option>
            		<option value="서울" <c:if test="${map.ps_location.contains('서울')}"> selected="selected"</c:if>> 서울</option>
            		<option value="강원" <c:if test="${map.ps_location.contains('강원')}"> selected="selected"</c:if>> 강원</option>
            		<option value="부산" <c:if test="${map.ps_location.contains('부산')}"> selected="selected"</c:if>> 부산</option>
            		<option value="경기" <c:if test="${map.ps_location.contains('경기')}"> selected="selected"</c:if>> 경기</option>
            		<option value="충청" <c:if test="${map.ps_location.contains('충청')}"> selected="selected"</c:if>> 충청</option>
            		<option value="경상" <c:if test="${map.ps_location.contains('경상')}"> selected="selected"</c:if>> 경상</option>
            		<option value="전라" <c:if test="${map.ps_location.contains('전라')}"> selected="selected"</c:if>> 전라</option>
            		<option value="인천" <c:if test="${map.ps_location.contains('인천')}"> selected="selected"</c:if>> 인천</option>
            		<option value="광주" <c:if test="${map.ps_location.contains('광주')}"> selected="selected"</c:if>> 광주</option>
            		<option value="대전" <c:if test="${map.ps_location.contains('대전')}"> selected="selected"</c:if>> 대전</option>
            		<option value="대구" <c:if test="${map.ps_location.contains('대구')}"> selected="selected"</c:if>> 대구</option>
            		<option value="울산" <c:if test="${map.ps_location.contains('울산')}"> selected="selected"</c:if>> 울산</option>
            	</select>
            	<input type="text" name="ps_location_sub" value="${map.ps_location_sub}" maxlength="15" class="form-control w-70" style="float: right;" />
            </td>
            <th>숙소 연락처</th>
            <td><input type="tel" name="ps_phone" value="${map.ps_phone}" maxlength="255" class="form-control w-90" /></td>
        </tr>
    </table>

    <div class="text-center mb-5">
        <a href="<%=request.getContextPath()%>/admin/stayList.do" class="btn btn-outline-secondary"><i class="fa fa-power-off"></i> 검색 초기화</a>
        <button type="submit" class="btn btn-secondary mx-2"><i class="fa fa-search"></i> 숙소 검색</button>
    </div>
    </form>

	<!-- 숙소 list -->
    <div class="table-top clear">
        <div class="tt-left">총 <b><fmt:formatNumber value="${listCount}" /></b> 개의 숙소</div>
        <div class="tt-right">
            <select name="ps_order" class="form-select" onChange="location.href='<%=request.getContextPath()%>/admin/stayList.do?ps_type=${map.ps_type}&ps_name=${map.ps_name}&ps_location=${map.ps_location}&ps_location_sub=${map.ps_location_sub}&ps_phone=${map.ps_phone}&ps_order='+this.value;">
                <option value="no_desc"<c:if test="${map.ps_order == 'no_desc'}"> selected="selected"</c:if>>높은 번호 순</option>
                <option value="no_asc"<c:if test="${map.ps_order == 'no_asc'}"> selected="selected"</c:if>>낮은 번호 순</option>
                <option value="" disabled="disabled">---------------</option>
                <option value="reserv_desc"<c:if test="${map.ps_order == 'reserv_desc'}"> selected="selected"</c:if>>예약 많은 순</option>
                <option value="reserv_asc"<c:if test="${map.ps_order == 'reserv_asc'}"> selected="selected"</c:if>>예약 적은 순</option>
                <option value="" disabled="disabled">---------------</option>
                <option value="hit_desc"<c:if test="${map.ps_order == 'hit_desc'}"> selected="selected"</c:if>>조회수 높은 순</option>
                <option value="hit_asc"<c:if test="${map.ps_order == 'hit_asc'}"> selected="selected"</c:if>>조회수 낮은 순</option>
                <option value="" disabled="disabled">---------------</option>
                <option value="name_desc"<c:if test="${map.ps_order == 'name_desc'}"> selected="selected"</c:if>>가나다 역순</option>
                <option value="name_asc"<c:if test="${map.ps_order == 'name_asc'}"> selected="selected"</c:if>>가나다 순</option>
                <option value="" disabled="disabled">---------------</option>
                <option value="date_desc"<c:if test="${map.ps_order == 'date_desc'}"> selected="selected"</c:if>>최신 등록 순</option>
                <option value="date_asc"<c:if test="${map.ps_order == 'date_asc'}"> selected="selected"</c:if>>오래된 등록 순</option>
            </select>
        </div>
    </div>



    <table class="table-list hover">
        <colgroup>
            <col width="80">
            <col width="200">
            <col />
            <col width="150">
            <col width="80">
            <col width="80">
            <col width="90">
            <col width="120">
        </colgroup>

        <thead>
            <tr>
                <th>No.</th>
                <th colspan="2">숙소 정보</th>
                <th>옵션</th>
                <th>조회수</th>
                <th>예약수</th>
                <th>등록일</th>
                <th>관리</th>
            </tr>
        </thead>

        <tbody>
            <c:choose>
	            <c:when test="${!empty stayList }">
	            <c:forEach items="${stayList}" var="list">
	            <c:set var="showLink" value="onclick=\"location.href='../admin/stayView.do?stay_no=${list.stay_no}';\"" />
	            <tr>
	                <td ${showLink} class="eng">${list.stay_no}</td>
	                <td ${showLink} class="staylist-photo">
                        <c:choose>
                            <c:when test="${!empty list.stay_file1}"><div class="sp-img" style="background-image: url('<%=request.getContextPath()%>${list.stay_file1}');"></div></c:when>
                            <c:when test="${!empty list.stay_file2}"><div class="sp-img" style="background-image: url('<%=request.getContextPath()%>${list.stay_file2}');"></div></c:when>
                            <c:when test="${!empty list.stay_file3}"><div class="sp-img" style="background-image: url('<%=request.getContextPath()%>${list.stay_file3}');"></div></c:when>
                            <c:when test="${!empty list.stay_file4}"><div class="sp-img" style="background-image: url('<%=request.getContextPath()%>${list.stay_file4}');"></div></c:when>
                            <c:when test="${!empty list.stay_file5}"><div class="sp-img" style="background-image: url('<%=request.getContextPath()%>${list.stay_file5}');"></div></c:when>
                            <c:otherwise><div class="sp-img none">no img</div></c:otherwise>
                        </c:choose>
	                </td>
	                <td ${showLink} class="stay-list">
	            		<p class="sl-loc">${list.stay_location}</p>
	            		<p class="sl-name">${list.stay_name}</p>
	            		<p class="sl-desc">${list.stay_desc}</p>
	            		<p class="sl-addr">${list.stay_addr}</p>
	                </td>
	                <td ${showLink}>
	                	<c:if test="${!empty list.stay_option1_name}"><p>${list.stay_option1_name}</p></c:if>
	                	<c:if test="${!empty list.stay_option2_name}"><p>${list.stay_option2_name}</p></c:if>
	                	<c:if test="${!empty list.stay_option3_name}"><p>${list.stay_option3_name}</p></c:if>
	                </td>
	                <td ${showLink} class="eng">${list.stay_hit}</td>
	                <td ${showLink} class="eng">${list.stay_reserv}</td>
	                <td ${showLink} class="eng">${list.stay_date.substring(0,10)}<br />${list.stay_date.substring(11)}</td>
	                <td>
	                    <a href="<%=request.getContextPath()%>/admin/stayModify.do?stay_no=${list.stay_no}" class="btn btn-sm btn-outline-primary m-1">수정</a>
	                    <a href="<%=request.getContextPath()%>/admin/stayDeleteOk.do?stay_no=${list.stay_no}" class="btn btn-sm btn-outline-danger m-1" onclick="return confirm('정말 삭제하시겠습니까?\n※ 이 숙소에 등록된 Room들도 전부 삭제됩니다.');">삭제</a>
	                </td>
	            </tr>
	            </c:forEach>
	            </c:when>
	
	            <c:otherwise>
	            <tr>
	                <td colspan="8" class="nodata">등록된 숙소가 없습니다.</td>
	            </tr>
	            </c:otherwise>
            </c:choose>
        </tbody>


        <tfoot>
            <tr>
                <td colspan="8">
                    <table class="paging-table">
                        <colgroup>
                            <col width="120">
                            <col>
                            <col width="120">
                        </colgroup>
                        <tbody>
                            <tr>
                                <td class="text-left"></td>

                                <td class="text-center">
                                    ${map.pagingWrite}
                                </td>

                                <td class="text-right"><a href="<%=request.getContextPath()%>/admin/stayWrite.do" class="btn btn-primary"><i class="fa fa-pencil"></i> 숙소 등록</a></td>
                            </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
        </tfoot>
    </table>
</div>



<jsp:include page="../layout/layout_footer.jsp" />