<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../layout/layout_header_popup.jsp" />

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="room" value="${ roomModify }" />
<c:set var="roomType" value="${ roomType }" />
<c:set var="roomFeat" value="${ roomFeat }" />
<c:set var="roomAmeni" value="${ roomAmeni }" />
<c:set var="roomService" value="${ roomService }" />


<c:if test="${empty roomModify}"><script>alert('잘못된 Room 정보입니다.'); window.close();</script></c:if>
<style type="text/css">body { padding: 0 30px !important; }</style>
<div class="d-flex justify-content flex-wrap flex-md-nowrap align-items-center pt-4 pb-2 mb-4 border-bottom">
    <h2>Room 정보 수정</h2>
    <small>등록된 Room의 정보를 수정 할 수 있습니다.</small>
</div>



<div class="pb100">
    <form name="write_form" method="post" enctype="multipart/form-data" action="<%=request.getContextPath() %>/admin/stayRoomModifyOk.do" onsubmit="return false;">
    <input type="hidden" name="stay_no" value="${ param.stay_no }" /><!-- 숙소 번호 -->
    <input type="hidden" name="room_no" value="${ room.room_no }" /><!-- 방 번호 -->
    <table class="table-form mt-3">
        <colgroup>
            <col width="16%" />
            <col width="34%" />
            <col width="16%" />
            <col />
        </colgroup>
        <tr>
            <th>Room 이름</th>
            <td colspan="3"><input type="text" name="room_name" value="${ room.room_name }" maxlength="255" class="form-control w-50" required /></td>
        </tr>
        <tr>
            <th>간략 설명</th>
            <td colspan="3"><textarea name="room_desc" cols="30" rows="3" class="form-control">${ room.room_desc }</textarea></td>
        </tr>

        <tr>
            <td colspan="4" class="space" nowrap="nowrap"></td>
        </tr>

        <tr>
            <th>방 타입</th>
            <td colspan="3">
                <c:forEach var="rtype" items="${roomType}">
                <div class="form-check form-check-inline">
                    <label class="form-check-label"><input type="radio" name="room_type" value="${rtype}" class="form-check-input" <c:if test="${ room.room_type.contains(rtype) }"> checked="checked"</c:if> /> ${rtype}</label>
                </div>
                </c:forEach>
            </td>
        </tr>
        <tr>
            <th>가격</th>
            <td><input type="text" name="room_price" value="${ room.room_price }" class="form-control w-60 text-center d-inline mr-1" required />원</td>
            <th>객실면적</th>
            <td><input type="text" name="room_size" value="${ room.room_size }" class="form-control w-40 text-center d-inline mr-1" required />㎡</td>
        </tr>
        <tr>
            <th>체크인 시간</th>
            <td>
            	<select name="room_checkin" class="form-select" required>
            		<c:forEach begin="10" end="24" var="intime">
            		<option value="${intime}:00"<c:if test="${ intime eq room.room_checkin.substring(0,2) }"> selected=\"selected\"</c:if>>${intime}:00</option>
            		</c:forEach>
            	</select>
            </td>
            <th>체크아웃 시간</th>
            <td>
            	<select name="room_checkout" class="form-select" required>
            		<c:forEach begin="10" end="24" var="outtime">
            		<option value="${outtime}:00"<c:if test="${ outtime eq room.room_checkout.substring(0,2) }"> selected=\"selected\"</c:if>>${outtime}:00</option>
            		</c:forEach>
            	</select>
            </td>
        </tr>
        <tr>
            <th>기준인원</th>
            <td>
            	<select name="room_people_min" class="form-select">
            		<c:forEach begin="1" end="15" var="pmin">
            		<option value="${pmin}"<c:if test="${ pmin eq room.room_people_min }"> selected=\"selected\"</c:if>>${pmin}</option>
            		</c:forEach>
            	</select> 명
            </td>
            <th>최대인원</th>
            <td>
            	<select name="room_people_max" class="form-select">
            		<c:forEach begin="1" end="15" var="pmax">
            		<option value="${pmax}"<c:if test="${ pmax eq room.room_people_max }"> selected=\"selected\"</c:if>>${pmax}</option>
            		</c:forEach>
            	</select> 명
            </td>
        </tr>
        <tr>
            <th>침대 타입</th>
            <td colspan="3"><input type="text" name="room_bed" value="${ room.room_bed }" class="form-control" /></td>
        </tr>

        <tr>
            <td colspan="4" class="space" nowrap="nowrap"></td>
        </tr>

        <tr>
            <th>FEATURES</th>
            <td colspan="3">
                <c:forEach var="rfeat" items="${roomFeat}">
                <div class="form-check form-check-inline">
                	<label class="form-check-label"><input type="checkbox" name="room_features" value="${rfeat}" class="form-check-input" <c:if test="${ room.room_features.contains(rfeat) }"> checked="checked"</c:if> />${rfeat}</label>
                </div>
                </c:forEach>
            </td>
        </tr>
        <tr>
            <th>AMENITIES</th>
            <td colspan="3">
                <c:forEach var="rameni" items="${roomAmeni}">
                <div class="form-check form-check-inline">
                	<label class="form-check-label"><input type="checkbox" name="room_amenities" value="${rameni}" class="form-check-input" <c:if test="${ room.room_amenities.contains(rameni) }"> checked="checked"</c:if> />${rameni}</label>
                </div>
                </c:forEach>
            </td>
        </tr>
        <tr>
            <th>ADD-ON SERVICES</th>
            <td colspan="3">
                <c:forEach var="rservice" items="${roomService}">
                <div class="form-check form-check-inline">
                	<label class="form-check-label"><input type="checkbox" name="room_service" value="${rservice}" class="form-check-input" <c:if test="${ room.room_service.contains(rservice) }"> checked="checked"</c:if> />${rservice}</label>
                </div>
                </c:forEach>
            </td>
        </tr>

        <tr>
            <td colspan="4" class="space" nowrap="nowrap"></td>
        </tr>

        <tr>
            <th>TAGS</th>
            <td colspan="3"><input type="text" name="room_tag" value="${room.room_tag}" class="form-control" data-role="tagsinput" /></td>
        </tr>

        <tr>
            <td colspan="4" class="space" nowrap="nowrap"></td>
        </tr>

        <tr>
            <th>사진 1</th>
            <td colspan="3">
				<input type="file" name="room_photo1" class="form-control w-50" />
				<c:if test="${!empty room.room_photo1}"><p class="mt-2"><img src="<%=request.getContextPath()%>${room.room_photo1}" style="max-height: 150px;" alt="" /></p>
                <div class="form-check form-check-inline">
                	<label class="form-check-label"><input type="checkbox" name="room_file_delete" value="Y1" /> 등록된 사진 삭제</label>
                </div>
				</c:if>
            </td>
        </tr>
        <tr>
            <th>사진 2</th>
            <td colspan="3">
				<input type="file" name="room_photo2" class="form-control w-50" />
				<c:if test="${!empty room.room_photo2}"><p class="mt-2"><img src="<%=request.getContextPath()%>${room.room_photo2}" style="max-height: 150px;" alt="" /></p>
				<div class="form-check form-check-inline">
                	<label class="form-check-label"><input type="checkbox" name="room_file_delete" value="Y2" /> 등록된 사진 삭제</label>
                </div>
				</c:if>
            </td>
        </tr>
        <tr>
            <th>사진 3</th>
            <td colspan="3">
				<input type="file" name="room_photo3" class="form-control w-50" />
				<c:if test="${!empty room.room_photo3}"><p class="mt-2"><img src="<%=request.getContextPath()%>${room.room_photo3}" style="max-height: 150px;" alt="" /></p>
				<div class="form-check form-check-inline">
                	<label class="form-check-label"><input type="checkbox" name="room_file_delete" value="Y3" /> 등록된 사진 삭제</label>
                </div>
				</c:if>
            </td>
        </tr>
        <tr>
            <th>사진 4</th>
            <td colspan="3">
				<input type="file" name="room_photo4" class="form-control w-50" />
				<c:if test="${!empty room.room_photo4}"><p class="mt-2"><img src="<%=request.getContextPath()%>${room.room_photo4}" style="max-height: 150px;" alt="" /></p>
				<div class="form-check form-check-inline">
                	<label class="form-check-label"><input type="checkbox" name="room_file_delete" value="Y4" /> 등록된 사진 삭제</label>
                </div> 
				</c:if>
            </td>
        </tr>
        <tr>
            <th>사진 5</th>
            <td colspan="3">
				<input type="file" name="room_photo5" class="form-control w-50" />
				<c:if test="${!empty room.room_photo5}"><p class="mt-2"><img src="<%=request.getContextPath()%>${room.room_photo5}" style="max-height: 150px;" alt="" /></p>
				<div class="form-check form-check-inline">
                	<label class="form-check-label"><input type="checkbox" name="room_file_delete" value="Y5" /> 등록된 사진 삭제</label>
                </div>
				</c:if>
            </td>
        </tr>
    </table>



    <div class="gw-button">
        <div class="gwb-wrap w-100 d-block">
            <div class="gwb-left"></div>

            <div class="gwb-center w-100">
                <button type="button" class="btn btn-lg btn-outline-secondary mx-1" onclick="popWindow('<%=request.getContextPath()%>/admin/stayRoomView.do?room_no=${ room.room_no }&stay_no=${ param.stay_no }', '1400', '900'); window.close();"><i class="fa fa-bars"></i> 돌아가기</button>
                <button type="button" class="btn btn-lg btn-primary mx-1" onclick="write_form.submit();"><i class="fa fa-pencil"></i> 수정하기</button>
            </div>

            <div class="gwb-right"></div>
        </div>
    </div>
    </form>
</div>




<jsp:include page="../layout/layout_footer.jsp" />