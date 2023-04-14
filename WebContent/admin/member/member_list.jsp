<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../layout/layout_header.jsp" />

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="list" value="${List}" />


<script type="text/javascript">$("#nav-member").addClass("now");</script>
<div class="d-flex justify-content flex-wrap flex-md-nowrap align-items-center pt-4 pb-2 mb-4 border-bottom">
    <h2>회원 목록</h2>
    <small>등록된 회원/관리자 목록을 확인하고 관리 할 수 있습니다.</small>
</div>


<div>
    <form name="search_form" method="post" action="memberList.do">
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
            <th>회원 구분</th>
            <td colspan="5">
                <div class="form-check form-check-inline ml-1">
                    <label class="form-check-label"><input type="radio" name="ps_type" value="all" class="form-check-input"<c:if test="${map.ps_type == 'all'}"> checked="checked"</c:if> /> 전체</label>
                </div>
                <div class="form-check form-check-inline">
                    <label class="form-check-label"><input type="radio" name="ps_type" value="user" class="form-check-input"<c:if test="${map.ps_type == 'user'}"> checked="checked"</c:if> /> 일반회원</label>
                </div>
                <div class="form-check form-check-inline">
                    <label class="form-check-label"><input type="radio" name="ps_type" value="exit" class="form-check-input"<c:if test="${map.ps_type == 'exit'}"> checked="checked"</c:if> /> 탈퇴회원</label>
                </div>
                <div class="form-check form-check-inline">
                    <label class="form-check-label"><input type="radio" name="ps_type" value="admin" class="form-check-input"<c:if test="${map.ps_type == 'admin'}"> checked="checked"</c:if> /> 관리자</label>
                </div>
            </td>
        </tr>
        <tr>
            <th>회원 이름</th>
            <td><input type="text" name="ps_name" value="${map.ps_name}" maxlength="50" class="form-control w-90" /></td>
            <th>회원 아이디</th>
            <td><input type="text" name="ps_id" value="${map.ps_id}" maxlength="30" class="form-control w-90" /></td>
            <th>회원 이메일</th>
            <td><input type="text" name="ps_email" value="${map.ps_email}" maxlength="255" class="form-control w-90" /></td>
        </tr>
    </table>

    <div class="text-center mb-5">
        <a href="<%=request.getContextPath()%>/admin/memberList.do" class="btn btn-outline-secondary"><i class="fa fa-power-off"></i> 검색 초기화</a>
        <button type="submit" class="btn btn-secondary mx-2"><i class="fa fa-search"></i> 회원 검색</button>
    </div>
    </form>





    <div class="table-top clear">
        <div class="tt-left">총 <b><fmt:formatNumber value="${listCount}" /></b> 명의 회원</div>
        <div class="tt-right">
            <select name="ps_order" class="form-select" onChange="location.href='<%=request.getContextPath()%>/admin/memberList.do?ps_type=${map.ps_type}&ps_name=${map.ps_name}&ps_id=${map.ps_id}&ps_email=${map.ps_email}&ps_order='+this.value;">
                <option value="register_desc"<c:if test="${map.ps_order == 'register_desc'}"> selected="selected"</c:if>>등록일 최신</option>
                <option value="register_asc"<c:if test="${map.ps_order == 'register_asc'}"> selected="selected"</c:if>>등록일 예전</option>
                <option value="" disabled="disabled">---------------</option>
                <option value="id_desc"<c:if test="${map.ps_order == 'id_desc'}"> selected="selected"</c:if>>아이디 역순</option>
                <option value="id_asc"<c:if test="${map.ps_order == 'id_asc'}"> selected="selected"</c:if>>아이디 순</option>
                <option value="" disabled="disabled">---------------</option>
                <option value="name_desc"<c:if test="${map.ps_order == 'name_desc'}"> selected="selected"</c:if>>회원이름 역순</option>
                <option value="name_asc"<c:if test="${map.ps_order == 'name_asc'}"> selected="selected"</c:if>>회원이름 순</option>
                <option value="" disabled="disabled">---------------</option>
                <option value="count_desc"<c:if test="${map.ps_order == 'count_desc'}"> selected="selected"</c:if>>예약횟수 높은</option>
                <option value="count_asc"<c:if test="${map.ps_order == 'count_asc'}"> selected="selected"</c:if>>예약횟수 낮은</option>
            </select>
        </div>
    </div>



    <table class="table-list hover">
        <colgroup>
            <col width="4.5%">
            <col width="7.2%">
            <col width="7.2%">
            <col width="14%">
            <col width="20%">
            <col width="16.5%">
            <col width="7.2%">
            <col />
            <col width="10%">
        </colgroup>

        <thead>
            <tr>
                <th>No.</th>
                <th>유형</th>
                <th>사진</th>
                <th>이름<br>아이디</th>
                <th>이메일</th>
                <th>전화번호</th>
                <th>예약횟수</th>
                <th>등록일</th>
                <th>기능</th>
            </tr>
        </thead>

        <tbody>
            <c:choose>
            <c:when test="${!empty list }">
            <c:forEach items="${list}" var="dto">
            <c:set var="showLink" value="onclick=\"popWindow('../admin/memberView.do?id=${dto.getMember_id()}', '700', '900');\"" />
            <tr>
                <td ${showLink}>${dto.getMember_no()}</td>
                <td ${showLink}><c:choose><c:when test="${dto.getMember_type() == 'admin'}">관리자</c:when><c:when test="${dto.getMember_type() == 'exit'}">탈퇴회원</c:when><c:otherwise>회원</c:otherwise></c:choose></td>
                <td ${showLink} class="photo">
                    <c:choose>
                    <c:when test="${!empty dto.getMember_photo() }"><img src="<%=request.getContextPath()%>${dto.getMember_photo()}" alt="" /></c:when>
                    <c:otherwise>
                    <svg class="bd-placeholder-img" width="70" height="60" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false" role="img">
                        <title>${dto.getMember_name()}</title>
                        <rect width="100%" height="100%" fill="#eee"></rect>
                        <text x="48%" y="54%" fill="#888" dy=".1em">no img</text>
                    </svg>
                    </c:otherwise>
                    </c:choose>
                </td>
                <td ${showLink} class="py-4">
                    <p class="mb-1"><b>${dto.getMember_name()}</b></p>
                    <p class="eng">${dto.getMember_id()}</p>
                </td>
                <td class="eng" ${showLink}>
                    <c:choose>
                    <c:when test="${dto.getMember_type() == 'exit'}">-</c:when>
                    <c:otherwise>${dto.getMember_email()}</c:otherwise>
                    </c:choose>
                </td>
                <td class="eng" ${showLink}>
                    <c:choose>
                    <c:when test="${dto.getMember_type() == 'exit'}">-</c:when>
                    <c:otherwise>${dto.getMember_phone()}</c:otherwise>
                    </c:choose>
                </td>
                <td class="eng" ${showLink}>
                    <c:choose>
                    <c:when test="${dto.getMember_type() == 'exit'}">-</c:when>
                    <c:otherwise><fmt:formatNumber value="${dto.getMember_reserv()}" />번</c:otherwise>
                    </c:choose>
                </td>
                <td class="eng" ${showLink}>${dto.getMember_joindate().substring(0, 10)}<br />${dto.getMember_joindate().substring(11)}</td>
                <td>
                    <a href="<%=request.getContextPath()%>/admin/memberModify.do?id=${dto.getMember_id()}" class="btn btn-sm btn-outline-primary m-1">수정</a>
                    <a href="<%=request.getContextPath()%>/admin/memberDeleteOk.do?id=${dto.getMember_id()}" class="btn btn-sm btn-outline-danger m-1" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
                </td>
            </tr>
            </c:forEach>
            </c:when>

            <c:otherwise>
            <tr>
                <td colspan="9" class="nodata">등록된 회원이 없습니다.</td>
            </tr>
            </c:otherwise>
            </c:choose>
        </tbody>


        <tfoot>
            <tr>
                <td colspan="9">
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

                                <td class="text-right"><a href="<%=request.getContextPath()%>/admin/memberWrite.do" class="btn btn-primary"><i class="fa fa-pencil"></i> 회원 등록</a></td>
                            </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
        </tfoot>
    </table>
</div>




<jsp:include page="../layout/layout_footer.jsp" />