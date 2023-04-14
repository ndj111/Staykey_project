<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../layout/layout_header.jsp" />



<script type="text/javascript">
$("#nav-member").addClass("now");


$(function(){
	$("input[name='member_id']").keyup(function(){
        let userId = $(this).val();

        if($.trim(userId).length < 4){
            $("#idchk-txt").html("<span class=\"text-danger\">* 아이디는 4글자 이상이어야 합니다.</span>");
            return false;
        }

        // 아이디 중복여부 확인
        $.ajax({
            type : "post",
            url : "<%=request.getContextPath()%>/memberIdCheck.do",
            data : { paramId : userId },
            datatype : "html",

            success : function(data){
            	console.log(data);
                let ajaxTxt = "";
                if(data.trim() > 0){
                    ajaxTxt = "<span class=\"text-danger\">* 이미 사용중인 아이디입니다.</span>";
                    $("input[name='idchk']").val("N");
                }else{
                    ajaxTxt = "<span class=\"text-primary\">* 사용 할 수 있는 아이디입니다.</span>";
                    $("input[name='idchk']").val("Y");
                }
                $("#idchk-txt").html(ajaxTxt);
            },

            error : function(e){
                alert("Error : " + e.status);
                $("input[name='idchk']").val("N");
            }
        });
	});
});


join_check = function(){
    var form = document.write_form;

    if(form.idchk.value == "N"){
        alert("이미 사용중인 [아이디]입니다.\n다른 아이디를 입력해주세요.");
        form.member_id.focus();
        return false;
    }

    if(form.member_pw.value.length > 0 && form.member_pw_re.value.length > 0){
        if(form.member_pw.value != form.member_pw_re.value){
            alert("[비밀번호]가 일치하지 않습니다.");
            form.member_pw.focus();
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
    <h2>회원 등록</h2>
    <small>회원/관리자를 추가 할 수 있습니다.</small>
</div>




<div class="pb100">
    <form name="write_form" method="post" enctype="multipart/form-data" action="<%=request.getContextPath() %>/admin/memberWriteOk.do" onsubmit="return join_check();">
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
                    <label class="form-check-label"><input type="radio" name="member_type" value="user" class="form-check-input" checked="checked" /> 일반회원</label>
                </div>
                <div class="form-check form-check-inline">
                    <label class="form-check-label"><input type="radio" name="member_type" value="admin" class="form-check-input" /> 관리자</label>
                </div>
            </td>
        </tr>

        <tr>
            <td colspan="4" class="space" nowrap="nowrap"></td>
        </tr>

        <tr>
            <th>아이디</th>
            <td colspan="3">
                <input type="text" name="member_id" value="" maxlength="30" class="form-control d-inline w-30" required />
                <div id="idchk-txt" class="d-inline ml-2"></div>
                <input type="hidden" name="idchk" value="N" />
            </td>
        </tr>
        <tr>
            <th>비밀번호</th>
            <td><input type="password" name="member_pw" value="" maxlength="50" class="form-control w-80" required /></td>
            <th>비밀번호 확인</th>
            <td><input type="password" name="member_pw_re" value="" maxlength="50" class="form-control w-80" required /></td>
        </tr>

        <tr>
            <td colspan="4" class="space" nowrap="nowrap"></td>
        </tr>

        <tr>
            <th>이름</th>
            <td colspan="3"><input type="text" name="member_name" value="" maxlength="50" class="form-control w-30" required /></td>
        </tr>
        <tr>
            <th>이메일</th>
            <td><input type="text" name="member_email" value="" maxlength="100" class="form-control" required /></td>
            <th>연락처</th>
            <td><input type="text" name="member_phone" value="" maxlength="15" class="form-control" required /></td>
        </tr>

        <tr>
            <td colspan="4" class="space" nowrap="nowrap"></td>
        </tr>

        <tr>
            <th>프로필 사진</th>
            <td colspan="3"><input type="file" name="member_photo" class="form-control w-50" /></td>
        </tr>
    </table>



    <div class="gw-button">
        <div class="gwb-wrap">
            <div class="gwb-left"></div>

            <div class="gwb-center">
                <button type="button" class="btn btn-lg btn-outline-secondary mx-1" onclick="history.back();"><i class="fa fa-bars"></i> 목록보기</button>
                <button type="submit" class="btn btn-lg btn-primary mx-1"><i class="fa fa-pencil"></i> 등록하기</button>
            </div>

            <div class="gwb-right"></div>
        </div>
    </div>
    </form>
</div>





<jsp:include page="../layout/layout_footer.jsp" />