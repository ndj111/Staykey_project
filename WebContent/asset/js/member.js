/////////////////////////////////////////////////////
// 아이디/비번 찾기 선택
/////////////////////////////////////////////////////
$(function(){
    $(".member-form.find .mf-select input[type='radio']").on("click", function(){
        $(".member-form.find #fid, .member-form.find #fpw").hide();
        $(".member-form.find #f"+$(this).val()).show();
        $(".member-form.find #fid > input, .member-form.find #fpw > input").removeAttr("required");
        $(".member-form.find #f"+$(this).val()).find("input").attr("required", "required");
        $(".member-form.find .mf-form input[name='find_email']").focus();
        $(".member-form.find .mf-btn button span").text($(this).val());
    });

});


/////////////////////////////////////////////////////
// 회원가입
/////////////////////////////////////////////////////
$(function() {

    $.ajaxSetup({
		contentType : "application/x-www-form-urlencoded;charset=UTF-8",
		type : "post"
	});

    // 아이디 확인
    $("#join_id").on("keyup", function(){
        // $(this).parent() => div
        let joinId = $(this).val().trim();
        let id_pattern = /^[a-zA-Z0-9]{6,}$/g;
        $("#join_id").parent().find("p.error").show();

        // 아이디 중복여부 확인
        $.ajax({
            type : "post",
            url : "memberIdCheck.do",
            data : { paramId : joinId },
            dataType : "text",

            success : function(data) {
                console.log(data);
                if(data > 0){
                    $("#join_id").parent().find("p.error").show().html("중복된 아이디입니다.");
                }else{
                    $("#join_id").parent().find("p.error").show().html("6자 이상, 영문 또는 숫자를 입력해주세요.");
                    if(!id_pattern.test(joinId)) {
                        $("#join_id").parent().find("p.error").show();
                    }else {
                        $("#join_id").parent().find("p.error").hide();
                    }
                }
            },

            error : function(e){
                alert("Error : " + e.status);
            }
        });
    });

    // 비밀번호 확인
    $("#join_pw").on("keyup", function() {
        let joinPwd = $(this).val().trim();
        let join_rePwd = $("input[name='join_pw_re']").val().trim();

        let pwd_pattern1 = /[a-zA-Z]/;
        let pwd_pattern2 = /[0-9]/;
        let pwd_pattern3 = /[~!@\#$%<>^&*]/;     // 원하는 특수문자 추가 제거
        let pwd_pattern4 = /^(?=.*[a-zA-Z])(?=.*[!@#$%^~*+=-])(?=.*[0-9]).{8,20}$/;

        console.log(joinPwd)

        // 비밀번호 조건 안 맞는 경우
        if(pwd_pattern1.test(joinPwd)) {
            $(".checked").children('li:eq(0)').addClass("on"); 
        }else {
            $(".checked").children('li:eq(0)').removeClass("on"); 
        }
        if(pwd_pattern2.test(joinPwd)) {
            $(".checked").children('li:eq(1)').addClass("on"); 
        }else {
            $(".checked").children('li:eq(1)').removeClass("on"); 
        }
        if(pwd_pattern3.test(joinPwd)) {
            $(".checked").children('li:eq(2)').addClass("on"); 
        }else {
            $(".checked").children('li:eq(2)').removeClass("on"); 
        }
        if(joinPwd.length >= 8 && joinPwd.length <= 20){
            $(".checked").children('li:eq(3)').addClass("on"); 
        }else {
            $(".checked").children('li:eq(3)').removeClass("on"); 
        }
        if(pwd_pattern4.test(joinPwd)) {
            $(".checked").children('li').addClass("on"); 
        }

        // 비밀번호 일치 쌍방 체크 필요
        if(joinPwd.length > 0 && join_rePwd.length > 0) {
            if(joinPwd == join_rePwd) {
                $("input[name='join_pw_re']").parent().find("p.error").hide();
            }else if(joinPwd != join_rePwd) {
                $("input[name='join_pw_re']").parent().find("p.error").show();
            }
        }
    });

    // 비밀번호 일치 여부 확인
    $("input[name='join_pw_re']").on("keyup", function() {
        let join_rePwd = $(this).val().trim();
        let joinPwd = $("#join_pw").val().trim();
        $(this).parent().find("p.error").hide();

        if(joinPwd.length > 0 && join_rePwd.length > 0){
            if(joinPwd == join_rePwd) {
                $("input[name='join_pw_re']").parent().find("p.error").hide();
            }else if(joinPwd != join_rePwd) {
                $("input[name='join_pw_re']").parent().find("p.error").show();
            }
        }
        
    });

    // 이름 확인
    $("#join_name").on("keyup", function() {
        let join_name = $(this).val().trim();
        $(this).parent().find("p.error").hide();

        if(join_name.length < 2 || join_name.length >= 10) {
            $("#join_name").parent().find("p.error").show();
        }else {
            $("#join_name").parent().find("p.error").hide();
        }
    });

    // 이메일 확인
    $("#join_email").on("keyup", function() {
        let join_email = $(this).val().trim();
        let email_pattern = /^([\w\.\_\-])*[a-zA-Z0-9]+([\w\.\_\-])*([a-zA-Z0-9])+([\w\.\_\-])+@([a-zA-Z0-9]+\.)+[a-zA-Z0-9]{2,8}$/;
        $(this).parent().find("p.error").hide();

        if(!email_pattern.test(join_email)) {
            $("#join_email").parent().find("p.error").show();
        }else {
            $("#join_email").parent().find("p.error").hide();
        }
    });

    // 전화번호 확인
    $("#join_phone").on("keyup", function() {
        let join_phone = $(this).val().trim().replace(/[^0-9]/g, "");
        let phone_number = "";
        $(this).parent().find("p.error").show();
     
        if(join_phone.length < 4) {
            return join_phone;
        }else if(join_phone.length < 7) {
            phone_number += join_phone.substr(0, 3);
            phone_number += "-";
            phone_number += join_phone.substr(3);
        }else if(join_phone.length < 10) {
            phone_number += join_phone.substr(0, 2);
            phone_number += "-";
            phone_number += join_phone.substr(2, 3);
            phone_number += "-";
            phone_number += join_phone.substr(5);
        }else if(join_phone.length < 11) {
            phone_number += join_phone.substr(0, 3);
            phone_number += "-";
            phone_number += join_phone.substr(3, 3);
            phone_number += "-";
            phone_number += join_phone.substr(6);
        }else if(join_phone.length < 14) {
            phone_number += join_phone.substr(0, 3);
            phone_number += "-";
            phone_number += join_phone.substr(3, 4);
            phone_number += "-";
            phone_number += join_phone.substr(7, 4);
            $(this).parent().find("p.error").hide();
        }
        
        $(this).val(phone_number);
    });
});

/////////////////////////////////////////////////////
// 회원가입 유효성 검사
/////////////////////////////////////////////////////
function validateForm(form) {
    
    let joinId = form.join_id.value.trim();
    let error = true;

    // ========== 아이디 유효성 검사 ===========
    let id_pattern = /^[a-zA-Z0-9]{6,}$/g;
    if(!id_pattern.test(joinId)) {
        alert("아이디 작성 조건에 부합하지 않습니다. 다시 확인해주세요.");
        form.join_id.focus();
        form.join_id.value = "";
        $("#join_id").parent().find("p.error").hide();
        return false;
    }

    // ========== 비밀번호 유효성 검사 ===========
    let pwd_pattern = /^(?=.*[a-zA-Z])(?=.*[!@#$%^~*+=-])(?=.*[0-9]).{8,20}$/;
    if(!pwd_pattern.test(form.join_pw.value)){
        alert("비밀번호 작성 조건에 부합하지 않습니다. 다시 확인해주세요.");
        form.join_pw.focus();
        form.join_pw.value = "";
        form.join_pw_re.value = "";
        $(".checked").children('li').removeClass("on"); 
        $("input[name='join_pw_re']").parent().find("p.error").hide();      
        return false;
    }

    // ========== 비밀번호 체크 유효성 검사 ===========
    if(form.join_pw.value.length > 0 && form.join_pw_re.value.length > 0){
        if(form.join_pw.value != form.join_pw_re.value){
            alert("비밀번호가 일치하지 않습니다. 다시 확인해주세요.");
            form.join_pw.focus();
            form.join_pw.value = "";
            form.join_pw_re.value = "";
            $(".checked").children('li').removeClass("on");             
            $("input[name='join_pw_re']").parent().find("p.error").hide();        
            return false;
        }
    }

    // ========== 이름 유효성 검사 ===========
    if(form.join_name.value.length < 2 || form.join_name.value.length > 9){
        alert("이름은 1자 이상 10자 이하로 입력해주세요.");
        form.join_name.focus();
        form.join_name.value = "";
        $("#join_name").parent().find("p.error").hide();
        return false;
    }

    // ========== 이메일 유효성 검사 ===========
    let email_pattern = /^([\w\.\_\-])*[a-zA-Z0-9]+([\w\.\_\-])*([a-zA-Z0-9])+([\w\.\_\-])+@([a-zA-Z0-9]+\.)+[a-zA-Z0-9]{2,8}$/;
    if(!email_pattern.test(form.join_email.value)) { 
        alert("잘못된 이메일 형식입니다. 다시 확인해주세요.");
        form.join_email.focus();
        form.join_email.value = "";
        $("#join_email").parent().find("p.error").hide();
        return false;
    }

    // ========== 전화번호 유효성 검사 ===========
    let phone_pattern = /^[0-9]{3}-[0-9]{4}-[0-9]{4}$/;
    if(!phone_pattern.test(form.join_phone.value)) { 
        alert("잘못된 전화번호 형식입니다. 다시 확인해주세요.");
        form.join_phone.focus();
        form.join_phone.value = "";
        $("#join_phone").parent().find("p.error").hide();
        return false;
    }

    // ajax 중복 체크
    if(joinId.length > 0) {
        $.ajax({
            type : "post",
            url : "memberIdCheck.do",
            data : { paramId : joinId },
            dataType : "text",
            async : false,
    
            success : function(data) {
                if(data > 0) {
                    alert("중복된 아이디입니다. 다시 확인해주세요.");
                    error = false;
                    form.join_id.focus();
                    form.join_id.value = "";                    
                    $("#join_id").parent().find("p.error").hide();                    
                }else {
                    error = true;
                }
            },
            error : function(e){
                alert("Error : " + e.status);
            }
        });        
        return error;
    }

}

