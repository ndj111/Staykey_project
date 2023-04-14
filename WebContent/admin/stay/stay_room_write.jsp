<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../layout/layout_header_popup.jsp" />

<%@ page import="com.util.showArray" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<script type="text/javascript">
form_check = function(){
    var form = document.write_form;

    if(form.room_name.value == ""){
        alert("[Room 이름]을 입력해 주세요.");
        form.room_name.focus();
        return false;
    }

    if(form.room_price.value == "" || form.room_price.value <= 0){
        alert("[가격]을 0 보다 큰 값을 입력해 주세요.");
        form.room_price.focus();
        return false;
    }

    if(form.room_price.value == "" || form.room_price.value <= 0){
        alert("[객실면적]을 0 보다 큰 값을 입력해 주세요.");
        form.room_price.focus();
        return false;
    }

    form.submit();
};
</script>


<style type="text/css">body { padding: 0 30px !important; }</style>
<div class="d-flex justify-content flex-wrap flex-md-nowrap align-items-center pt-4 pb-2 mb-4 border-bottom">
    <h2>Room 등록하기</h2>
    <small>새로운 Room을 등록 할 수 있습니다.</small>
</div>



<div class="pb100">
    <form name="write_form" method="post" enctype="multipart/form-data" action="<%=request.getContextPath() %>/admin/stayRoomWriteOk.do" onsubmit="return false;">
    <input type="hidden" name="stayNo" value="${ param.stay_no }" /> <!-- 숙소 번호 -->
    <table class="table-form mt-3">
        <colgroup>
            <col width="16%" />
            <col width="34%" />
            <col width="16%" />
            <col />
        </colgroup>
        <tr>
            <th>Room 이름</th>
            <td colspan="3"><input type="text" name="room_name" maxlength="255" class="form-control w-50" required /></td>
        </tr>
        <tr>
            <th>간략 설명</th>
            <td colspan="3"><textarea name="room_desc" cols="30" rows="3" class="form-control"></textarea></td>
        </tr>

        <tr>
            <td colspan="4" class="space" nowrap="nowrap"></td>
        </tr>

        <tr>
            <th>방 타입</th>
            <td colspan="3">
                <%
                    showArray getRoomtype = new showArray();
                    getRoomtype.getList("roomType");
                    List<String> roomType = getRoomtype.listArr;
        
                    String RTchecked = "";
                    for(int i=0; i<roomType.size(); i++){
                        if(i == 0){
                            RTchecked = " checked=\"checked\"";
                        }else{
                            RTchecked = "";
                        }
                %>
                <div class="form-check form-check-inline">
                    <label class="form-check-label"><input type="radio" name="room_type" value="<%=roomType.get(i)%>" class="form-check-input"<%=RTchecked%> /> <%=roomType.get(i)%></label>
                </div>
                <%} %>
            </td>
        </tr>
        <tr>
            <th>가격</th>
            <td><input type="text" name="room_price" value="0" class="form-control w-60 text-center d-inline mr-1" required />원</td>
            <th>객실면적</th>
            <td><input type="text" name="room_size" value="0" class="form-control w-40 text-center d-inline mr-1" required />㎡</td>
        </tr>
        <tr>
            <th>체크인 시간</th>
            <td>
            	<select name="room_checkin" class="form-select" required>
            		<c:forEach begin="10" end="24" var="intime">
            		<option value="${intime}:00">${intime}:00</option>
            		</c:forEach>
            	</select>
            </td>
            <th>체크아웃 시간</th>
            <td>
            	<select name="room_checkout" class="form-select" required>
            		<c:forEach begin="10" end="24" var="outtime">
            		<option value="${outtime}:00">${outtime}:00</option>
            		</c:forEach>
            	</select>
            </td>
        </tr>
        <tr>
            <th>기준인원</th>
            <td>
            	<select name="room_people_min" class="form-select">
            		<c:forEach begin="1" end="15" var="pmin">
            		<option value="${pmin}">${pmin}</option>
            		</c:forEach>
            	</select> 명
            </td>
            <th>최대인원</th>
            <td>
            	<select name="room_people_max" class="form-select">
            		<c:forEach begin="1" end="15" var="pmax">
            		<option value="${pmax}">${pmax}</option>
            		</c:forEach>
            	</select> 명
            </td>
        </tr>
        <tr>
            <th>침대 타입</th>
            <td colspan="3"><input type="text" name="room_bed" class="form-control" /></td>
        </tr>

        <tr>
            <td colspan="4" class="space" nowrap="nowrap"></td>
        </tr>

        <tr>
            <th>FEATURES</th>
            <td colspan="3">
                <%
                    showArray getRoomFeat = new showArray();
                    getRoomFeat.getList("roomFeat");
                    List<String> roomFeat = getRoomFeat.listArr;

                    for(int i=0; i<roomFeat.size(); i++){
                %>
                <div class="form-check form-check-inline">
                	<label class="form-check-label"><input type="checkbox" name="room_features" value="<%=roomFeat.get(i)%>" /> <%=roomFeat.get(i)%></label>
                </div>
                <%} %>
            </td>
        </tr>
        <tr>
            <th>AMENITIES</th>
            <td colspan="3">
                <%
                    showArray getRoomAmeni = new showArray();
                    getRoomAmeni.getList("roomAmeni");
                    List<String> roomAmeni = getRoomAmeni.listArr;

                    for(int i=0; i<roomAmeni.size(); i++){
                %>
                <div class="form-check form-check-inline">
                	<label class="form-check-label"><input type="checkbox" name="room_amenities" value="<%=roomAmeni.get(i)%>" /> <%=roomAmeni.get(i)%></label>
                </div>
                <%} %>

            </td>
        </tr>
        <tr>
            <th>ADD-ON SERVICES</th>
            <td colspan="3">
                <%
                    showArray getRoomService = new showArray();
                    getRoomService.getList("roomService");
                    List<String> roomService = getRoomService.listArr;

                    for(int i=0; i<roomService.size(); i++){
                %>
                <div class="form-check form-check-inline">
                	<label class="form-check-label"><input type="checkbox" name="room_service" value="<%=roomService.get(i)%>" /> <%=roomService.get(i)%></label>
                </div>
                <%} %>
            </td>
        </tr>

        <tr>
            <td colspan="4" class="space" nowrap="nowrap"></td>
        </tr>

        <tr>
            <th>TAGS</th>
            <td colspan="3"><input type="text" name="room_tag" class="form-control" data-role="tagsinput" /></td>
        </tr>

        <tr>
            <td colspan="4" class="space" nowrap="nowrap"></td>
        </tr>

        <tr>
            <th>사진 1</th>
            <td colspan="3"><input type="file" name="room_photo1" class="form-control w-50" /></td>
        </tr>
        <tr>
            <th>사진 2</th>
            <td colspan="3"><input type="file" name="room_photo2" class="form-control w-50" /></td>
        </tr>
        <tr>
            <th>사진 3</th>
            <td colspan="3"><input type="file" name="room_photo3" class="form-control w-50" /></td>
        </tr>
        <tr>
            <th>사진 4</th>
            <td colspan="3"><input type="file" name="room_photo4" class="form-control w-50" /></td>
        </tr>
        <tr>
            <th>사진 5</th>
            <td colspan="3"><input type="file" name="room_photo5" class="form-control w-50" /></td>
        </tr>
    </table>



    <div class="gw-button">
        <div class="gwb-wrap w-100 d-block">
            <div class="gwb-left"></div>

            <div class="gwb-center w-100">
                <button type="button" class="btn btn-lg btn-outline-secondary mx-1" onclick="window.close();"><i class="fa fa-times"></i> 창 닫기</button>
                <button type="button" class="btn btn-lg btn-primary mx-1" onclick="form_check();"><i class="fa fa-pencil"></i> 등록하기</button>
            </div>

            <div class="gwb-right"></div>
        </div>
    </div>
    </form>
</div>




<jsp:include page="../layout/layout_footer.jsp" />