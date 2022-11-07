<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../layout/layout_header_popup.jsp" />

<% pageContext.setAttribute("newLine", "\n"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="dto" value="${qna}" />
<c:set var="qList" value="${List}" />

<!-- <script type="text/javascript">opener.parent.location.reload();</script> -->
	
<style type="text/css">body { padding: 0 30px !important; }</style>
<div class="d-flex justify-content flex-wrap flex-md-nowrap align-items-center pt-4 pb-2 mb-4 border-bottom">
    <h2>문의글 상세 정보</h2>
    <small>일대일 문의글의 정보를 확인 할 수 있습니다.</small>
</div>



<div class="view-form">
    <!-- 내용 //START -->
    <div class="row vf-body">
        <div class="col-lg mb-4">
            <table class="table-form w-100">
                <colgroup>
                    <col width="17%" />
                    <col width="32%" />
                    <col width="17%" />
                    <col />
                </colgroup>

                <tbody>
                    <tr>
                        <th>상태</th>
                        <td> 
                            <c:if test="${dto.bbs_status == 'send'}"><span class="text-primary">대기</span></c:if>
		                	<c:if test="${dto.bbs_status == 'ing'}"><span class="text-success">처리중</span></c:if>
                            <c:if test="${dto.bbs_status == 'done'}"><span class="text-danger">완료</span></c:if>
                        </td>
                        <td colspan="2">
                            <form action="<%=request.getContextPath()%>/admin/qnaModifyOk.do?no=${dto.bbs_no}" method="post">
                        	<select name="bbs_status" class="form-select">
                                <option value="send"<c:if test="${dto.bbs_status == 'send'}"> selected="selected"</c:if>>대기</option>
                        		<option value="ing"<c:if test="${dto.bbs_status == 'ing'}"> selected="selected"</c:if>>처리중</option>
                        		<option value="done"<c:if test="${dto.bbs_status == 'done'}"> selected="selected"</c:if>>완료</option>
                        	</select>
                    		<button type="submit" class="btn btn-sm btn-outline-success m-1">수정</button>
                            </form>
                    	</td>
                    </tr>
                    <tr>
                        <th>댓글갯수</th>
                        <td class="eng">${dto.bbs_comment}</td>
                        <th>조회수</th>
                        <td class="eng">${dto.bbs_hit}</td>
                    </tr>
                    <tr>
                        <th>작성일자</th>
                        <td colspan="3">${dto.bbs_date}</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <!-- 내용 //END -->
    
    
    
    

    <!-- 문의자 정보 //START -->
    <div class="row vf-body">
        <div class="col-lg mb-4">
            <h4>문의자 정보</h4>

            <table class="table-form w-100">
                <colgroup>
                    <col width="17%" />
                    <col width="32%" />
                    <col width="17%" />
                    <col />
                </colgroup>

                <tbody>
                    <tr>
                        <th>이름</th>
                        <td class="eng">${dto.bbs_writer_name}</td>
                        <th>아이디</th>
                        <td class="eng">${dto.bbs_writer_id}</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <!-- 문의자 정보 //END -->


    <!-- 문의글 정보 //START -->
    <div class="row vf-body">
        <div class="col-lg mb-4">
            <h4>문의 정보</h4>

            <table class="table-form w-100">
                <colgroup>
                    <col width="17%" />
                    <col />
                </colgroup>

                <tbody>
                    <tr>
                        <th>문의제목</th>
                        <td>${dto.bbs_title}</td>
                    </tr>
                    <tr> 
                        <th>문의내용</th>
                        <td >${dto.bbs_content.replace(newLine, "<br />")}</td>
                    </tr>

                    <c:if test="${!empty dto.bbs_file1 || !empty dto.bbs_file2}">
                    <tr>
                        <th>첨부파일</th>
                        <td class="file">
                            <ul>
                                <c:if test="${!empty dto.bbs_file1}">
                                <li class="my-3">
                                    <c:choose>
                                    <c:when test="${ext1 == 'jpg' || ext1 == 'jpeg' || ext1 == 'gif' || ext1 == 'png'}"><img src="<%=request.getContextPath()%>${dto.bbs_file1}" style="width: 100%; max-width: 100%;" alt="" /></c:when>
                                    <c:otherwise><a href="<%=request.getContextPath()%>${dto.bbs_file1}" target="_blank"><i class="fa fa-floppy-o"></i> 다운로드 : ${dto.bbs_file1.replace("/data/qna/", "")}</a></c:otherwise>
                                    </c:choose>
                                </li>
                                </c:if>

                                <c:if test="${!empty dto.bbs_file2}">
                                <li class="my-3">
                                    <c:choose>
                                    <c:when test="${ext2 == 'jpg' || ext2 == 'jpeg' || ext2 == 'gif' || ext2 == 'png'}"><img src="<%=request.getContextPath()%>${dto.bbs_file2}" style="width: 100%; max-width: 100%;" alt="" /></c:when>
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
    <!-- 문의글 정보 //END -->
	
	
	
	
	
	
	
	
    <!-- 답글 내역 //START -->
    <div class="row vf-article">
        <div class="col-lg mb-4">
            <div class="card input-form">
                <div class="card-body p-4">
                    <h4>댓글 목록</h4>
                    <table class="table-form mt-2">
                        <colgroup>
                            <col width="18%" />
                            <col />
                            <col width="15%" />
                            <col width="30%" />
                        </colgroup>	

                        <thead>
                            <tr>
                                <th>작성자</th>
                                <th>내용</th>
                                <th>작성일</th>
                                <th>기능</th>
                            </tr>
                        </thead>

                        <tbody>
                            <c:choose>
                            <c:when test="${!empty qList }">
                            <c:forEach items="${qList}" var="qdto">
                            <c:set var="comment_qnano" value="${qdto.comment_qnano}"/>
                            <tr>
                                <td class="text-center"><b>${qdto.comment_writer_name}</b></td>
                                <td class="text-left">${qdto.comment_content}</td>
                                <td class="text-center">${qdto.comment_date}</td>
	                           	<td class="text-center">
	                    			<a href="<%=request.getContextPath()%>/admin/qnaCommendDeleteOk.do?no=${qdto.comment_no}&qna_no=${dto.bbs_no}" class="btn btn-sm btn-outline-danger m-1" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
	                			</td>
                            </tr>
                            </c:forEach>
                            </c:when>
                
                            <c:otherwise>
                            <tr>
                                <td colspan="4" class="nodata border-bottom-0">댓글이 없습니다.</td>
                            </tr>
                            </c:otherwise>
                            </c:choose>
        					
                         </tbody>
                    </table>
                     <c:if test="${dto.bbs_status == 'send'}">
                     <form name="write_form" method="post" action="<%=request.getContextPath() %>/admin/qnaCommentOk.do?no=${dto.bbs_no}">
                   		<%-- 이름, 아이디, 비밀번호 임시로 받음. --%>
                   		<input type="hidden" name="comment_writer_name" value="${login_name}" />
						<input type="hidden" name="comment_writer_id" value="${login_id}" />
						<input type="hidden" name="comment_writer_pw" value="${login_pw}" />
                     <table class="table-form mt-2">
                     	<colgroup>
                            <col width="18%" />
                            <col />
                            <col width="25%" />
                     	</colgroup>
					    <tr> 
					        <th>댓글 내용</th>										
							<td> 
								<textarea name="comment_content" cols="20" rows="3" class="form-control" required></textarea></td>
                            <td class="text-center">
                                <button type="submit" class="btn btn-lg btn-primary w-100 h-100"><i class="fa fa-pencil"></i> 쓰기</button>
                            </td>
					    </tr> 
			   		</table>
			   		</form>	
			   		</c:if>
			   		
                </div>
            </div>
        </div>
    </div>

  
	



    <!-- 버튼 //START -->
    <div class="d-flex justify-content-center mb-3">
        <button type="button" class="btn btn-outline-secondary" onclick="window.print();"><i class="fa fa-print"></i> 인쇄하기</button>
        <button type="button" class="btn btn-secondary ml-2" onclick="window.close();"><i class="fa fa-times"></i> 창닫기</button>
    </div>
    <!-- 버튼 //END -->

</div>



<jsp:include page="../layout/layout_footer.jsp" />