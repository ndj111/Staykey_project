<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../layout/layout_header_popup.jsp" />

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="dto" value="${member}" />

<c:if test="${empty dto}"><script>alert('존재하지 않는 회원입니다.'); window.close();</script></c:if>
<style type="text/css">body { padding: 0 30px !important; }</style>
<div class="d-flex justify-content flex-wrap flex-md-nowrap align-items-center pt-4 pb-2 mb-4 border-bottom">
    <h2>회원 상세 정보</h2>
    <small>등록된 회원/관리자의 정보를 확인 할 수 있습니다.</small>
</div>



<div class="view-form">
    <!-- 내용 //START -->
    <div class="row vf-body">
        <div class="col-lg mb-4">
            <table class="table-form w-100">
                <colgroup>
                    <col width="17%" />
                    <col />
                </colgroup>

                <tbody>
                    <tr>
                        <th>회원 유형</th>
                        <td>
                            <c:choose>
                            <c:when test="${dto.getMember_type() == 'admin'}">관리자</c:when>
                            <c:when test="${dto.getMember_type() == 'exit'}">탈퇴회원</c:when>
                            <c:otherwise>일반회원</c:otherwise>
                            </c:choose>
                        </td>
                    </tr>

                    <tr>
                        <td colspan="4" class="space" nowrap="nowrap"></td>
                    </tr>

                    <tr>
                        <th>아이디</th>
                        <td class="eng">${dto.getMember_id()}</td>
                    </tr>

                    <tr>
                        <td colspan="2" class="space" nowrap="nowrap"></td>
                    </tr>

                    <c:if test="${dto.getMember_type() != 'exit'}">
                    <tr>
                        <th>이름</th>
                        <td>${dto.getMember_name()}</td>
                    </tr>
                    <tr>
                        <th>이메일</th>
                        <td class="eng">${dto.getMember_email()}</td>
                    </tr>
                    <tr>
                        <th>연락처</th>
                        <td class="eng">${dto.getMember_phone()}</td>
                    </tr>

                    <c:if test="${!empty dto.getMember_photo()}">
                    <tr>
                        <td colspan="2" class="space" nowrap="nowrap"></td>
                    </tr>

                    <tr>
                        <th>프로필 사진</th>
                        <td><img src="<%=request.getContextPath()%>${dto.getMember_photo()}" style="max-width: 400px;" alt="" /></td>
                    </tr>
                    </c:if>
                    <tr>
                        <td colspan="2" class="space" nowrap="nowrap"></td>
                    </tr>
                    </c:if>

                    <tr>
                        <th>가입일자</th>
                        <td class="eng">${dto.getMember_joindate()}</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <!-- 내용 //END -->


    <!-- 버튼 //START -->
    <div class="d-flex justify-content-center mb-4">
        <button type="button" class="btn btn-outline-secondary" onclick="window.print();"><i class="fa fa-print"></i> 인쇄하기</button>
        <button type="button" class="btn btn-secondary ml-2" onclick="window.close();"><i class="fa fa-times"></i> 창닫기</button>
    </div>
    <!-- 버튼 //END -->


</div>




<jsp:include page="../layout/layout_footer.jsp" />