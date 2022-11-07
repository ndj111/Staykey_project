
// 마이페이지


// 찜삭제 Ajax
delWish = function(stay_name, stay_no, member_id) {

    if(!confirm(stay_name + "를 관심 스테이에서 삭제하시겠습니까?")){
        return false;
    }


    // 회원 체크
    if(!member_id || member_id == null || member_id == "undefined" || member_id == ""){
        alert("회원 로그인 후 사용 하실 수 있습니다.");
        return false;
    }


    $.ajax({
        contentType : "application/x-www-form-urlencoded;charset=UTF-8",
        type : "post",
        url : "stayWishOk.do",
        data : {
            wish_mode : "del",
            stay_no : stay_no,
            member_id : member_id
        },

        success : function(data) {
            if(data.trim() == "del_ok") {
                location.reload(true);
            }else{
                alert('처리중 오류가 발생하였습니다.');
            }
        },

        error : function(e){
            alert("Error : " + e.status);
        }
    });

}






/////////////////////////////////////////////////////
// 회원 정보 수정
/////////////////////////////////////////////////////
$(function() {

    // 비밀번호 확인
    $("#modify_pw").on("keyup", function() {
        let ModifyPwd = $(this).val().trim();
        let Modify_rePwd = $("input[name='modify_pw_re']").val().trim();

        let pwd_pattern1 = /[a-zA-Z]/;
        let pwd_pattern2 = /[0-9]/;
        let pwd_pattern3 = /[~!@\#$%<>^&*]/;     // 원하는 특수문자 추가 제거
        let pwd_pattern4 = /^(?=.*[a-zA-Z])(?=.*[!@#$%^~*+=-])(?=.*[0-9]).{8,20}$/;

        console.log(ModifyPwd)

        // 비밀번호 조건 안 맞는 경우
        if(pwd_pattern1.test(ModifyPwd)) {
            $(".checked").children('li:eq(0)').addClass("on"); 
        }else {
            $(".checked").children('li:eq(0)').removeClass("on"); 
        }
        if(pwd_pattern2.test(ModifyPwd)) {
            $(".checked").children('li:eq(1)').addClass("on"); 
        }else {
            $(".checked").children('li:eq(1)').removeClass("on"); 
        }
        if(pwd_pattern3.test(ModifyPwd)) {
            $(".checked").children('li:eq(2)').addClass("on"); 
        }else {
            $(".checked").children('li:eq(2)').removeClass("on"); 
        }
        if(ModifyPwd.length >= 8 && ModifyPwd.length <= 20){
            $(".checked").children('li:eq(3)').addClass("on"); 
        }else {
            $(".checked").children('li:eq(3)').removeClass("on"); 
        }
        if(pwd_pattern4.test(ModifyPwd)) {
            $(".checked").children('li').addClass("on"); 
        }

        // 비밀번호 일치 쌍방 체크 필요
        if(ModifyPwd.length > 0 && Modify_rePwd.length > 0) {
            if(ModifyPwd == Modify_rePwd) {
                $("input[name='modify_pw_re']").parent().find("p.error").hide();
            }else if(ModifyPwd != Modify_rePwd) {
                $("input[name='modify_pw_re']").parent().find("p.error").show();
            }
        }
    });

    // 비밀번호 일치 여부 확인
    $("input[name='modify_pw_re']").on("keyup", function() {
        let Modify_rePwd = $(this).val().trim();
        let ModifyPwd = $("#modify_pw").val().trim();
        $(this).parent().find("p.error").hide();

        if(ModifyPwd.length > 0 && Modify_rePwd.length > 0){
            if(ModifyPwd == Modify_rePwd) {
                $("input[name='modify_pw_re']").parent().find("p.error").hide();
            }else if(ModifyPwd != Modify_rePwd) {
                $("input[name='modify_pw_re']").parent().find("p.error").show();
            }
        }
        
    });

    // 이름 확인
    $("#modify_name").on("keyup", function() {
        let modify_name = $(this).val().trim();
        $(this).parent().find("p.error").hide();

        if(modify_name.length < 2 || modify_name.length >= 10) {
            $("#modify_name").parent().find("p.error").show();
        }else {
            $("#modify_name").parent().find("p.error").hide();
        }
    });

    // 이메일 확인
    $("#modify_email").on("keyup", function() {
        let modify_email = $(this).val().trim();
        let email_pattern = /^([\w\.\_\-])*[a-zA-Z0-9]+([\w\.\_\-])*([a-zA-Z0-9])+([\w\.\_\-])+@([a-zA-Z0-9]+\.)+[a-zA-Z0-9]{2,8}$/;
        $(this).parent().find("p.error").hide();

        if(!email_pattern.test(modify_email)) {
            $("#modify_email").parent().find("p.error").show();
        }else {
            $("#modify_email").parent().find("p.error").hide();
        }
    });

    // 전화번호 확인
    $("#modify_phone").on("keyup", function() {
        let modify_phone = $(this).val().trim().replace(/[^0-9]/g, "");
        let phone_number = "";
        $(this).parent().find("p.error").show();
     
        if(modify_phone.length < 4) {
            return modify_phone;
        }else if(modify_phone.length < 7) {
            phone_number += modify_phone.substr(0, 3);
            phone_number += "-";
            phone_number += modify_phone.substr(3);
        }else if(modify_phone.length < 10) {
            phone_number += modify_phone.substr(0, 2);
            phone_number += "-";
            phone_number += modify_phone.substr(2, 3);
            phone_number += "-";
            phone_number += modify_phone.substr(5);
        }else if(modify_phone.length < 11) {
            phone_number += modify_phone.substr(0, 3);
            phone_number += "-";
            phone_number += modify_phone.substr(3, 3);
            phone_number += "-";
            phone_number += modify_phone.substr(6);
        }else if(modify_phone.length < 14) {
            phone_number += modify_phone.substr(0, 3);
            phone_number += "-";
            phone_number += modify_phone.substr(3, 4);
            phone_number += "-";
            phone_number += modify_phone.substr(7, 4);
            $(this).parent().find("p.error").hide();
        }
        
        $(this).val(phone_number);
    });
});



/////////////////////////////////////////////////////
// 회원가입 유효성 검사
/////////////////////////////////////////////////////
function validateForm(form) {

    let error = false;

    if(form.modify_pw.length > 0){
        // ========== 비밀번호 유효성 검사 ===========
        let pwd_pattern = /^(?=.*[a-zA-Z])(?=.*[!@#$%^~*+=-])(?=.*[0-9]).{8,20}$/;
        if(!pwd_pattern.test(form.modify_pw.value)){
            alert("비밀번호 작성 조건에 부합하지 않습니다. 다시 확인해주세요.");
            form.modify_pw.focus();
            return false;
        }

        // ========== 비밀번호 체크 유효성 검사 ===========
        if(form.modify_pw.value.length > 0 && form.modify_pw_re.value.length > 0){
            if(form.modify_pw.value != form.modify_pw_re.value){
                alert("비밀번호가 일치하지 않습니다. 다시 확인해주세요.");
                form.modify_pw.focus();
                return false;
            }
        }
    }

    // ========== 이름 유효성 검사 ===========
    if(form.modify_name.value.length < 2 || form.modify_name.value.length > 10){
        alert("이름은 1자 이상 10자 이하로 입력해주세요.");
        form.modify_name.focus();
        return false;
    }

    // ========== 이메일 유효성 검사 ===========
    let email_pattern = /^([\w\.\_\-])*[a-zA-Z0-9]+([\w\.\_\-])*([a-zA-Z0-9])+([\w\.\_\-])+@([a-zA-Z0-9]+\.)+[a-zA-Z0-9]{2,8}$/;
    if(!email_pattern.test(form.modify_email.value)) { 
        alert("잘못된 이메일 형식입니다. 다시 확인해주세요.");
        form.modify_email.focus();
        return false;
    }

    // ========== 전화번호 유효성 검사 ===========
    let phone_pattern = /^[0-9]{3}-[0-9]{4}-[0-9]{4}$/;
    if(!phone_pattern.test(form.modify_phone.value)) { 
        alert("잘못된 전화번호 형식입니다. 다시 확인해주세요.");
        form.modify_phone.focus();
        return false;
    }

}














