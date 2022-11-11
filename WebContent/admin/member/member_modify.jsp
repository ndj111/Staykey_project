<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../layout/layout_header.jsp" />

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="dto" value="${member}" />


<script type="text/javascript">
$("#nav-member").addClass("now");

join_check = function(){
    var form = document.write_form;

    // 비밀번호 체크
    if(form.member_pw_chg.value.length > 0 && form.member_pw_chg_re.value.length > 0){
   	 	let pwd_pattern = /^(?=.*[a-zA-Z])(?=.*[!@#$%^~*+=-])(?=.*[0-9]).{8,20}$/;
        if(form.member_pw_chg.value != form.member_pw_chg_re.value){
            alert("[비밀번호]가 일치하지 않습니다.");
            form.member_pw_chg.focus();
            return false;
        }
        if(pwd_pattern.test(form.member_pw_chg.value)) {
            if(pwd_pattern.test(form.member_pw_chg_re.value)) {
            	return true;
            }else{
            	alert("[비밀번호 확인]이 조건에 맞지 않습니다.");
            	return false;
            }
        }else {
        	alert("[비밀번호]가 조건에 맞지 않습니다.");
        	return false;
        }        
    } 

    if(form.member_email.value == ""){
        alert("[이메일]을 입력해 주세요.");
        form.member_email.focus();
        return false;
    }

    // 이메일 형식 체크
    var TEmailChk = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
    if(form.member_email.value.match(TEmailChk) != null){
    }else{
        alert("잘못된 이메일 형식입니다.\n[이메일]을 다시 입력해 주세요.");
        form.member_email.focus();
        return false;
    }
    form.submit();
};

</script>



<div class="d-flex justify-content flex-wrap flex-md-nowrap align-items-center pt-4 pb-2 mb-4 border-bottom">
    <h2>회원 수정</h2>
    <small>회원/관리자의 정보를 수정 할 수 있습니다.</small>
</div>




<div class="pb100">
    <form name="write_form" method="post" enctype="multipart/form-data" action="<%=request.getContextPath() %>/admin/memberModifyOk.do" onsubmit="return join_check();">
    <input type="hidden" name="member_pw" value="${dto.getMember_pw()}" />
    <table class="table-form mt-3">
        <colgroup>
            <col width="16%" />
            <col width="34%" />
            <col width="16%" />
            <col />
        </colgroup>
        <tr>
            <th>회원 유형</th>
            <td colspan="3">
                <div class="form-check form-check-inline">
                    <label class="form-check-label"><input type="radio" name="member_type" value="user" class="form-check-input"<c:if test="${dto.getMember_type() == 'user'}"> checked="checked"</c:if> /> 일반회원</label>
                </div>
                <div class="form-check form-check-inline">
                    <label class="form-check-label"><input type="radio" name="member_type" value="admin" class="form-check-input"<c:if test="${dto.getMember_type() == 'admin'}"> checked="checked"</c:if> /> 관리자</label>
                </div>
            </td>
        </tr>

        <tr>
            <td colspan="4" class="space" nowrap="nowrap"></td>
        </tr>

        <tr>
            <th>아이디</th>
            <td colspan="3">
                <input type="text" name="member_id" value="${dto.getMember_id()}" maxlength="30" class="form-control-plaintext d-inline w-30" readonly required />
            </td>
        </tr>
        <tr>
            <th>비밀번호 변경</th>
            <td><input type="password" name="member_pw_chg" maxlength="50" class="form-control w-80" /></td>
            <th>비밀번호 변경 확인</th>
            <td><input type="password" name="member_pw_chg_re" maxlength="50" class="form-control w-80" /></td>
        </tr>

        <tr>
            <td colspan="4" class="space" nowrap="nowrap"></td>
        </tr>

        <tr>
            <th>이름</th>
            <td colspan="3"><input type="text" name="member_name" value="${dto.getMember_name()}" maxlength="50" class="form-control w-30" required /></td>
        </tr>
        <tr>
            <th>이메일</th>
            <td><input type="text" name="member_email" value="${dto.getMember_email()}" maxlength="100" class="form-control" required /></td>
            <th>연락처</th>
            <td><input type="text" name="member_phone" value="${dto.getMember_phone()}" maxlength="15" class="form-control" required /></td>
        </tr>

        <tr>
            <td colspan="4" class="space" nowrap="nowrap"></td>
        </tr>

        <tr>
            <th>프로필 사진</th>
            <td colspan="3">
                <input type="file" name="member_photo" class="form-control w-50" />
                <c:if test="${!empty dto.getMember_photo()}"><p class="mt-2"><img src="<%=request.getContextPath()%>${dto.getMember_photo()}" style="max-width: 400px;" alt="" /></p></c:if>
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