<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="../layout/layout_header.jsp" />

<c:set var="dto" value="${eventModify}" />
<c:set var="stay" value="${stayList}" />


<style type="text/css">.stayhover:hover { background: #f3f3f3; cursor: pointer; }</style>
<script type="text/javascript">$("#nav-event").addClass("now");</script>
<script type="text/javascript">
	function addStayNo(stayno) {
		let this_val = $("#ev_stayno").val();
		let add_val = this_val;

		if (this_val.length > 0) {
			if (this_val.indexOf("/" + stayno + "/") == -1) {
				add_val = this_val + stayno + "/";
			}
		} else {
			add_val = this_val + "/" + stayno + "/";
		}

		$("#ev_stayno").val(add_val);
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
	<h2>이벤트 수정</h2>
	<small>이벤트를 수정할 수 있습니다.</small>
</div>


<div class="pb100">
	<form name="write_form" method="post" enctype="multipart/form-data"
		action="<%=request.getContextPath()%>/admin/eventModifyOk.do">
		<input type="hidden" name="ev_no" value="${dto.bbs_no}" />
		<input type="hidden" name="ev_writer_name" value="${dto.bbs_writer_name}" />
		<input type="hidden" name="ev_writer_id" value="${dto.bbs_writer_id}" />
		<input type="hidden" name="ev_writer_pw" value="${dto.bbs_writer_pw}" />

		<table class="table-form mt-3">
			<colgroup>
				<col width="16%" />
				<col width="34%" />
				<col width="16%" />
				<col />
			</colgroup>

			<tr>
		        <th>이벤트 기간</th>
		        <td colspan="3">
		            <div class="row">
		                <div class="col-3">
		                    <div class="input-group">
		                        <div class="input-group-prepend">
		                            <span class="input-group-text"><i class="fa fa-calendar"></i></span>
		                        </div>
		                        <input type="text" name="ev_start" value="${dto.bbs_showstart.substring(0,10)}" id="startDt" class="form-control text-center eng" />
		                    </div>
		                </div>

		                <div class="pt-2">~</div>

		                <div class="col-3">
		                    <div class="input-group">
		                        <div class="input-group-prepend">
		                            <span class="input-group-text"><i class="fa fa-calendar"></i></span>
		                        </div>
		                        <input type="text" name="ev_end" value="${dto.bbs_showend.substring(0,10)}" id="endDt" class="form-control text-center eng" />
		                    </div>
		                </div>
		            </div>
		        </td>
		    </tr>

			<tr>
				<td colspan="4" class="space" nowrap="nowrap"></td>
			</tr>

			<tr>
				<th>제목</th>
				<td colspan="3"><input type="text" name="ev_title"
					value="${dto.bbs_title}" maxlength="255" class="form-control"
					required /></td>
			</tr>

			<tr>
				<th>글 내용</th>
				<td colspan="3"><textarea name="ev_content"
						class="form-control" cols="80" rows="10" required>${dto.bbs_content} </textarea></td>
			</tr>

			<tr>
				<td colspan="4" class="space" nowrap="nowrap"></td>
			</tr>

			<tr>
				<th>숙소 번호</th>
				<td colspan="3">
					<div class="row m-0">
						<input type="text" name="ev_stayno" value="${dto.bbs_stayno}" id="ev_stayno" class="form-control w-30" maxlength="255" />
						<button type="button" class="btn btn-sm btn-warning ml-2" data-toggle="modal" data-target="#modalCategory"><i class="fa fa-exclamation"></i> 숙소 지정하기</button>
					</div>
				</td>
			</tr>


			<tr>
				<td colspan="4" class="space" nowrap="nowrap"></td>
			</tr>


			<tr>
				<th>이미지 파일 1<br />(목록 이미지)</th>
				<td colspan="3"><input type="file" name="ev_file1"
					class="form-control w-50" /> <c:if test="${!empty dto.bbs_file1}">
						<p class="mt-2">
							<img src="<%=request.getContextPath()%>${dto.bbs_file1}"
								style="max-height: 250px;" alt="" />
						</p>
					</c:if></td>
			</tr>

			<tr>
				<th>이미지 파일 2<br />(내용 이미지)</th>
				<td colspan="3"><input type="file" name="ev_file2"
					class="form-control w-50" /> <c:if test="${!empty dto.bbs_file2}">
						<p class="mt-2">
							<img src="<%=request.getContextPath()%>${dto.bbs_file2}"
								style="max-height: 250px;" alt="" />
						</p>
					</c:if></td>
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

			<div class="modal-footer text-center">
				<button type="button" id="btn btn-secondary btn-close" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>




<jsp:include page="../layout/layout_footer.jsp" />