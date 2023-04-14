<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../layout/layout_header_popup.jsp" />

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="dto" value="${magazine}" />
<c:set var="stay" value="${stayList}" />

<c:if test="${empty dto}"><script>alert('존재하지 않는 게시물입니다.'); window.close();</script></c:if>
<style type="text/css">body { padding: 0 30px !important; }</style>
<div class="d-flex justify-content flex-wrap flex-md-nowrap align-items-center pt-4 pb-2 mb-4 border-bottom">
	<h2>매거진 상세 정보</h2>
	<small>등록된 매거진의 상세 정보를 확인 할 수 있습니다.</small>
</div>



<div class="view-form">
    <!-- 내용 //START -->
    <div class="row vf-body">
        <div class="col-lg mb-4">
            <div class="card">
                <div class="card-body p-4">
                    <h2>${dto.bbs_title}</h2>

                    <div class="d-flex py-2 border-bottom vfb-info">
                        <div class="col text-left">
                        	<i class="icon-calendar"></i> 등록일 : ${dto.bbs_date}
                        	<i class="icon-magnifier ml-3"></i> 조회 <b><fmt:formatNumber value="${dto.bbs_hit}" /></b>
                        </div>

                        <div class="col text-right">
                        	<i class="fa fa-user"></i> 작성자 : <b>${dto.bbs_writer_name}</b> <span class="eng">(${dto.bbs_writer_id})</span>
                        </div>
                    </div>


                    <div class="magazine-view">
	                    <!-- 상단 이미지 //START -->
	                    <c:if test="${!empty dto.bbs_top_img}">
	                    <div class="row py-3">
	                        <div class="col">
                                <div class="topimg" style="background-image: url('<%=request.getContextPath()%>${dto.bbs_top_img}');"><span>${dto.bbs_title}</span></div>
                            </div>
	                    </div>
	                    </c:if>
	                    <!-- 상단 이미지 //END -->


	                    <div class="mv-cont">
		                    <!-- 유튜브 //START -->
		                    <c:if test="${!empty dto.bbs_youtube}">
		                    <div class="row py-3">
		                    	<div class="col">
									<div class="youtube-show">
										<iframe width="800" height="450" src="https://www.youtube.com/embed/${dto.bbs_youtube}" frameborder="0" allow="accelerometer; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
									</div>
		                    	</div>
		                    </div>
		                	</c:if>
		                    <!-- 유튜브 //END -->


		                    <!-- 상세 이미지 1 //START -->
		                    <c:if test="${!empty dto.bbs_detail_img1}">
		                    <div class="row py-3">
		                        <div class="col"><img src="<%=request.getContextPath()%>${dto.bbs_detail_img1}" alt="" /></div>
		                    </div>
		                    </c:if>
		                    <!-- 상세 이미지 1 //END -->


		                    <!-- 글 내용 1 //START -->
		                    <c:if test="${!empty dto.bbs_content1}">
		                    <div class="row py-3">
		                        <div class="col">${dto.bbs_content1}</div>
		                    </div>
		                    </c:if>
		                    <!-- 글 내용 1 //END -->


		                    <!-- 상세 이미지 2 //START -->
		                    <c:if test="${!empty dto.bbs_detail_img2}">
		                    <div class="row py-3">
		                        <div class="col"><img src="<%=request.getContextPath()%>${dto.bbs_detail_img2}" alt="" /></div>
		                    </div>
		                    </c:if>
		                    <!-- 상세 이미지 2 //END -->


		                    <!-- 글 내용 2 //START -->
		                    <c:if test="${!empty dto.bbs_content2}">
		                    <div class="row py-3">
		                        <div class="col">${dto.bbs_content2}</div>
		                    </div>
		                    </c:if>
		                    <!-- 글 내용 2 //END -->


		                    <!-- 구글 지도 //START -->
		                    <c:if test="${!empty dto.bbs_map}">
		                    <div class="row py-3">
		                        <div class="col gmap">${dto.bbs_map} </div>
		                    </div>
		                    </c:if>
		                    <!-- 구글 지도 //END -->


		                    <!-- 글 내용 3 //START -->
		                    <c:if test="${!empty dto.bbs_content3}">
		                    <div class="row py-3">
		                        <div class="col">${dto.bbs_content3}</div>
		                    </div>
		                    </c:if>
		                    <!-- 글 내용 3 //END -->
		                </div>
	                </div>

                </div>
            </div>
        </div>
    </div>
    <!-- 내용 //END -->



    <!-- 등록된 숙소 //START -->
    <div class="row vf-body">
        <div class="col-lg mb-4">
            <div class="card">
                <div class="card-body p-4">
                	<h4>등록된 숙소 목록</h4>
                	<ul class="stay-bbs-list">
                        <c:choose>
                        <c:when test="${ !empty stay }">
                        <c:forEach items="${ stay }" var="list">
                        <li>
                            <a href="javascript:window.opener.location.href='<%=request.getContextPath()%>/admin/stayView.do?stay_no=${list.stay_no}'; window.close();">
                                <c:choose>
                                <c:when test="${!empty list.stay_file1}"><div class="img"><img src="<%=request.getContextPath()%>${ list.stay_file1 }" alt="" /></div></c:when>
                                <c:otherwise><div class="img none">no img</div></c:otherwise>
                                </c:choose>
                                <div class="name">${list.stay_name}</div>
                                <div class="other">${list.stay_desc}</div>
                                <div class="loc"><i class="icon-location-pin"></i> ${list.stay_location}</div>
                            </a>
                        </li>
                        </c:forEach>
                        </c:when>
                        <c:otherwise>
                        <li class="nodata">이 매거진에 등록된 숙소가 없습니다.</li>
                        </c:otherwise>
                        </c:choose>
                	</ul>
                </div>
            </div>
        </div>
    </div>
    <!-- 등록된 Room //END -->


    <!-- 버튼 //START -->
    <div class="d-flex justify-content-center mb-4">
        <button type="button" class="btn btn-outline-secondary" onclick="window.print();"><i class="fa fa-print"></i> 인쇄하기</button>
        <button type="button" class="btn btn-secondary ml-2" onclick="window.close();"><i class="fa fa-times"></i> 창닫기</button>
    </div>
    <!-- 버튼 //END -->

</div>



<jsp:include page="../layout/layout_footer.jsp" />