<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../layout/layout_header.jsp" />

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="list" value="${List}" />


<script type="text/javascript">$("#nav-event").addClass("now");</script>
<div class="d-flex justify-content flex-wrap flex-md-nowrap align-items-center pt-4 pb-2 mb-4 border-bottom">
    <h2>이벤트 목록</h2>
    <small>등록된 이벤트 게시물들을 확인하고 관리 할 수 있습니다.</small>
</div>


<div>
    <form name="search_form" method="post" action="eventList.do">
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

            <th>이벤트 일자</th>
            <td colspan="5">
                <div class="row">
                    <div class="col-3">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                            </div>
                            <input type="text" name="ps_start" value="${map.ps_start}" id="startDt" class="form-control text-center eng" />
                        </div>
                    </div>

                    <div class="pt-2">~</div>

                    <div class="col-3">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                            </div>
                            <input type="text" name="ps_end" value="${map.ps_end}" id="endDt" class="form-control text-center eng" />
                        </div>
                    </div>

                    <div class="col-5 pt-2">
                        <label><input type="checkbox" name="ps_duse" value="1"<c:if test="${map.ps_duse == '1'}"> checked="checked"</c:if> /> 모든 기간 검색</label>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <th>이벤트 제목</th>
            <td><input type="text" name="ps_title" value="${map.ps_title}" maxlength="50" class="form-control w-90" /></td>
            <th>작성자 이름</th>
            <td><input type="text" name="ps_name" value="${map.ps_name}" maxlength="30" class="form-control w-90" /></td>
            <th>작성자 아이디</th>
            <td><input type="text" name="ps_id" value="${map.ps_id}" maxlength="50" class="form-control w-90" /></td>
        </tr>
    </table>

    <div class="text-center mb-5">
        <a href="<%=request.getContextPath()%>/admin/eventList.do" class="btn btn-outline-secondary"><i class="fa fa-power-off"></i> 검색 초기화</a>
        <button type="submit" class="btn btn-secondary mx-2"><i class="fa fa-search"></i> 이벤트 검색</button>
    </div>
    </form>





    <div class="table-top clear">
        <div class="tt-left">총 <b><fmt:formatNumber value="${listCount}" /></b> 개의 이벤트</div>
        <div class="tt-right">
            <select name="ps_order" class="form-select" onChange="location.href='<%=request.getContextPath()%>/admin/eventList.do?ps_name=${map.ps_name}&ps_id=${map.ps_id}&ps_title=${map.ps_title}&ps_order='+this.value;">
                <option value="register_desc"<c:if test="${map.ps_order == 'register_desc'}"> selected="selected"</c:if>>등록일 최신</option>
                <option value="register_asc"<c:if test="${map.ps_order == 'register_asc'}"> selected="selected"</c:if>>등록일 예전</option>
                <option value="" disabled="disabled">---------------</option>
                <option value="title_desc"<c:if test="${map.ps_order == 'title_desc'}"> selected="selected"</c:if>>글제목 역순</option>
                <option value="title_asc"<c:if test="${map.ps_order == 'title_asc'}"> selected="selected"</c:if>>글제목 순</option>
                <option value="" disabled="disabled">---------------</option>
                <option value="hit_desc"<c:if test="${map.ps_order == 'hit_desc'}"> selected="selected"</c:if>>조회수 역순</option>
                <option value="hit_asc"<c:if test="${map.ps_order == 'hit_asc'}"> selected="selected"</c:if>>조회수 순</option>
                <option value="" disabled="disabled">---------------</option>
                <option value="show_desc"<c:if test="${map.ps_order == 'show_desc'}"> selected="selected"</c:if>>이벤트일자 최신</option>
                <option value="show_asc"<c:if test="${map.ps_order == 'show_asc'}"> selected="selected"</c:if>>이벤트일자 예전</option>
            </select>
        </div>
    </div>



    <table class="table-list hover">
        <colgroup>
            <col width="7%">
            <col width="7%">
            <col width="12%">
            <col />
            <col width="10%">
            <col width="10%">
            <col width="8%">
            <col width="10%">
        </colgroup>

        <thead>
            <tr>
                <th>No.</th>
                <th>이미지</th>
                <th>이벤트기간</th>
                <th>제목</th>
                <th>작성자<br>아이디</th>
                <th>작성일자</th>
                <th>조회수</th>
                <th>기능</th>
            </tr>
        </thead>

        <tbody>
            <c:choose>
            <c:when test="${!empty list }">
            <c:forEach items="${list}" var="dto">
            <c:set var="showLink" value="onclick=\"popWindow('../admin/eventView.do?no=${dto.bbs_no}', '1400', '900');\"" />
            <tr>
                <td ${showLink} class="eng">${dto.bbs_no}</td>
 				<td ${showLink} class="photo">
                    <c:choose>
                    <c:when test="${!empty dto.bbs_file1 }"><img src="<%=request.getContextPath()%>${dto.bbs_file1}" alt=""k
                     /></c:when>
                    <c:otherwise>
                    <svg class="bd-placeholder-img" width="70" height="60" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false" role="img">
                        <title>${dto.bbs_writer_name}</title>
                        <rect width="100%" height="100%" fill="#eee"></rect>
                        <text x="48%" y="54%" fill="#888" dy=".1em">no img</text>
                    </svg>
                    </c:otherwise>
                    </c:choose>
                </td>
                <td ${showLink} class="eng"> 
                    <c:choose>
                    <c:when test="${!empty dto.bbs_showstart || !empty dto.bbs_showend }">${dto.bbs_showstart.substring(0, 10)} ~ ${dto.bbs_showend.substring(0, 10)}</c:when>
                    <c:otherwise>
    					<b class="text-danger">제한없음</b>
               		</c:otherwise>
                    </c:choose>
                </td>
                <td ${showLink} class="eng">${dto.bbs_title.replace("<br />", "").replace("<br>", "")}</td>
                <td ${showLink} class="py-4">
                    <p><b>${dto.bbs_writer_name}</b></p>
                    <p class="eng">${dto.bbs_writer_id}</p>
                </td>
                <td ${showLink} class="eng">${dto.bbs_date.substring(0, 10)}<br />${dto.bbs_date.substring(11)}</td>
                <td ${showLink} class="eng">${dto.bbs_hit}</td>
                <td>
                    <a href="<%=request.getContextPath()%>/admin/eventModify.do?bbs_no=${dto.bbs_no}" 
                    class="btn btn-sm btn-outline-primary m-1">수정</a>
                    <a href="<%=request.getContextPath()%>/admin/eventDeleteOk.do?bbs_no=${dto.bbs_no}" 
                    class="btn btn-sm btn-outline-danger m-1" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
                </td>
            </tr>
            </c:forEach>
            </c:when>

            <c:otherwise>
            <tr>
                <td colspan="10" class="nodata">등록된 이벤트가 없습니다.</td>
            </tr>
            </c:otherwise>
            </c:choose>
        </tbody>


        <tfoot>
            <tr>
                <td colspan="10">
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

                                <td class="text-right"><a href="<%=request.getContextPath()%>/admin/eventWrite.do" class="btn btn-primary"><i class="fa fa-pencil"></i>이벤트 등록</a></td>
                            </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
        </tfoot>
    </table>
</div>




<jsp:include page="../layout/layout_footer.jsp" />