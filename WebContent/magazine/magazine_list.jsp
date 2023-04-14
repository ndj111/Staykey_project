<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<% long time = System.currentTimeMillis(); %>
<jsp:include page="../layout/layout_header.jsp" />

<script type="text/javascript">$("#nav-magazine").addClass("now");</script>
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/asset/css/magazine.css?<%=time%>" />
<script language="javascript" src="<%=request.getContextPath()%>/asset/js/magazine.js?<%=time%>"></script>

<c:set var="magazine" value="${ magazineList }"/>



<div class="container page-title">
    <h2>JOURNAL</h2>
    <h4>스테이:키의 관점으로 스테이를 조명합니다.</h4>
</div>




<div class="container magazine-list">
    <ul class="ml-list">
        <c:choose>
        <c:when test="${ !empty magazine }">
        <c:forEach var="mgz" items="${ magazine }">
        <li>
            <a href="<%=request.getContextPath()%>/magazineView.do?bbs_no=${mgz.bbs_no }">
                <div class="mll-info">
                    <p class="name"><c:forTokens items="${ mgz.bbs_title }" delims="<" var="desc" begin="0" end="0">${ desc }</c:forTokens></p>
                    <p class="stay"><c:forTokens items="${ mgz.bbs_title }" delims="<" var="stay" begin="1" end="1">${ stay.replace(">", "") }</c:forTokens></p>
                    <p class="more">Read more</p>
                </div>
                <div class="mll-photo" style="background-image: url('<%=request.getContextPath()%>${mgz.bbs_list_img}');"></div>
            </a>
        </li>
        </c:forEach>
        </c:when>

        <c:otherwise><li class="nodata">등록된 매거진이 없습니다.</li></c:otherwise>
        </c:choose>
    </ul>


    <div class="ml-paging">
        ${map.pagingWrite}
    </div>
</div>



<jsp:include page="../layout/layout_footer.jsp" />