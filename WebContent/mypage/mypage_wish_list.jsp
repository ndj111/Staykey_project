<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="../layout/layout_header.jsp" />
<jsp:include page="../mypage/mypage_header.jsp" />

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="staylist" value="${list}" />

<script type="text/javascript">$("#mymenu-wish").addClass("now");</script>



<div class="wish-list">
	<ul class="wl-list">
		<c:choose>
		<c:when test="${!empty staylist}">
		<c:forEach var="dto" items="${staylist}">
		<li>
			<div class="wll-info">
				<p class="name">${dto.stay_name}</p>
				<p class="loc">${dto.stay_location}</p>
				<p class="people">최소 ${dto.stay_room_people_min}명 / 최대 ${dto.stay_room_people_max}명</p>
				<p class="price"><fmt:setLocale value="ko_kr" /><fmt:formatNumber value="${dto.stay_room_price_min}" type="currency" /> ~ <c:if test="${dto.stay_room_price_min < dto.stay_room_price_max}"><fmt:setLocale value="ko_kr" /><fmt:formatNumber value="${dto.stay_room_price_max}" type="currency" /></c:if></p>
				<p class="link">
					<a href="<%=request.getContextPath()%>/stayView.do?stay_no=${dto.stay_no}"><i class="fa fa-check"></i> 예약하기</a>
					<button type="button" onclick="delWish('${dto.stay_name}', '${dto.stay_no}', '${login_id}');"><i class="fa fa-trash-o"></i> 찜삭제</button>
				</p>
			</div>
			<a href="<%=request.getContextPath()%>/stayView.do?stay_no=${dto.stay_no}" class="wll-photo" style="background-image: url('<%=request.getContextPath()%>${dto.stay_file1 }');"></a>
		</li>
		</c:forEach>
		</c:when>

		<c:otherwise>
		<li class="nodata">등록된 관심 스테이가 없습니다.</li>
		</c:otherwise>
		</c:choose>
	</ul>


	<div class="wl-paging">
		${map.pagingWrite}
	</div>
</div>




<jsp:include page="../mypage/mypage_footer.jsp" />
<jsp:include page="../layout/layout_footer.jsp" />