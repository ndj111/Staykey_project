<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../layout/layout_header.jsp" />
<c:set var="stayModify" value="${ stayModify }" />
<c:set var="stayType" value="${ stayType }" />


<script type="text/javascript">$("#nav-stay").addClass("now");</script>
<div class="d-flex justify-content flex-wrap flex-md-nowrap align-items-center pt-4 pb-2 mb-4 border-bottom">
    <h2>숙소 수정</h2>
    <small>숙소를 수정 할 수 있습니다.</small>
</div>


<div class="pb100">
    <form name="modify_form" method="post" enctype="multipart/form-data" action="<%=request.getContextPath() %>/admin/stayModifyOk.do">
    <input type="hidden" name="stay_no" value="${ stayModify.stay_no }" />
    <table class="table-form mt-3">
        <colgroup>
            <col width="16%" />
            <col width="34%" />
            <col width="16%" />
            <col />
        </colgroup>
        <tr>
            <th>숙소 유형</th>
            <td colspan="3">
                <c:forEach var="stype" items="${stayType}">
                <div class="form-check form-check-inline">
                    <label class="form-check-label"><input type="radio" name="stay_type" value="${stype}" class="form-check-input" <c:if test="${ stayModify.stay_type.contains(stype) }"> checked="checked"</c:if> /> ${stype}</label>
                </div>
                </c:forEach>
            </td>
        </tr>

        <tr>
            <td colspan="4" class="space" nowrap="nowrap"></td>
        </tr>

        <tr>
            <th>숙소명</th>
            <td colspan="3">
                <input type="text" name="stay_name" value="${ stayModify.stay_name }" maxlength="50" class="form-control w-40" required />
            </td>
        </tr>
        <tr>
            <th>간략설명</th>
            <td colspan="3">
                <input type="text" name="stay_desc" value="${ stayModify.stay_desc }" maxlength="50" class="form-control" />
            </td>
        </tr>

        <tr>
            <td colspan="4" class="space" nowrap="nowrap"></td>
        </tr>

        <tr>
            <th>위치/주소</th>
            <td colspan="3">
                <input type="text" name="stay_location" value="${ stayModify.stay_location }" maxlength="50" class="form-control d-inline w-20" required />
                <input type="text" name="stay_addr" value="${ stayModify.stay_addr }" maxlength="100" class="form-control d-inline w-70 ml-3" required />
            </td>
        </tr>
        <tr>
            <th>연락처</th>
            <td><input type="text" name="stay_phone" value="${ stayModify.stay_phone }" maxlength="15" class="form-control" required /></td>
            <th>이메일</th>
            <td><input type="text" name="stay_email" value="${ stayModify.stay_email }" maxlength="100" class="form-control" required /></td>
        </tr>

        <tr>
            <td colspan="4" class="space" nowrap="nowrap"></td>
        </tr>
        
        <tr>
            <th>숙소 사진 1</th>
            <td colspan="3">
                <input type="file" name="stay_file1" class="form-control w-50" />
                <c:if test="${!empty stayModify.stay_file1}"><p class="mt-2"><img src="<%=request.getContextPath()%>${stayModify.stay_file1}" style="max-height: 200px;" alt="" /></p>
                <div class="form-check form-check-inline">
                	<label class="form-check-label"><input type="checkbox" name="stay_file_delete" value="Y1" /> 등록된 사진 삭제</label>
                </div>
                </c:if>
            </td>
        </tr>
        <tr>
            <th>숙소 사진 2</th>
            <td colspan="3">
                <input type="file" name="stay_file2" class="form-control w-50" />
                <c:if test="${!empty stayModify.stay_file2}"><p class="mt-2"><img src="<%=request.getContextPath()%>${stayModify.stay_file2}" style="max-height: 200px;" alt="" /></p>
                <div class="form-check form-check-inline">
                	<label class="form-check-label"><input type="checkbox" name="stay_file_delete" value="Y2" /> 등록된 사진 삭제</label>
                </div> 
          	    </c:if>
            </td>
        </tr>
        <tr>
            <th>숙소 사진 3</th>
            <td colspan="3">
                <input type="file" name="stay_file3" class="form-control w-50" />
                <c:if test="${!empty stayModify.stay_file3}"><p class="mt-2"><img src="<%=request.getContextPath()%>${stayModify.stay_file3}" style="max-height: 200px;" alt="" /></p>
                <div class="form-check form-check-inline">
                	<label class="form-check-label"><input type="checkbox" name="stay_file_delete" value="Y3" /> 등록된 사진 삭제</label>
                </div> 
                </c:if>                  
           </td>
        </tr>
        <tr>
            <th>숙소 사진 4</th>
            <td colspan="3">
                <input type="file" name="stay_file4" class="form-control w-50" />
                <c:if test="${!empty stayModify.stay_file4}"><p class="mt-2"><img src="<%=request.getContextPath()%>${stayModify.stay_file4}" style="max-height: 200px;" alt="" /></p>
                <div class="form-check form-check-inline">
                	<label class="form-check-label"><input type="checkbox" name="stay_file_delete" value="Y4" /> 등록된 사진 삭제</label>
                </div> 
                </c:if>            
            </td>
        </tr>
        <tr>
            <th>숙소 사진 5</th>
            <td colspan="3">
                <input type="file" name="stay_file5" class="form-control w-50" />
                <c:if test="${!empty stayModify.stay_file5}"><p class="mt-2"><img src="<%=request.getContextPath()%>${stayModify.stay_file5}" style="max-height: 200px;" alt="" /></p>
                <div class="form-check form-check-inline">
                	<label class="form-check-label"><input type="checkbox" name="stay_file_delete" value="Y5" /> 등록된 사진 삭제</label>
                </div> 
                </c:if>
            </td>
        </tr>

        <tr>
            <td colspan="4" class="space" nowrap="nowrap"></td>
        </tr>

        <tr>
            <th>숙박 옵션 1</th>
            <td colspan="3">
                <div class="row d-flex">
                    <div class="col-4">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text rounded-0">옵션이름</span>
                            </div>
                            <input type="text" name="stay_option1_name" value="${ stayModify.stay_option1_name }" maxlength="50" class="form-control" />
                        </div>
                    </div>
                    <div class="col-4">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text rounded-0">옵션가격</span>
                            </div>
                            <input type="text" name="stay_option1_price" value="${ stayModify.stay_option1_price }" maxlength="10" class="form-control" />
                        </div>
                    </div>
                </div>
                <div class="row my-2">
                    <div class="col">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text rounded-0">옵션설명</span>
                            </div>
                            <textarea name="stay_option1_desc" cols="30" rows="3" class="form-control">${ stayModify.stay_option1_desc }</textarea>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text rounded-0">옵션사진</span>
                            </div>                                     
                            <c:if test="${ !empty stayModify.stay_option1_photo }"><p><img src="${ pageContext.request.contextPath }/${ stayModify.stay_option1_photo }" alt="" width="100px" height="100px"/></p></c:if>
							<div class="input-group-prepend w-80 justify-content">
								<div class="form-control w-100">
									<input type="file" name="stay_option1_photo" class="w-100" value="${ stayModify.stay_option3_photo }" />
									<c:if test="${ !empty stayModify.stay_option1_photo }">
									<div class="mt-2">
										<label class="form-check-label"><input type="checkbox" name="stay_file_delete" value="Y6" /> 등록된 사진 삭제</label>
									</div>
									</c:if>
								</div>
							</div>
                        </div>
                    </div>
                </div>
            </td>
        </tr>

        <tr>
            <th>숙박 옵션 2</th>
            <td colspan="3">
                <div class="row d-flex">
                    <div class="col-4">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text rounded-0">옵션이름</span>
                            </div>
                            <input type="text" name="stay_option2_name" value="${ stayModify.stay_option2_name }" maxlength="50" class="form-control" />
                        </div>
                    </div>
                    <div class="col-4">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text rounded-0">옵션가격</span>
                            </div>
                            <input type="text" name="stay_option2_price" value="${ stayModify.stay_option2_price }" maxlength="10" class="form-control" />
                        </div>
                    </div>
                </div>
                <div class="row my-2">
                    <div class="col">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text rounded-0">옵션설명</span>
                            </div>
                            <textarea name="stay_option2_desc" cols="30" rows="3" class="form-control">${ stayModify.stay_option2_desc }</textarea>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text rounded-0">옵션사진</span>
                            </div>
                            <c:if test="${ !empty stayModify.stay_option2_photo }"><p><img src="${ pageContext.request.contextPath }/${ stayModify.stay_option2_photo }" alt="" width="100px" height="100px"/></p></c:if>
							<div class="input-group-prepend w-80 justify-content">
								<div class="form-control w-100">
									<input type="file" name="stay_option2_photo" class="w-100" value="${ stayModify.stay_option2_photo }" />
									<c:if test="${ !empty stayModify.stay_option2_photo }">
									<div class="mt-2">
										<label class="form-check-label"><input type="checkbox" name="stay_file_delete" value="Y7" /> 등록된 사진 삭제</label>
									</div>
									</c:if>
								</div>
							</div>
                        </div>
                    </div>
                 </div>
            </td>
        </tr>

        <tr>
            <th>숙박 옵션 3</th>
            <td colspan="3">
                <div class="row d-flex">
                    <div class="col-4">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text rounded-0">옵션이름</span>
                            </div>
                            <input type="text" name="stay_option3_name" value="${ stayModify.stay_option3_name }" maxlength="50" class="form-control" />
                        </div>
                    </div>
                    <div class="col-4">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text rounded-0">옵션가격</span>
                            </div>
                            <input type="text" name="stay_option3_price" value="${ stayModify.stay_option3_price }" maxlength="10" class="form-control" />
                        </div>
                    </div>
                </div>
                <div class="row my-2">
                    <div class="col">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text rounded-0">옵션설명</span>
                            </div>
                            <textarea name="stay_option3_desc" cols="30" rows="3" class="form-control">${ stayModify.stay_option3_desc }</textarea>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text rounded-0">옵션사진</span>
                            </div>
                            <c:if test="${ !empty stayModify.stay_option3_photo }"><p><img src="${ pageContext.request.contextPath }/${ stayModify.stay_option3_photo }" alt="" width="100px" height="100px"/></p></c:if>
							<div class="input-group-prepend w-80 justify-content">
								<div class="form-control w-100">
									<input type="file" name="stay_option3_photo" class="w-100" value="${ stayModify.stay_option3_photo }" />
									<c:if test="${ !empty stayModify.stay_option3_photo }">
									<div class="mt-2">
										<label class="form-check-label"><input type="checkbox" name="stay_file_delete" value="Y8" /> 등록된 사진 삭제</label>
									</div>
									</c:if>
								</div>
							</div>
                        </div>
                    </div>
                </div>
            </td>
        </tr>

        <tr>
            <td colspan="4" class="space" nowrap="nowrap"></td>
        </tr>

        <tr>
            <th>내용 컨텐츠 1<br />(소개)</th>
            <td colspan="3"><textarea name="stay_content1" class="form-control" cols="80" rows="10">${ stayModify.stay_content1 }</textarea></td>
        </tr>

        <tr>
            <th>내용 컨텐츠 2<br />(스페셜)</th>
            <td colspan="3"><textarea name="stay_content2" class="form-control" cols="80" rows="10">${ stayModify.stay_content2 }</textarea></td>
        </tr>

        <tr>
            <th>내용 컨텐츠 3<br /><a href="https://www.google.com/maps" target="_blank">(구글 맵)</a></th>
            <td colspan="3"><textarea name="stay_content3" class="form-control" cols="80" rows="6">${ stayModify.stay_content3 }</textarea></td>
        </tr>

        <tr>
            <td colspan="4" class="space" nowrap="nowrap"></td>
        </tr>

        <tr>
            <th>안내사항 1<br />(예약안내)</th>
            <td colspan="3"><textarea name="stay_info1" class="form-control" cols="80" rows="10">${ stayModify.stay_info1 }</textarea></td>
        </tr>

        <tr>
            <th>안내사항 2<br />(이용안내)</th>
            <td colspan="3"><textarea name="stay_info2" class="form-control" cols="80" rows="10">${ stayModify.stay_info2 }</textarea></td>
        </tr>

        <tr>
            <th>안내사항 3<br />(환불규정)</th>
            <td colspan="3"><textarea name="stay_info3" class="form-control" cols="80" rows="10">${ stayModify.stay_info3 }</textarea></td>
        </tr>

    </table>



    <div class="gw-button">
        <div class="gwb-wrap">
            <div class="gwb-left"></div>

            <div class="gwb-center">
                <button type="button" class="btn btn-lg btn-outline-secondary mx-1" onclick="history.back();"><i class="fa fa-bars"></i> 목록보기</button>
                <button type="submit" class="btn btn-lg btn-success mx-1"><i class="fa fa-save"></i> 수정하기</button>
            </div>

            <div class="gwb-right"></div>
        </div>
    </div>
    </form>
</div>




<jsp:include page="../layout/layout_footer.jsp" />