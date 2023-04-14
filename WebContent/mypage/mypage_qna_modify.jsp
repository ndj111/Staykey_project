<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="dto" value="${qna}" />
<c:if test="${empty dto}"><script type="text/javascript">alert('잘못된 접근입니다.'); history.back();</script></c:if>
<c:if test="${qna.bbs_status != 'send'}"><script type="text/javascript">alert('현재 상태에서는 수정 할 수 없습니다.'); history.back();</script></c:if>


<jsp:include page="../layout/layout_header.jsp" />
<jsp:include page="../mypage/mypage_header.jsp" />

<script type="text/javascript">$("#mymenu-qna").addClass("now");</script>



<div class="qna-write">
    <form name="write_form" method="post" enctype="multipart/form-data" action="<%=request.getContextPath()%>/mypageQnaModifyOk.do">
    <input type="hidden" name="bbs_no" value="${dto.bbs_no}" />
    <input type="hidden" name="ori_file1" value="${dto.bbs_file1}" />
    <input type="hidden" name="ori_file2" value="${dto.bbs_file2}" />
    <table class="table-form">
        <colgroup>
            <col width="16%" />
            <col />
        </colgroup>

        <tr>
            <th>제목</th>
            <td>
                <input type="text" name="bbs_title" value="${dto.bbs_title}" maxlength="200" class="w-100" required />
            </td>
        </tr>
        <tr>
            <th>내용</th>
            <td>
                <textarea name="bbs_content" cols="80" rows="10" required>${dto.bbs_content}</textarea>
            </td>
        </tr>

        <tr>
            <td colspan="2" class="space" nowrap="nowrap"></td>
        </tr>

        <tr>
            <th>첨부 파일 #1</th>
            <td class="file">
                <p><input type="file" name="bbs_file1" /></p>
                <c:if test="${!empty dto.bbs_file1}"><p class="mt-3">
                <c:choose>
                <c:when test="${ext1 == 'jpg' || ext1 == 'jpeg' || ext1 == 'gif' || ext1 == 'png'}"><img src="<%=request.getContextPath()%>${dto.bbs_file1}" alt="" /></c:when>
                <c:otherwise><a href="<%=request.getContextPath()%>${dto.bbs_file1}" target="_blank"><i class="fa fa-floppy-o"></i> 다운로드 : ${dto.bbs_file1.replace("/data/qna/", "")}</a></c:otherwise>
                </c:choose>
                </p></c:if>
            </td>
        </tr>
        <tr>
            <th>첨부 파일 #2</th>
            <td class="file">
                <p><input type="file" name="bbs_file2" /></p>
                <c:if test="${!empty dto.bbs_file2}"><p class="mt-3">
                <c:choose>
                <c:when test="${ext2 == 'jpg' || ext2 == 'jpeg' || ext2 == 'gif' || ext2 == 'png'}"><img src="<%=request.getContextPath()%>${dto.bbs_file2}" alt="" /></c:when>
                <c:otherwise><a href="<%=request.getContextPath()%>${dto.bbs_file2}" target="_blank"><i class="fa fa-floppy-o"></i> 다운로드 : ${dto.bbs_file2.replace("/data/qna/", "")}</a></c:otherwise>
                </c:choose>
                </p></c:if>
            </td>
        </tr>
    </table>


    <div class="table-btn">
        <button type="button" class="exit" onclick="history.back();">목록보기</button>
        <button type="submit">수정하기</button>
    </div>
    </form>

</div>



<jsp:include page="../mypage/mypage_footer.jsp" />
<jsp:include page="../layout/layout_footer.jsp" />