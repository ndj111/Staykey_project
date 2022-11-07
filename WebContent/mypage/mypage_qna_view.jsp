<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../layout/layout_header.jsp" />
<jsp:include page="../mypage/mypage_header.jsp" />

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="dto" value="${qna}" />
<c:set var="qList" value="${List}" />
<% pageContext.setAttribute("newLine", "\n"); %>

<script type="text/javascript">$("#mymenu-qna").addClass("now");</script>



<div class="qna-view">


    <!-- 기본 정보 //START -->
    <div class="row rv-body">
        <div class="col-lg mb-5">
            <table class="table-form">
                <colgroup>
                    <col width="17%" />
                    <col width="32%" />
                    <col width="17%" />
                    <col />
                </colgroup>

                <tbody>
                    <tr>
                        <th>상태</th>
                        <td colspan="3"> 
                            <c:if test="${dto.bbs_status == 'done'}"><span class="text-danger">답변 완료</span></c:if>
                        	<c:if test="${dto.bbs_status == 'ing'}"><span class="text-success">답변 처리중</span></c:if>
                        	<c:if test="${dto.bbs_status == 'send'}"><span class="text-primary">답변 대기중</span></c:if>
                        </td>
                        
                    </tr>
                    <tr>
                        <th>작성일자</th>
                        <td class="eng">${dto.bbs_date}</td>
                        <th>조회수</th>
                        <td class="eng">${dto.bbs_hit}</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <!-- 기본 정보 //END -->



    <!-- 내용 //START -->
    <div class="row rv-body">
        <div class="col-lg mb-5">
            <table class="table-form">
                <colgroup>
                    <col width="17%" />
                    <col />
                </colgroup>

                <tbody>
                    <tr>
                        <th>제목</th>
                        <td>${dto.bbs_title}</td>
                    </tr>
                    <tr> 
                        <th>내용</th>
                        <td>${dto.bbs_content.replace(newLine, "<br />")}</td>
                    </tr>
                    <c:if test="${!empty dto.bbs_file1 || !empty dto.bbs_file2}">
                    <tr>
                        <th>첨부파일</th>
                        <td class="file">
                            <ul>
                                <c:if test="${!empty dto.bbs_file1}">
                                <li>
                                    <c:choose>
                                    <c:when test="${ext1 == 'jpg' || ext1 == 'jpeg' || ext1 == 'gif' || ext1 == 'png'}"><img src="<%=request.getContextPath()%>${dto.bbs_file1}" alt="" /></c:when>
                                    <c:otherwise><a href="<%=request.getContextPath()%>${dto.bbs_file1}" target="_blank"><i class="fa fa-floppy-o"></i> 다운로드 : ${dto.bbs_file1.replace("/data/qna/", "")}</a></c:otherwise>
                                    </c:choose>
                                </li>
                                </c:if>

                                <c:if test="${!empty dto.bbs_file2}">
                                <li>
                                    <c:choose>
                                    <c:when test="${ext2 == 'jpg' || ext2 == 'jpeg' || ext2 == 'gif' || ext2 == 'png'}"><img src="<%=request.getContextPath()%>${dto.bbs_file2}" alt="" /></c:when>
                                    <c:otherwise><a href="<%=request.getContextPath()%>${dto.bbs_file2}" target="_blank"><i class="fa fa-floppy-o"></i> ${dto.bbs_file2.replace("/data/qna/", "")}</a></c:otherwise>
                                    </c:choose>
                                </li>
                                </c:if>
                            </ul>
                        </td>
                    </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
    <!-- 내용 //END -->



    <!-- 답변 목록 //START -->
    <div class="row rv-body">
        <div class="col-lg mb-5">
            <h4>답변 목록</h4>

            <table class="table-form">
                <colgroup>
                    <col width="18%" />
                    <col />
                    <col width="15%" />
                    <c:if test="${dto.bbs_status == 'send'}"><col width="30%" /></c:if>
                </colgroup>	

                <c:choose>
                <c:when test="${!empty qList }">
                <thead>
                    <tr>
                        <th>작성자</th>
                        <th>내용</th>
                        <th>작성일</th>
                        <c:if test="${dto.bbs_status == 'send'}"><th>기능</th></c:if>
                    </tr>
                </thead>

                <tbody>
                    <c:forEach items="${qList}" var="qdto">
                    <tr>
                        <td class="text-center"><b>${qdto.comment_writer_name}</b></td>
                        <td class="text-left">${qdto.comment_content}</td>
                        <td class="text-center">${qdto.comment_date}</td>
                        <c:if test="${dto.bbs_status == 'send'}">
                       	<td class="text-center">
                			<a href="<%=request.getContextPath()%>/mypageQnaDeleteOk.do?comment_no=${qdto.comment_no}&qna_no=${dto.bbs_no}" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
                			<a href="<%=request.getContextPath()%>/mypageQnaModify.do?comment_no=${qdto.comment_no}&qna_no=${dto.bbs_no}">수정</a>
            			</td>
                        </c:if>
                    </tr>
                    </c:forEach>
                </tbody>
                </c:when>

                <c:otherwise>
                <tbody>
                    <tr>
                        <td colspan="<c:choose><c:when test="${dto.bbs_status == 'send'}">4</c:when><c:otherwise>3</c:otherwise></c:choose>" class="nodata">답변 내역이 없습니다.</td>
                    </tr>
                </tbody>
                </c:otherwise>
                </c:choose>
            </table>


            <c:if test="${dto.bbs_status == 'send'}">
            <form name="write_form" method="post" action="<%=request.getContextPath() %>/mypageQnaCommentOk.do?no=${comment_qnano}">
            <input type="hidden" name="qna_no" value="${dto.bbs_no}" />
            <input type="hidden" name="comment_writer_id" value="${login_id}" />
            <input type="hidden" name="comment_writer_name" value="${login_name}" />
            <input type="hidden" name="comment_writer_pw" value="${login_pw}" />
            <table class="table-form write-comment">
             	<colgroup>
                    <col width="120" />
                    <col />
                    <col width="120" />
             	</colgroup>
			    <tr> 
			        <th>댓글 쓰기</th>										
					<td><textarea name="comment_content" cols="20" rows="3" required></textarea></td>
                    <td><button type="submit"><i class="fa fa-pencil"></i> 쓰기</button></td>
			    </tr> 
	   		</table>
	   		</form>	
	   		</c:if>
        </div>
    </div>
    <!-- 내용 //END -->
</div>



<jsp:include page="../mypage/mypage_footer.jsp" />
<jsp:include page="../layout/layout_footer.jsp" />