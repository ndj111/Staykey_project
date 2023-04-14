<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="../layout/layout_header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="list" value="${List}" />
	
	
	
	<!-- 영문은 td태그에 class="eng" 추가하기. -->
	<!-- col width % 계산법 : 픽셀(ex.80) / 1110(전체 사이즈) * 100 -->
	
	
	<script type="text/javascript">
		$("#nav-magazine").addClass("now");
	</script>
	<div
		class="d-flex justify-content flex-wrap flex-md-nowrap align-items-center pt-4 pb-2 mb-4 border-bottom">
		<h2>매거진 목록</h2>
		<small>등록된 매거진 게시물들을 확인하고 관리 할 수 있습니다.</small>
	</div>
	
	
	<!-- 목록 비율 설정 -->
	<div>
		<form name="search_form" method="post" action="magazineList.do">
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
	
	
				<!-- 검색 설정 : 글 제목, 작성자로 검색 가능 -->
				<tr>
					<th>글 제목</th>
					<td><input type="text" name="mg_title" value="${map.mg_title}"
						maxlength="255" class="form-control w-90" /></td>
					<th>작성자</th>
					<td><input type="text" name="mg_writer_name" value="${map.mg_writer_name}"
						maxlength="30" class="form-control w-90" /></td>
				</tr>
			</table>
	
	
			<!-- 검색 버튼 -->
			<div class="text-center mb-5">
				<a href="<%=request.getContextPath()%>/admin/magazineList.do"
					class="btn btn-outline-secondary"><i class="fa fa-power-off"></i>
					검색 초기화</a>
				<button type="submit" class="btn btn-secondary mx-2">
					<i class="fa fa-search"></i> 매거진 검색
				</button>
			</div>
		</form>
	
	
	
	
		<!-- 총 n개의 매거진 -->
		<div class="table-top clear">
			<div class="tt-left">
				총 <b><fmt:formatNumber value="${listCount}" /></b> 개의 매거진
			</div>
			
			
			<!-- 정렬 설정 : 등록일, 글 제목, 조회수로 정렬 가능 -->
			<div class="tt-right">
				<select name="ps_order" class="form-select"
				onChange="location.href='<%=request.getContextPath()%>/admin/magazineList.do?bbs_date=${map.bbs_date}&bbs_title=${map.bbs_title}&bbs_hit=${map.bbs_hit}&ps_order='+this.value;">
					
				<option value="bbs_date_desc"<c:if test="${map.ps_order == 'bbs_date_desc'}"> selected="selected"</c:if>>등록일 최신</option>
                <option value="bbs_date_asc"<c:if test="${map.ps_order == 'bbs_date_asc'}"> selected="selected"</c:if>>등록일 예전</option>
                <option value="" disabled="disabled">---------------</option>
                
                <option value="bbs_title_desc"<c:if test="${map.ps_order == 'bbs_title_desc'}"> selected="selected"</c:if>>글 제목 역순</option>
                <option value="bbs_title_asc"<c:if test="${map.ps_order == 'bbs_title_asc'}"> selected="selected"</c:if>>글 제목 순</option>
                <option value="" disabled="disabled">---------------</option>
                
                <option value="bbs_hit_desc"<c:if test="${map.ps_order == 'bbs_hit_desc'}"> selected="selected"</c:if>>조회수 역순</option>
                <option value="bbs_hit_asc"<c:if test="${map.ps_order == 'bbs_hit_asc'}"> selected="selected"</c:if>>조회수 순</option>

				
				</select>
			</div>
		</div>
		
	
	
		<!-- 테이블 % 설정 -->
		<table class="table-list hover">
			<colgroup>
				<col width="7.5%">
				<col width="7.5%">
				<col />
				<col width="11%">
				<col width="11%">
				<col width="7.5%">
				<col width="11%">
			</colgroup>
	
	
			<thead>
				<tr>
					<th>No.</th>
					<th>목록 이미지</th>
					<th>글 제목</th>
					<th>작성자<br>아이디</th>
					<th>작성일자</th>
					<th>조회수</th>
					<th>기능</th>
				</tr>
			</thead>
	
	
			<tbody>
				<!-- 매거진 게시물이 있는 경우 -->
				<c:choose>
					<c:when test="${!empty list }">
						<c:forEach items="${list}" var="dto">
							<c:set var="showLink" value="onclick=\"
								popWindow('../admin/magazineView.do?bbs_no=${dto.bbs_no }', '1400', '900');\"" />
							<tr>
								<td ${showLink} class="eng">${dto.bbs_no }</td>
	
								<td ${showLink} class="photo">
								<c:choose>
										<c:when test="${!empty dto.bbs_list_img }">
											<img src="<%=request.getContextPath()%>${dto.bbs_list_img }"
												 alt="" />
										</c:when>
										<c:otherwise> <!-- 이미지가 없는 경우 기본 이미지 -->
											<svg class="bd-placeholder-img" width="60" height="60"
												xmlns="http://www.w3.org/2000/svg"
												preserveAspectRatio="xMidYMid slice" focusable="false"
												role="img">
					                            <title>${dto.bbs_no}</title>
					                            <rect width="100%" height="100%" fill="#eee"></rect>
					                            <text x="48%" y="54%" fill="#888" dy=".1em">no img</text>
					                        </svg>
										</c:otherwise>
									</c:choose>
								</td>
	
	
								<td ${showLink} class="eng">${dto.bbs_title}</td>
	
								<td ${showLink} class="py-4">
									<p><b class="eng">${dto.bbs_writer_name}</b></p>
									<p>${dto.bbs_writer_id}</p>
								</td>
	
								<td ${showLink} class="eng">${dto.bbs_date.substring(0,10)}<br />${dto.bbs_date.substring(11)}</td>
								
								<td ${showLink} class="eng">${dto.bbs_hit}</td>
	
								
								<!-- 기능 버튼 영역 -->
								<td><a
									href="<%=request.getContextPath()%>/admin/magazineModify.do?bbs_no=${dto.bbs_no}"
									class="btn btn-sm btn-outline-primary m-1">수정</a> <a
									href="<%=request.getContextPath()%>/admin/magazineDeleteOk.do?bbs_no=${dto.bbs_no}"
									class="btn btn-sm btn-outline-danger m-1"
									onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a></td>
	
	
							</tr>
						</c:forEach>
					</c:when>
	
	
					<c:otherwise>
						<tr>
							<td colspan="7" class="nodata">등록된 매거진이 없습니다.</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
	
	
	
			<!-- 하단 부분 -->
			<tfoot>
				<tr>
					<td colspan="7">
						<table class="paging-table">
							<colgroup>
								<col width="120">
								<col>
								<col width="120">
							</colgroup>
							<tbody>
								<tr>
									<td class="text-left"></td>
	
									<td class="text-center">${map.pagingWrite}</td>
	
									<td class="text-right"><a
										href="<%=request.getContextPath()%>/admin/magazineWrite.do"
										class="btn btn-primary"><i class="fa fa-pencil"></i> 매거진 등록</a></td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
			</tfoot>
		</table>
	</div>
	
	
	
	<jsp:include page="../layout/layout_footer.jsp" />