<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../layout/layout_header.jsp" />
<jsp:include page="../mypage/mypage_header.jsp" />

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="list" value="${list}" />

<script type="text/javascript">$("#mymenu-qna").addClass("now");</script>




<div class="qna-list">
    <table class="table-list">
        <colgroup>
            <col width="10%">
            <col />
            <col width="10%">
            <col width="22%">
        </colgroup>


        <thead>
            <tr>
                <th>상태</th>
                <th>제목</th>
                <th>조회수</th>
                <th>등록일</th>
            </tr>
        </thead>

        <tbody>
            <c:choose>
            <c:when test="${!empty list }">
            <c:forEach items="${list}" var="dto">
            <tr onclick="location.href='<%=request.getContextPath()%>/mypageQnaView.do?no=${dto.bbs_no }';">
                <td>
                	<c:if test="${dto.bbs_status == 'done'}"><span class="text-danger">완료</span></c:if>
                	<c:if test="${dto.bbs_status == 'ing'}"><span class="text-success">처리중</span></c:if>
                	<c:if test="${dto.bbs_status == 'send'}"><span class="text-primary">대기</span></c:if>
                </td>
                <td class="text-center">
                    ${dto.bbs_title}
                    <c:if test="${!empty dto.bbs_file1}"><i class="fa fa-floppy-o"></i></c:if>
                    <c:if test="${!empty dto.bbs_file2}"><i class="fa fa-floppy-o"></i></c:if>
                </td>
                <td class="eng">${dto.bbs_hit}</td>
                <td class="eng">${dto.bbs_date}</td>
            </tr>
            </c:forEach>
            </c:when>

            <c:otherwise>
            <tr>
                <td colspan="5" class="nodata">등록된 일대일 문의가 없습니다.</td>
            </tr>
            </c:otherwise>
            </c:choose>
        </tbody>


        <tfoot>
            <tr>
                <td colspan="5">
                    <table class="paging-table">
                        <colgroup>
                            <col width="100" />
                            <col />
                            <col width="100" />
                        </colgroup>
                        <tbody>
                            <tr>
                                <td></td>
                                <td class="text-center">
                                    ${map.pagingWrite}
                                </td>
                                <td class="text-right"><a href="<%=request.getContextPath()%>/mypageQnaWrite.do" class="write-btn">문의하기</a></td>
                            </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
        </tfoot>
    </table>
</div>



<jsp:include page="../mypage/mypage_footer.jsp" />
<jsp:include page="../layout/layout_footer.jsp" />