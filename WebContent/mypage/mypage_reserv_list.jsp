<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../layout/layout_header.jsp" />
<jsp:include page="../mypage/mypage_header.jsp" />

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="reservList" value="${reservList}" />

<script type="text/javascript">$("#mymenu-reserv").addClass("now");</script>

	
<div class="reserv-list">

	<div class="rl-tab">
		<ul>
			<li class="<c:if test="${getType == 'come'}">now</c:if>"><a href="<%=request.getContextPath()%>/mypageReservList.do?type=come">다가올 예약</a></li>
			<li class="<c:if test="${getType == 'done'}">now</c:if>"><a href="<%=request.getContextPath()%>/mypageReservList.do?type=done">이용 완료</a></li>
			<li class="<c:if test="${getType == 'cancel'}">now</c:if>"><a href="<%=request.getContextPath()%>/mypageReservList.do?type=cancel">취소 내역</a></li>
		</ul>
	</div>



	<ul class="rl-list">
		<c:choose>
		<c:when test="${!empty reservList}">
		<c:forEach var="list" items="${reservList}">
		<li class="<c:if test="${getType == list.reserv_class}">show</c:if>">
			<a href="<%=request.getContextPath()%>/stayView.do?stay_no=${list.reserv_stayno}" class="rll-photo" style="background-image: url('<%=request.getContextPath()%>${list.reserv_stay_photo}');"></a>
			<div class="rll-info">
				<p class="sess">${list.reserv_sess}</p>
				<p class="name">${list.reserv_stayname}<small>${list.reserv_roomname}</small></p>
				<p class="date">${list.reserv_start.substring(0,10).replace("-", ". ")} ~ ${list.reserv_end.substring(0,10).replace("-", ". ")} (${list.reserv_daycount}박)</p>
				<p class="people">
					<c:if test="${list.reserv_people_adult > 0}"><span>성인 ${list.reserv_people_adult}명</span></c:if>
					<c:if test="${list.reserv_people_kid > 0}"><span>아동 ${list.reserv_people_kid}명</span></c:if>
					<c:if test="${list.reserv_people_baby > 0}"><span>영아 ${list.reserv_people_baby}명</span></c:if>
				</p>
				<p class="price"><fmt:setLocale value="ko_kr" /><fmt:formatNumber value="${list.reserv_total_price}" type="currency" /></p>
				<p class="link">
					<a href="<%=request.getContextPath()%>/mypageReservView.do?reserv_sess=${list.reserv_sess}"><i class="fa fa-search"></i> 예약상세내역</a>
					<c:if test="${getType == 'done' && list.reserv_review == 'N' && list.reserv_review_roomno == 0}"><button type="button" class="rbtn" data-toggle="modal" data-target="#review-write" onclick="setReviewWrite(${list.reserv_stayno}, '${list.reserv_stayname}', ${list.reserv_roomno}, '${list.reserv_roomname}');"><i class="fa fa-pencil"></i> 리뷰작성하기</button></c:if>
					<c:if test="${list.reserv_review_roomno > 0}"><a href="<%=request.getContextPath()%>/stayView.do?stay_no=${list.reserv_stayno}#viewReivew" class="rbtn"><i class="fa fa-folder-open-o"></i> 내가 쓴 후기</a></c:if>
				</p>
			</div>
		</li>
		</c:forEach>
		</c:when>

		<c:otherwise>
		<li class="nodata">
			<p><img src="<%=request.getContextPath()%>/asset/images/no_reserv.png" alt="" /></p>
			<p>예약 정보가 없습니다. 새로운 스테이를 찾아 떠나보세요.</p>
			<a href="<%=request.getContextPath()%>/stayList.do">FIND STAY</a>
		</li>
		</c:otherwise>
		</c:choose>
	</ul>

</div>




<!-- 리뷰 작성 Modal // START -->
<div class="modal" id="review-write" data-backdrop="static" data-keyboard="false" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title"><span></span> 후기 작성하기</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body text-center pt-4 pb-5">
            	<form method="post" enctype="multipart/form-data" action="<%=request.getContextPath()%>/mypageReservReviewOk.do">
        		<input type="hidden" name="review_stayno" value="" />
        		<input type="hidden" name="review_stayname" value="" />
        		<input type="hidden" name="review_roomno" value="" />
        		<input type="hidden" name="review_roomname" value="" />
        		<input type="hidden" name="review_id" value="${login_id}" />
        		<input type="hidden" name="review_pw" value="${login_pw}" />
        		<input type="hidden" name="review_name" value="${login_name}" />
			    <table class="table-form">
			        <colgroup>
			            <col width="16%" />
			            <col />
			        </colgroup>

			        <tbody>
			        	<tr>
			        		<th>접근성</th>
			        		<td>
			        			<c:forEach begin="1" end="10" var="i"><label><input type="radio" name="review_point1" value="${i}"<c:if test="${i == 10}"> checked="checked"</c:if> /> ${i}점</label></c:forEach>
			        		</td>
			        	</tr>
			        	<tr>
			        		<th>서비스</th>
			        		<td>
			        			<c:forEach begin="1" end="10" var="i"><label><input type="radio" name="review_point2" value="${i}"<c:if test="${i == 10}"> checked="checked"</c:if> /> ${i}점</label></c:forEach>
			        		</td>
			        	</tr>
			        	<tr>
			        		<th>객실시설</th>
			        		<td>
			        			<c:forEach begin="1" end="10" var="i"><label><input type="radio" name="review_point3" value="${i}"<c:if test="${i == 10}"> checked="checked"</c:if> /> ${i}점</label></c:forEach>
			        		</td>
			        	</tr>
			        	<tr>
			        		<th>부대시설</th>
			        		<td>
			        			<c:forEach begin="1" end="10" var="i"><label><input type="radio" name="review_point4" value="${i}"<c:if test="${i == 10}"> checked="checked"</c:if> /> ${i}점</label></c:forEach>
			        		</td>
			        	</tr>
			        	<tr>
			        		<th>식음료</th>
			        		<td>
			        			<c:forEach begin="1" end="10" var="i"><label><input type="radio" name="review_point5" value="${i}"<c:if test="${i == 10}"> checked="checked"</c:if> /> ${i}점</label></c:forEach>
			        		</td>
			        	</tr>
			        	<tr>
			        		<th>만족도</th>
			        		<td>
			        			<c:forEach begin="1" end="10" var="i"><label><input type="radio" name="review_point6" value="${i}"<c:if test="${i == 10}"> checked="checked"</c:if> /> ${i}점</label></c:forEach>
			        		</td>
			        	</tr>
				        <tr>
				            <td colspan="2" class="space" nowrap="nowrap"></td>
				        </tr>

			        	<tr>
			        		<th>리뷰 내용</th>
			        		<td><textarea name="review_content" cols="20" rows="4" required></textarea></td>
			        	</tr>
			        	<tr>
			        		<th>리뷰 사진</th>
			        		<td><input type="file" name="review_file" accept="image/jpeg, image/png, image/gif" /></td>
			        	</tr>
			        </tbody>

			        <tfoot>
			        	<tr>
			        		<td colspan="2">
				            	<button type="button" data-dismiss="modal">닫기</button>
				            	<button type="submit" class="write">작성하기</button>
			        		</td>
			        	</tr>
			        </tfoot>
				</table>
            	</form>
            </div>
        </div>
    </div>
</div>
<!-- 리뷰 작성 Modal // END -->


<jsp:include page="../mypage/mypage_footer.jsp" />
<jsp:include page="../layout/layout_footer.jsp" />