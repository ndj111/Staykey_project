<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="../layout/layout_header.jsp" />

<c:set var="dto" value="${magazineModify}" />
<c:set var="stay" value="${stayList}" />

<!-- 숙소 지정 검색 부분 -->
<style type="text/css">.stayhover:hover { background: #f3f3f3; cursor: pointer; }</style>
<script type="text/javascript">$("#nav-magazine").addClass("now");</script>
<script type="text/javascript">
	function addStayNo(stayno) {
		let this_val = $("#mag_stayno").val();
		let add_val = this_val;

		if (this_val.length > 0) {
			if (this_val.indexOf("/" + stayno + "/") == -1) {
				add_val = this_val + stayno + "/";
			}
		} else {
			add_val = this_val + "/" + stayno + "/";
		}

		$("#mag_stayno").val(add_val);
	}	
	

	function searchStay(el) {
        $.ajax({
            type : "post",
            url : "staySearchOk.do",
			data: {
				type : $(el).find("select[name='search_field']").val(),
				search  : $(el).find("input[name='search_keyword']").val()
			},
            dataType : "html",

            success : function(data) {
            	let get_data = data.split("◇");

            	if(get_data[0] > 0){
	        		$("#search-result").html("");

	        		let epd_data = get_data[1].split("♠");
	            	for(var i=1; i<epd_data.length; i++) {
	            		let sub_data = epd_data[i].split("♣");

	            		let setList = "<li class=\"d-flex my-2 align-items-center stayhover\" onclick=\"addStayNo('"+sub_data[0]+"'); close();\" data-dismiss=\"modal\">";
	            			setList += "<img src=\"<%=request.getContextPath()%>"+sub_data[4]+"\" alt=\"\" width=\"60\" height=\"60\" />";
							setList += "<div class=\"ml-2\">";
							setList += "<p><strong>["+sub_data[0]+"]</strong> "+sub_data[2]+"</p>";
							setList += "<p>"+sub_data[3]+"</p>";
							setList += "</div>";
	            			setList += "</li>";
	        			$("#search-result").append(setList);
	            	}
	            }else{
	            	$("#search-result").html("<li class=\"py-3 text-center\">검색된 숙소가 없습니다.</li>");
	            }
            },

            error : function(e){
                alert("Error : " + e.status);
            }
        });

        return false;
	}
</script>




<div
	class="d-flex justify-content flex-wrap flex-md-nowrap align-items-center pt-4 pb-2 mb-4 border-bottom">
	<h2>매거진 수정</h2>
	<small>매거진을 수정 할 수 있습니다.</small>
</div>


<div class="pb100">
	<form name="write_form" method="post" enctype="multipart/form-data"
		action="<%=request.getContextPath()%>/admin/magazineModifyOk.do">
		<input type="hidden" name="mag_no" value="${dto.bbs_no}" /> <input
			type="hidden" name="mag_writer_name" value="${dto.bbs_writer_name}" />
		<input type="hidden" name="mag_writer_id" value="${dto.bbs_writer_id}" />
		<input type="hidden" name="mag_writer_pw" value="${dto.bbs_writer_pw}" />

		<table class="table-form mt-3">
			<colgroup>
				<col width="16%" />
				<col width="34%" />
				<col width="16%" />
				<col />
			</colgroup>

			<tr>
				<th>제목</th>
				<td colspan="3"><input type="text" name="mag_title"
					value="${dto.bbs_title}" maxlength="255" class="form-control"
					required /></td>
			</tr>

			<tr>
				<td colspan="4" class="space" nowrap="nowrap"></td>
			</tr>

			<tr>
				<th>목록 이미지</th>
				<td colspan="3"><input type="file" name="mag_list_img"
					class="form-control w-50" /> <c:if
						test="${!empty dto.bbs_list_img}">
						<p class="mt-2">
							<img src="<%=request.getContextPath()%>${dto.bbs_list_img}"
								style="max-height: 250px;" alt="" />
						</p>
					</c:if></td>
			</tr>

			<tr>
				<td colspan="4" class="space" nowrap="nowrap"></td>
			</tr>

			<tr>
				<th>상단 이미지</th>
				<td colspan="3"><input type="file" name="mag_top_img"
					class="form-control w-50" /> 
					<c:if test="${!empty dto.bbs_top_img}">
						<p class="mt-2">
							<img src="<%=request.getContextPath()%>${dto.bbs_top_img}"
								style="max-height: 250px;" alt="" />
						</p>
					</c:if></td>
			</tr>

			<tr>
				<td colspan="4" class="space" nowrap="nowrap"></td>
			</tr>

			<tr>
				<th>유튜브</th>
				<td colspan="3">
					<div class="row m-0">
						<input type="text" name="mag_youtube" value="${dto.bbs_youtube}"
							class="form-control w-20" />
						<div class="ml-3">
							<p class="text-primary">* 유튜브 동영상 주소의 뒷부분을 적어주세요.</p>
							<p class="text-primary">
								&nbsp; 예) https://www.youtube.com/watch?v=<b class="text-danger">dLGVvC0MMDw</b>
							</p>
						</div>
					</div>
				</td>
			</tr>

			<tr>
				<td colspan="4" class="space" nowrap="nowrap"></td>
			</tr>

			<tr>
				<th>상세 이미지1</th>
				<td colspan="3"><input type="file" name="mag_detail_img1"
					class="form-control w-50" /> <c:if
						test="${!empty dto.bbs_detail_img1}">
						<p class="mt-2">
							<img src="<%=request.getContextPath()%>${dto.bbs_detail_img1}"
								style="max-height: 250px;" alt="" />
						</p>
					</c:if></td>
			</tr>

			<tr>
				<th>글 내용1</th>
				<td colspan="3"><textarea name="mag_content1"
						class="form-control" cols="80" rows="10" required>${dto.bbs_content1}</textarea></td>
			</tr>

			<tr>
				<td colspan="4" class="space" nowrap="nowrap"></td>
			</tr>

			<tr>
				<th>상세 이미지2</th>
				<td colspan="3"><input type="file" name="mag_detail_img2"
					class="form-control w-50" /> 
					<c:if test="${!empty dto.bbs_detail_img2}">
						<p class="mt-2">
							<img src="<%=request.getContextPath()%>${dto.bbs_detail_img2}"
								style="max-height: 250px;" alt="" />
						</p>
					</c:if></td>
			</tr>

			<tr>
				<th>글 내용2</th>
				<td colspan="3"><textarea name="mag_content2"
						class="form-control" cols="80" rows="10" required>${dto.bbs_content2}</textarea></td>
			</tr>

			<tr>
				<td colspan="4" class="space" nowrap="nowrap"></td>
			</tr>

			<tr>
				<th>지도<br />
				<a href="https://www.google.com/maps" target="_blank">(구글 맵)</a></th>
				<td colspan="3"><textarea name="mag_map" class="form-control"
						cols="80" rows="6">${dto.bbs_map}</textarea></td>
			</tr>

			<tr>
				<th>글 내용3</th>
				<td colspan="3"><textarea name="mag_content3"
						class="form-control" cols="80" rows="10" required>${dto.bbs_content3}</textarea></td>
			</tr>

			<tr>
				<td colspan="4" class="space" nowrap="nowrap"></td>
			</tr>

				<tr>
				<th>숙소 번호</th>
				<td colspan="3">
					<div class="row m-0">
						<input type="text" name="mag_stayno" value="${dto.bbs_stayno}" id="mag_stayno" class="form-control w-30" maxlength="255" />
						<button type="button" class="btn btn-sm btn-warning ml-2" data-toggle="modal" data-target="#modalCategory"><i class="fa fa-exclamation"></i> 숙소 지정하기</button>
					</div>
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


