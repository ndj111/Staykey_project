<%@page import="java.util.List"%>
<%@page import="com.model.ReviewDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../layout/layout_header.jsp" />

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="list" value="${List}" />


<script type="text/javascript">$("#nav-review").addClass("now");</script>
<div class="d-flex justify-content flex-wrap flex-md-nowrap align-items-center pt-4 pb-2 mb-4 border-bottom">
    <h2>후기 목록</h2>
    <small>등록된 후기 게시물들을 확인하고 관리 할 수 있습니다.</small>
</div>


<div>
    <form name="search_form" method="post" action="reviewList.do">
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
            <th>숙소 이름</th>
            <td><input type="text" name="ps_stayname" value="${map.ps_stayname}" maxlength="255" class="form-control w-90" /></td>
            <th>작성자 이름</th>
            <td><input type="text" name="ps_name" value="${map.ps_name}" maxlength="50" class="form-control w-90" /></td>
            <th>작성자 아이디</th>
            <td><input type="text" name="ps_id" value="${map.ps_id}" maxlength="30" class="form-control w-90" /></td>
        </tr>
    </table>

    <div class="text-center mb-5">
        <a href="<%=request.getContextPath()%>/admin/reviewList.do" class="btn btn-outline-secondary"><i class="fa fa-power-off"></i> 검색 초기화</a>
        <button type="submit" class="btn btn-secondary mx-2"><i class="fa fa-search"></i> 후기 검색</button>
    </div>
    </form>




    <div class="table-top clear">
        <div class="tt-left">총 <b><fmt:formatNumber value="${listCount}" /></b> 개의 후기</div>
        <div class="tt-right">
            <select name="ps_order" class="form-select" onChange="location.href='<%=request.getContextPath()%>/admin/reviewList.do?ps_type=${map.ps_type}&ps_name=${map.ps_name}&ps_id=${map.ps_id}&ps_point=${map.ps_point}&ps_order='+this.value;">
                <option value="date_desc"<c:if test="${map.ps_order == 'date_desc'}"> selected="selected"</c:if>>작성일 최신</option>
                <option value="date_asc"<c:if test="${map.ps_order == 'date_asc'}"> selected="selected"</c:if>>작성일 예전</option>
                <option value="" disabled="disabled">---------------</option>
                <option value="point_desc"<c:if test="${map.ps_order == 'point_desc'}"> selected="selected"</c:if>>평점 높은</option>
                <option value="point_asc"<c:if test="${map.ps_order == 'point_asc'}"> selected="selected"</c:if>>평점 낮은</option>
                <option value="" disabled="disabled">---------------</option>
                <option value="name_desc"<c:if test="${map.ps_order == 'name_desc'}"> selected="selected"</c:if>>숙소이름 역순</option>
                <option value="name_asc"<c:if test="${map.ps_order == 'name_asc'}"> selected="selected"</c:if>>숙소이름 순</option>
            </select>
        </div>
    </div>



    <table class="table-list hover">
        <colgroup>
            <col width="4.5%">
            <col width="7.2%">
            <col width="12%">
            <col width="5%">
            <col width="20%">
            <col width="8%">
            <col width="9%">
            <col width="7.2%">
        </colgroup>

        <thead>
            <tr>
                <th>리뷰 번호</th>
                <th>리뷰 사진</th>
                <th>숙소명</th>
                <th>평점</th>
                <th>리뷰 내용</th>
                <th>작성자<br>아이디</th>
                <th>작성일</th>
                <th>기능</th>
            </tr>
        </thead>

        <tbody>
            <c:choose>
            <c:when test="${!empty list }">
            <c:forEach items="${list}" var="dto">
            <c:set var="showLink" value="onclick=\"popWindow('../admin/reviewView.do?id=${dto.review_no}', '700', '900');\"" />
            <tr>
                <td ${showLink} class="eng">${dto.review_no}</td>
                <td ${showLink} class="photo">
                    <c:choose>
                    <c:when test="${!empty dto.review_file }"><img src="<%=request.getContextPath()%>${dto.review_file}" alt="" /></c:when>
                    <c:otherwise>
                    <svg class="bd-placeholder-img" width="98" height="60" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false" role="img">
                        <title>${dto.review_name}</title>
                        <rect width="100%" height="100%" fill="#eee"></rect>
                        <text x="48%" y="54%" fill="#888" dy=".1em">no img</text>
                    </svg>
                    </c:otherwise>
                    </c:choose>
                </td>
				<td ${showLink} class="py-4">   
					 <p><b>${dto.review_stayname}</b></p>
					 <p>${dto.review_roomname}</p> 
				</td>
                <td ${showLink} class="eng"><p>${dto.review_point_total}</p></td>
                <td ${showLink} class="px-4">
                    <c:if test="${dto.review_content.length() < 20}">${dto.review_content}</c:if>
                    <c:if test="${dto.review_content.length() >= 20 && dto.review_content.length() < 45}">${dto.review_content}</c:if>
                    <c:if test="${dto.review_content.length() >= 45}">${dto.review_content.substring(0,45)}</c:if>
               
                </td>
                <td ${showLink}>
                	<p><b>${dto.review_name}</b></p>
                	<p class="eng">${dto.review_id}</p>
                </td>
                <td ${showLink} class="eng">${dto.review_date.substring(0, 10)}<br />${dto.review_date.substring(11)}</td>
                
                <td>
                	<a href="<%=request.getContextPath()%>/admin/reviewModify.do?id=${dto.review_no}" class="btn btn-sm btn-outline-primary m-1">수정</a>
                    <a href="<%=request.getContextPath()%>/admin/reviewDeleteOk.do?id=${dto.review_no}" class="btn btn-sm btn-outline-danger m-1" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
                </td>
                
            </tr>
            </c:forEach>
            </c:when>

            <c:otherwise>
            <tr>
                <td colspan="8" class="nodata">등록된 후기가 없습니다.</td>
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

                            </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
        </tfoot>
    </table>
</div>




<jsp:include page="../layout/layout_footer.jsp" />