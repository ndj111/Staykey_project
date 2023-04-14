<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../layout/layout_header_popup.jsp" />

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="dto" value="${member}" />


<c:if test="${empty dto}"><script>alert('존재하지 리뷰입니다.'); window.close();</script></c:if>
<style type="text/css">body { padding: 0 30px !important; }</style>
<div class="d-flex justify-content flex-wrap flex-md-nowrap align-items-center pt-4 pb-2 mb-4 border-bottom">
    <h2>후기 상세 정보</h2>
    <small>등록된 후기의 정보를 확인 할 수 있습니다.</small>
</div>




<div class="view-form">
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
                        <th>작성자</th>
                        <td>${dto.review_name} <span class="eng">(${dto.review_id})</span></td>
                        <th>작성일</th>
                        <td class="eng">${dto.review_date}</td>
                    </tr>

                    <tr>
                        <td colspan="4" class="space" nowrap="nowrap"></td>
                    </tr>

                    <tr>
                        <th colspan="4">
                            <h5 class="d-inline align-middle"><i class="fa fa-home"></i> ${dto.review_stayname}</h5>
                            <span class="align-middle">(${dto.review_roomname})</span>
                        </th>
                    </tr>
                    <tr>
                        <td colspan="2" class="text-center text-primary">총 평점 <h5 class="d-inline">${dto.review_point_total}</h5>점</td>
                        <td colspan="2">
                            <ul>
                                <li class="d-inline-block my-1 mr-3"><b>접근성</b> : ${dto.review_point1}점</li>
                                <li class="d-inline-block my-1 mr-3"><b>서비스</b> : ${dto.review_point2}점</li>
                                <li class="d-inline-block my-1 mr-3"><b>객실시설</b> : ${dto.review_point3}점</li><br />
                                <li class="d-inline-block my-1 mr-3"><b>부대시설</b> : ${dto.review_point4}점</li>
                                <li class="d-inline-block my-1 mr-3"><b>식음료</b> : ${dto.review_point5}점</li>
                                <li class="d-inline-block my-1 mr-3"><b>만족도</b> : ${dto.review_point6}점</li>
                            </ul>
                        </td>
                    </tr>

                    <tr>
                        <td colspan="4" class="text-center">
                            <c:if test="${!empty dto.review_file}">
                            <div class="py-3"><img src="<%=request.getContextPath()%>${dto.review_file}" style="max-width: 500px;" alt="" /></div>
                            </c:if>
                            <div class="pt-2 pb-3 px-4">${dto.review_content}</div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>



    <!-- 버튼 //START -->
    <div class="d-flex justify-content-center mb-4">
        <button type="button" class="btn btn-outline-secondary" onclick="window.print();"><i class="fa fa-print"></i> 인쇄하기</button>
        <button type="button" class="btn btn-secondary ml-2" onclick="window.close();"><i class="fa fa-times"></i> 창닫기</button>
    </div>
    <!-- 버튼 //END -->

</div>




<jsp:include page="../layout/layout_footer.jsp" />