<div class="modal fade" id="modalCategory" tabindex="-1" type="default"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-scrollable">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title"><i class="fa fa-exclamation"></i> 숙소 지정하기</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
			</div>

			<div class="modal-body">
				<form  method="post" onsubmit="return searchStay(this);" class="form-inline">
				<select name="search_field" class="form-select">
					<option value="no" selected="selected">숙소 번호</option>
					<option value="name">숙소 이름</option>
				</select>
				<input type="text" name="search_keyword" value="" class="form-control mx-2" />
				<button type="submit" class="btn btn-sm btn-primary">검색</button>
				</form>

				<c:choose>
					<c:when test="${!empty stay }">
					<ul class="my-3" id="search-result">
						<c:forEach items="${stay}" var="list">
						<li class="d-flex my-2 align-items-center stayhover" onclick="addStayNo('${list.stay_no}'); close();" data-dismiss="modal">
							<c:choose>
								<c:when test="${!empty list.stay_file1}">
									<img src="<%=request.getContextPath()%>${list.stay_file1}"
										alt="" width="60" height="60" />
								</c:when>
								<c:otherwise>
									<!-- 이미지가 없는 경우 기본 이미지 -->
									<svg class="bd-placeholder-img" width="60" height="60"
										xmlns="http://www.w3.org/2000/svg"
										preserveAspectRatio="xMidYMid slice" focusable="false"
										role="img">
										<title>${dto.bbs_no}</title>
										<rect width="100%" height="100%" fill="#eee"></rect>
										<text x="48%" y="54%" fill="#888"dy=".1em">no img</text>
									</svg>
								</c:otherwise>
							</c:choose>
							<div class="ml-2">
								<p><strong>[${list.stay_no}]</strong> ${list.stay_name}</p>
								<p>${list.stay_desc}</p>
							</div>
						</li>
						</c:forEach>
					</ul>
					</c:when>
				</c:choose>
			</div>


            <div class="gwb-center">
                <button type="button" class="btn btn-lg btn-outline-secondary mx-1" onclick="history.back();"><i class="fa fa-bars"></i> 취소하기</button>
                <button type="submit" class="btn btn-lg btn-success mx-1"><i class="fa fa-save"></i> 수정하기</button>
            </div>

    
		</div>
	</div>
</div>



<jsp:include page="../layout/layout_footer.jsp" />