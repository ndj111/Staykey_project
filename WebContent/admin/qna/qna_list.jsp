<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../layout/layout_header.jsp" />

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="list" value="${List}" />


<script type="text/javascript">$("#nav-qna").addClass("now");</script>
<div class="d-flex justify-content flex-wrap flex-md-nowrap align-items-center pt-4 pb-2 mb-4 border-bottom">
    <h2>일대일 문의 목록</h2>
    <small>등록된 일대일 문의 게시물들을 확인하고 관리 할 수 있습니다.</small>
</div>


<div>
    <form name="search_form" method="post" action="qnaList.do">
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
            <th>작성자 이름</th>
            <td><input type="text" name="ps_name" value="${map.ps_name}" maxlength="50" class="form-control w-90" /></td>
            <th>작성자 아이디</th>
            <td><input type="text" name="ps_id" value="${map.ps_id}" maxlength="30" class="form-control w-90" /></td>
            <th>글 제목</th>
            <td><input type="text" name="ps_title" value="${map.ps_title}" maxlength="255" class="form-control w-90" /></td>
        </tr>
    </table>

    <div class="text-center mb-5">
        <a href="<%=request.getContextPath()%>/admin/qnaList.do" class="btn btn-outline-secondary"><i class="fa fa-power-off"></i> 검색 초기화</a>
        <button type="submit" class="btn btn-secondary mx-2"><i class="fa fa-search"></i> 문의 검색</button>
    </div>
    </form>





    <div class="table-top clear">
        <div class="tt-left">총 <b><fmt:formatNumber value="${listCount}" /></b> 개의 일대일 문의</div>
        <div class="tt-right">
            <select name="ps_order" class="form-select" onChange="location.href='<%=request.getContextPath()%>/admin/qnaList.do?ps_name=${map.ps_name}&ps_id=${map.ps_id}&ps_hit=${map.ps_title}&ps_order='+this.value;">
                <option value="register_desc"<c:if test="${map.ps_order == 'register_desc'}"> selected="selected"</c:if>>등록일 최신</option>
                <option value="register_asc"<c:if test="${map.ps_order == 'register_asc'}"> selected="selected"</c:if>>등록일 예전</option>
                <option value="" disabled="disabled">---------------</option>
                <option value="id_desc"<c:if test="${map.ps_order == 'id_desc'}"> selected="selected"</c:if>>아이디 역순</option>
                <option value="id_asc"<c:if test="${map.ps_order == 'id_asc'}"> selected="selected"</c:if>>아이디 순</option>
                <option value="" disabled="disabled">---------------</option>
                <option value="name_desc"<c:if test="${map.ps_order == 'name_desc'}"> selected="selected"</c:if>>작성자이름 역순</option>
                <option value="name_asc"<c:if test="${map.ps_order == 'name_asc'}"> selected="selected"</c:if>>작성자이름 순</option>
                <option value="" disabled="disabled">---------------</option>
                <option value="hit_desc"<c:if test="${map.ps_order == 'hit_desc'}"> selected="selected"</c:if>>조회수 높은</option>
                <option value="hit_asc"<c:if test="${map.ps_order == 'hit_asc'}"> selected="selected"</c:if>>조회수 낮은</option>
            </select>
        </div>
    </div>


    <table class="table-list hover">
        <colgroup>
            <col width="10%">
            <col width="10%">
            <col />
            <col width="10%">
            <col width="10%">
            <col width="10%">
            <col width="10%">
        </colgroup>


        <thead>
            <tr>
                <th>No.</th>
                <th>상태</th>
                <th>제목</th>
                <th>작성자<br>아이디</th>
                <th>조회수</th>
                <th>등록일</th>
                <th>기능</th>
            </tr>
        </thead>

        <tbody>
            <c:choose>
            <c:when test="${!empty list }">
            <c:forEach items="${list}" var="dto">
            <c:set var="showLink" value="onclick=\"popWindow('../admin/qnaView.do?no=${dto.bbs_no}', '800', '900');\"" />
            <tr>
                <td ${showLink}>${dto.bbs_no}</td>
                <td>
                	<c:if test="${dto.bbs_status == 'done'}"><span class="text-danger">완료</span></c:if>
                	<c:if test="${dto.bbs_status == 'ing'}"><span class="text-success">처리중</span></c:if>
                	<c:if test="${dto.bbs_status == 'send'}"><span class="text-primary">대기</span></c:if>
                </td>
                <td ${showLink} class="text-left">
                    ${dto.bbs_title}
                    <c:if test="${!empty dto.bbs_file1}"><i class="fa fa-floppy-o"></i></c:if>
                    <c:if test="${!empty dto.bbs_file2}"><i class="fa fa-floppy-o"></i></c:if>
                    <c:if test="${dto.bbs_comment > 0}"><span class="com">(${dto.bbs_comment})</span></c:if>
                </td>
                <td ${showLink} class="py-3">
                	<p><b>${dto.bbs_writer_name}</b></p>
                	<p class="eng">${dto.bbs_writer_id}</p>
                </td>
                <td ${showLink} class="eng">${dto.bbs_hit}</td>
                <td ${showLink} class="eng">${dto.bbs_date.substring(0, 10)}<br />${dto.bbs_date.substring(11)}</td>
                <td>
                    <a href="<%=request.getContextPath()%>/admin/qnaDeleteOk.do?no=${dto.bbs_no}" class="btn btn-sm btn-outline-danger m-1" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
                </td>
            </tr>
            </c:forEach>
            </c:when>

            <c:otherwise>
            <tr>
                <td colspan="7" class="nodata">등록된 일대일 문의가 없습니다.</td>
            </tr>
            </c:otherwise>
            </c:choose>
        </tbody>


        <tfoot>
            <tr>
                <td colspan="7">
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