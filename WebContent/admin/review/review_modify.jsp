<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../layout/layout_header.jsp" />

<% pageContext.setAttribute("newLine", "\n"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<c:set var="dto" value="${member}" />

<script type="text/javascript">$("#nav-review").addClass("now");</script>
<div class="d-flex justify-content flex-wrap flex-md-nowrap align-items-center pt-4 pb-2 mb-4 border-bottom">
    <h2>후기 수정</h2>
    <small>후기의 정보를 수정 할 수 있습니다.</small>
</div>




<div class="pb100">
    <form name="write_form" method="post" enctype="multipart/form-data" action="<%=request.getContextPath() %>/admin/reviewModifyOk.do" onsubmit="return join_check();">
    <input type="hidden" name="review_no" value="${dto.review_no}" />
    <table class="table-form mt-3">
        <colgroup>
            <col width="16%" />
            <col width="34%" />
            <col width="16%" />
            <col />
        </colgroup>

        <tr>
           <th>숙소 이름</th>
           <td>
             	<input type="text" name="review_stayname" value="${dto.review_stayname}" maxlength="30" class="form-control-plaintext d-inline w-30" readonly required />
           </td>
           <th>사용 객실</th>            
           <td>
            	<input type="text" name="review_roomname" value="${dto.review_roomname}" maxlength="30" class="form-control-plaintext d-inline w-30" readonly required />
           </td>                  
        </tr>
        
        <tr>
            <td colspan="4" class="space" nowrap="nowrap"></td>
        </tr>
        
        <tr>
            <th>작성자 아이디</th>
            <td>
                <input type="text" name="review_id" value="${dto.review_id}" maxlength="30" class="form-control-plaintext d-inline w-30" readonly required />
            </td>
            <th>작성자 이름</th>
            <td>
            	<input type="text" name="review_name" value="${dto.review_name}" maxlength="30" class="form-control-plaintext d-inline w-30" readonly required />
            </td>
        </tr>
        
        <tr>
            <td colspan="4" class="space" nowrap="nowrap"></td>
        </tr>
        
        <tr> 
        	<th>리뷰 평점</th>
        	<td colspan="3"><b>${dto.review_point_total}점</b></td>
        </tr>
        
        <tr> 
        	<th>세부 평점</th>
        	
        	<td colspan="3">
	        	<b>접근성:</b>
		        	<select name="review_point1" class="form-select mr-4">
	                	<c:forEach begin="1" end="10" var="i">
	                    	<option value="${i}"<c:if test="${dto.review_point1 == i}"> selected="selected"</c:if>>${i}</option>
	                	</c:forEach>
	                </select>
					
				<b>서비스:</b>
					<select name="review_point2" class="form-select mr-4">
	                     <c:forEach begin="1" end="10" var="i">
	                     	<option value="${i}"<c:if test="${dto.review_point2 == i}"> selected="selected"</c:if>>${i}</option>
	                     </c:forEach>
	                </select>
	
		        <b>객실시설:</b>
					<select name="review_point3" class="form-select mr-4">
                    	<c:forEach begin="1" end="10" var="i">
                        	<option value="${i}"<c:if test="${dto.review_point3 == i}"> selected="selected"</c:if>>${i}</option>
                        </c:forEach>
                	</select>
						
				<b>부대시설:</b>
					<select name="review_point4" class="form-select mr-4">
                    	<c:forEach begin="1" end="10" var="i">
                        	<option value="${i}"<c:if test="${dto.review_point4 == i}"> selected="selected"</c:if>>${i}</option>
                        </c:forEach>
                	</select>	
                	
	        	<b>식음료:</b>
					<select name="review_point5" class="form-select mr-4">
                    	<c:forEach begin="1" end="10" var="i">
                        	<option value="${i}"<c:if test="${dto.review_point5 == i}"> selected="selected"</c:if>>${i}</option>
                        </c:forEach>
                	</select>	
                	
				<b>만족도:</b>
					<select name="review_point6" class="form-select">
                    	<c:forEach begin="1" end="10" var="i">
                        	<option value="${i}"<c:if test="${dto.review_point6 == i}"> selected="selected"</c:if>>${i}</option>
                        </c:forEach>
                	</select>
       		</td>
        </tr>
        
        <tr> 
        	<th>리뷰 내용</th>										
			<td colspan="3"><textarea name="review_content" cols="20" rows="4" class="form-control" >${dto.review_content.replace("<br />", newLine)}</textarea></td>
        </tr>
        
        <tr>
            <th>후기 사진</th>
            <td colspan="3">
                <input type="file" name="review_file" class="form-control w-50" />
                <c:if test="${!empty dto.review_file}"><p class="mt-2"><img src="<%=request.getContextPath()%>${dto.review_file}" style="max-width: 400px;" alt="" /></p></c:if>
            </td>
        </tr>
    </table>



    <div class="gw-button">
        <div class="gwb-wrap">
            <div class="gwb-left"></div>

            <div class="gwb-center">
                <button type="button" class="btn btn-lg btn-outline-secondary mx-1" onclick="history.back();"><i class="fa fa-bars"></i> 취소하기</button>
                <button type="submit" class="btn btn-lg btn-success mx-1"><i class="fa fa-save"></i> 수정하기</button>
            </div>

            <div class="gwb-right"></div>
        </div>
    </div>
    </form>
</div>





<jsp:include page="../layout/layout_footer.jsp" />