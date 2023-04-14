/////////////////////////////////////////////////////
// 페이지 로딩
/////////////////////////////////////////////////////
(function($){
    $(window).on("load", function(){
        $("#ajax-loader").fadeOut("slow");
        $("html").removeClass("noscroll");
    });
})(jQuery);




/////////////////////////////////////////////////////
// 상단 날짜선택 검색
/////////////////////////////////////////////////////
$(document).ready(function(){
    // 오늘 날짜
    let getHToday = new Date();
    let gHYear = getHToday.getFullYear();
    let gHMonth = getHToday.getMonth() + 1;
    let gHDate = getHToday.getDate();

    $("#hidden-btn").daterangepicker({
        locale: {
            "separator": "/",
            "format": 'YYYY-MM-DD',
            "applyLabel": "확인",
            "cancelLabel": "취소",
            "daysOfWeek": ["일", "월", "화", "수", "목", "금", "토"],
            "monthNames": ["01월", "02월", "03월", "04월", "05월", "06월", "07월", "08월", "09월", "10월", "11월", "12월"]
        },
        minDate: gHYear+"/"+gHMonth+"/"+gHDate,
        maxDate: (gHYear+1)+"/"+gHMonth+"/"+gHDate,
        autoApply: true,
        opens: 'center',
        timePicker: false,
        showDropdowns: false,
        singleDatePicker: false,
        alwaysShowCalendars: true
    });

    // 날짜 선택 적용 시
    $("#hidden-btn").on("apply.daterangepicker", function(ev, picker){
        let sdate = picker.startDate.format('YYYY-MM-DD');
        let edate = picker.endDate.format('YYYY-MM-DD');

        $("#h_ps_start").val(sdate);
        $("#h_ps_end").val(edate);
    });

    $("#hidden-btn").on("show.daterangepicker", function(ev, picker){
        $(".daterangepicker").addClass("modify");
    });

    $("#FindDate").on("hide.bs.modal", function(e) {
        $(".daterangepicker.modify").removeClass("modify").css("display", "none");
    })


    // modal 실행시 스크롤 안되게
    $("#FindLoc, #FindDate").on("show.bs.modal", function(e) {
        $("html").addClass("noscroll");
    })
    $("#FindLoc, #FindDate").on("hide.bs.modal", function(e) {
        $("html").removeClass("noscroll");
    })
});





/////////////////////////////////////////////////////
// 마이페이지 메뉴
/////////////////////////////////////////////////////
$(function(){
    $(".header .h-wrap .menu-etc .mypage-link, .header .h-wrap .menu-etc .mypage-menu").hover(function(){
        $(".header .h-wrap .menu-etc .mypage-menu").addClass("open");
    }, function(){
        $(".header .h-wrap .menu-etc .mypage-menu").removeClass("open");
    });
});




/////////////////////////////////////////////////////
// 팝업창 띄우기
/////////////////////////////////////////////////////
popWindow = function(ps_url, ps_width, ps_height){
    var setLeft = ($(window).width() - ps_width) / 2;
    var setTop = ($(window).height() - ps_height) / 2;
    window.open(ps_url, "", "location=no,directories=no,resizable=no,status=no,toolbar=no,scrollbars=no,width="+ps_width+",height="+ps_height+",top="+setTop+",left="+setLeft)
}




//////////////////////////////////////////////////////////////////////////
// 위로이동
//////////////////////////////////////////////////////////////////////////
function gotoTop(){
    $("html, body").stop().animate({ scrollTop : 0 }, 50, "swing", function(){});
}


//////////////////////////////////////////////////////////////////////////
// 아래로이동
//////////////////////////////////////////////////////////////////////////
function gotoDown(){
    $("html, body").stop().animate({ scrollTop : $(document).height() }, 50, "swing", function(){});
}



//////////////////////////////////////////////////////////////////////////
// 페이지 위치 이동
//////////////////////////////////////////////////////////////////////////
function gotoPos(kind){
    var gopos = $("#"+kind).offset().top - 65;
    $("html, body").stop().animate({ scrollTop : gopos }, 50, "swing", function(){});
}




/////////////////////////////////////////////////////
// 숫자만 입력
/////////////////////////////////////////////////////
function NumberInput(el){
    $(el).keyup(function(){
        $(this).val($(this).val().replace(/[^0-9]/g,""));
    });
}


/////////////////////////////////////////////////////
// 영문+숫자만 입력
/////////////////////////////////////////////////////
function EngNumInput(el){
    $(el).keyup(function(){
        $(this).val($(this).val().replace(/[ㄱ-힣~!@#$%^&*()_+|<>?:{}= ]/g,''));
    });
}


/////////////////////////////////////////////////////
// 숫자, - 만 입력
/////////////////////////////////////////////////////
function NumSpInput(el){
    $(el).keyup(function(){
        $(this).val($(this).val().replace(/[a-zA-Zㄱ-힣~!@#$%^&*()_+|<>?:{}= ]/g,''));
    });
}


/////////////////////////////////////////////////////
// 이메일 입력
/////////////////////////////////////////////////////
function EmailInput(el){
    $(el).keyup(function(){
        $(this).val($(this).val().replace(/[ㄱ-힣~!#$%^&*()+|<>?:;{}= ]/g,''));
    });
}



/////////////////////////////////////////////////////
// 천단위 콤마 추가
/////////////////////////////////////////////////////
function setComma(str){
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}


/////////////////////////////////////////////////////
// 천단위 콤마 제거
/////////////////////////////////////////////////////
function RemoveComma(str){
    str = String(str);
    return Number(str.replace(/[^\d]+/g, ''));
}





/////////////////////////////////////////////////////
// jQuery UI 달력
/////////////////////////////////////////////////////
$(document).ready(function(){
    var clareCalendar = {
        monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
        dayNamesMin: ['일','월','화','수','목','금','토'],
        weekHeader: 'Wk',
        dateFormat: 'yy-mm-dd', //형식
        autoSize: false, //오토리사이즈(body등 상위태그의 설정에 따른다)
        changeMonth: true, //월변경가능
        changeYear: true, //년변경가능
        showMonthAfterYear: true, //년 뒤에 월 표시
        buttonImageOnly: false, //이미지표시
        yearRange: '2021:2040' //2021년부터 2040년까지,
    };
    $("#datePick1").datepicker(clareCalendar);
    $("#datePick2").datepicker(clareCalendar);
    $("#datePick3").datepicker(clareCalendar);
    $("#datePick4").datepicker(clareCalendar);
    $("#datePick5").datepicker(clareCalendar);
    $("#datePick6").datepicker(clareCalendar);
    $("#datePick7").datepicker(clareCalendar);
    $("#datePick8").datepicker(clareCalendar);
    $("#datePick9").datepicker(clareCalendar);

    $("img.ui-datepicker-trigger").attr("style","margin-left:5px; vertical-align:middle; cursor:pointer;"); //이미지버튼 style적용
    $("#ui-datepicker-div").hide(); //자동으로 생성되는 div객체 숨김  
});








