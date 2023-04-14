/////////////////////////////////////////////////////
// 숙소 관련
/////////////////////////////////////////////////////
$(document).ready(function(){
    // 오늘 날짜
    let getToday = new Date();
    let gYear = getToday.getFullYear();
    let gMonth = getToday.getMonth() + 1;
    let gDate = getToday.getDate();



    // 숙소 목록 페이지에서 작동 시
    // 숙소 예약 날짜 선택
    $("#ps_start, #ps_end").daterangepicker({
        locale: {
            "separator": "/",
            "format": 'YYYY-MM-DD',
            "applyLabel": "확인",
            "cancelLabel": "취소",
            "daysOfWeek": ["일", "월", "화", "수", "목", "금", "토"],
            "monthNames": ["01월", "02월", "03월", "04월", "05월", "06월", "07월", "08월", "09월", "10월", "11월", "12월"]
        },
        minDate: gYear+"/"+gMonth+"/"+gDate,
        maxDate: (gYear+1)+"/"+gMonth+"/"+gDate,
        autoApply: true,
        opens: 'center',
        timePicker: false,
        showDropdowns: false,
        singleDatePicker: false,
        isCustomDate : function(){}
    });

    // 날짜 선택 적용 시
    $("#ps_start, #ps_end").on("apply.daterangepicker", function(ev, picker){
        let sdate = picker.startDate.format('YYYY-MM-DD');
        let edate = picker.endDate.format('YYYY-MM-DD');

        $(".stay-search input[name='ps_start']").val(sdate);
        $(".stay-search input[name='ps_end']").val(edate);
        $("#ps_start").text(sdate.replaceAll("-", ". "));
        $("#ps_end").text(edate.replaceAll("-", ". "));
    });


    // 인원 선택 클릭
    $("#ps_people").on("click", function(){
        $("#selectNumber").toggleClass("open");
    });

    // 인원 선택 적용하기 버튼
    $(".stay-search #selectNumber .btn-number-search").on("click", function(){
        const getAdult = Number($(".stay-search #selectNumber input[name='ps_people_adult']").val());
        const getKid = Number($(".stay-search #selectNumber input[name='ps_people_kid']").val());
        const getBaby = Number($(".stay-search #selectNumber input[name='ps_people_baby']").val());
        let setPeople = "선택하세요";

        if(getAdult > 0 || getKid > 0 || getBaby > 0){
            setPeople = "성인 : " + getAdult + ", 아동 : " + getKid + ", 영아 : " + getBaby;
        }

        $("#ps_people").text(setPeople);
        $("#selectNumber").removeClass("open");
    });



    // 수량 증가 버튼
    $(".stay-search .layer-select .number-count .btn-plus").on("click", function(){
        const inputNum = $(this).parent().find(".input-num input");
        const maxVal = Number(inputNum.attr("max"));
        const plusVal = Number(inputNum.val()) + 1;

        if(plusVal >= maxVal){
            inputNum.val(maxVal);
        }else{
            inputNum.val(plusVal);
        }
    });

    // 수량 차감 버튼
    $(".stay-search .layer-select .number-count .btn-minus").on("click", function(){
        const inputNum = $(this).parent().find(".input-num input");
        const minVal = Number(inputNum.attr("min"));
        const minusVal = Number(inputNum.val()) - 1;

        if(minusVal <= minVal){
            inputNum.val(minVal);
        }else{
            inputNum.val(minusVal);
        }
    });

    // 수량 직접 입력 체크
    $(".stay-search .layer-select .number-count input[type='number']").on("keyup", function(){
        const minVal = Number($(this).attr("min"));
        const maxVal = Number($(this).attr("max"));
        const nowVal = Number($(this).val());

        if(nowVal >= maxVal){
            $(this).val(maxVal);
        }else if(nowVal <= minVal){
            $(this).val(minVal);
        }else{
            $(this).val(nowVal);
        }
    });


    // 닫기 버튼
    $(".stay-search .layer-select .btn-close").on("click", function(){
        $(this).parent().removeClass("open");
    });




    // 가격 범위 클릭
    $("#ps_price").on("click", function(){
        $("#selectPrice").toggleClass("open");
    });

    // 가격 범위 적용하기 버튼
    $(".stay-search #selectPrice .btn-number-search").on("click", function(){
        const getMin = Number($(".stay-search #selectPrice input[name='ps_price_min']").val() + "0000");
        const getMax = Number($(".stay-search #selectPrice input[name='ps_price_max']").val() + "0000");
        let setPrice = "가격범위";

        if(getMax > 0){
            setPrice = setComma(getMin) + " ~ " + setComma(getMax);
        }

        $("#ps_price").text(setPrice);
        $("#selectPrice").removeClass("open");
    });




    // 스테이 유형 클릭
    $("#ps_type").on("click", function(){
        $("#selectType").toggleClass("open");
    });

    // 스테이 유형 체크박스 클릭
    $(".stay-search #selectType .check-list li label input[name='ps_type'][value='all']").click(function(){
        if($(this).prop("checked")){
            $("input[name='ps_type']").prop("checked", false);
            $(this).prop("checked", true);
        }
    });
    $(".stay-search #selectType .check-list li label input[name='ps_type'][value!='all']").click(function(){
        $("input[name='ps_type'][value='all']").prop("checked", false);
    });

    // 스테이 유형 적용하기 버튼
    $(".stay-search #selectType .btn-number-search").on("click", function(){
        let setType = "스테이 유형";

        if(!$(".stay-search #selectType .check-list li label input[name='ps_type'][value='all']").prop("checked")){
            const chkLength = $(".stay-search #selectType .check-list li label input[name='ps_type'][value!='all']:checked").length;
            const chkFirst = $(".stay-search #selectType .check-list li label input[name='ps_type'][value!='all']:checked:first-child").val();

            if(chkLength > 1){
                setType = chkFirst + " 외 " + (chkLength - 1) + "건";
            }else{
                setType = chkFirst;
            }
        }

        $("#ps_type").text(setType);
        $("#selectType").removeClass("open");
    });




    // Room 보기 페이지에서 작동 시
    // 숙소 예약 날짜 선택
    $(".srt-date").daterangepicker({
        locale: {
            "separator": "/",
            "format": 'YYYY-MM-DD',
            "applyLabel": "확인",
            "cancelLabel": "취소",
            "daysOfWeek": ["일", "월", "화", "수", "목", "금", "토"],
            "monthNames": ["01월", "02월", "03월", "04월", "05월", "06월", "07월", "08월", "09월", "10월", "11월", "12월"]
        },
        minDate: gYear+"/"+gMonth+"/"+gDate,
        maxDate: (gYear+1)+"/"+gMonth+"/"+gDate,
        autoApply: true,
        opens: 'center',
        timePicker: false,
        showDropdowns: false,
        singleDatePicker: false,
        isCustomDate : function(){}
    });

    // 날짜 선택 적용 시
    $(".srt-date").on("apply.daterangepicker", function(ev, picker){
        let sdate = picker.startDate.format('YYYY-MM-DD');
        let edate = picker.endDate.format('YYYY-MM-DD');
        const date1 = new Date(sdate);
        const date2 = new Date(edate);

        const diffDate = date1.getTime() - date2.getTime();
        const between = Math.abs(diffDate / (1000 * 60 * 60 * 24));

        $(this).html(sdate.replaceAll("-", ". ") + " - " + edate.replaceAll("-", ". ") + "<em>" + between + "박 " + (between+1) + "일</em>");
        $(".stay-room .sr-top .reserv-go").attr("start", sdate).attr("end", edate);
    });

    // 예약하기 버튼 클릭시
    reservGo = function(stay_no, room_no){
        const gBtn = $(".stay-room .sr-top .reserv-go");
        const sDate = gBtn.attr("start");
        const eDate = gBtn.attr("end");

        if(!sDate){
            alert("숙박하실 날짜를 선택해 주세요.");
            gotoTop();
            $(".stay-room .sr-top .srt-date").trigger("click");

        }else{
            location.href = "stayReserv.do?stay_no="+stay_no+"&room_no="+room_no+"&check_in="+sDate+"&check_out="+eDate;
        }
    }



    // 숙소 사진 슬라이드
    var stayviewPhotoSwiper = new Swiper(".stay-view .sv-top .svt-photo", {
        effect: "slide",
        slidesPerView: 1,
        spaceBetween: 0,
        speed: 500,
        loop: true,
        touchEnabled: true,
        autoplay: false,
        navigation: {
            nextEl: '.stay-view .sv-top .svt-photo .swiper-button-next',
            prevEl: '.stay-view .sv-top .svt-photo .swiper-button-prev',
        }
    });


    // 숙소 정보 이용안내 정보 탭
    $(".stay-view .sv-caution .faq_cont .tab_btn li").on("click", function(){
        $(".stay-view .sv-caution .faq_cont .tab_btn li.active").removeClass("active");
        $(this).addClass("active");

        $(".stay-view .sv-caution .faq_cont .tab_cont .tab_view.active").removeClass("active").addClass("hide");
        $(".stay-view .sv-caution .faq_cont .tab_cont .tab_view:nth-child("+$(this).attr("num")+")").removeClass("hide").addClass("active");
    });
});





// 찜하기(보기 페이지) Ajax
stayWish = function(btn, stay_no, member_id) {

    // 회원 체크
    if(!member_id || member_id == null || member_id == "undefined" || member_id == ""){
        alert("회원 로그인 후 사용 하실 수 있습니다.");
        return false;
    }


    // 찜 되어 있는 숙소인지 여부
    let wish_mode = "add";
    if($(btn).hasClass("on")) {
        wish_mode = "del";
    }


    $.ajax({
        contentType : "application/x-www-form-urlencoded;charset=UTF-8",
        type : "post",
        url : "stayWishOk.do",
        data : {
            wish_mode : wish_mode,
            stay_no : stay_no,
            member_id : member_id
        },

        success : function(data) {
            let wish_btn = $(".stay-view .sv-top .svt-info .wish");
            let wish_ico = $(".stay-view .sv-top .svt-info .wish > i");

            if(data.trim() == "add_ok") {
                wish_btn.addClass("on");
                wish_ico.removeClass("fa-heart-o").addClass("fa-heart");

            }else if(data.trim() == "del_ok") {
                wish_btn.removeClass("on");
                wish_ico.removeClass("fa-heart").addClass("fa-heart-o");

            }else{
                alert('처리중 오류가 발생하였습니다.');
            }
        },

        error : function(e){
            alert("Error : " + e.status);
        }
    });

}






// 찜하기(목록 페이지) Ajax
addWish = function(btn, stay_no, member_id) {

    // 회원 체크
    if(!member_id || member_id == null || member_id == "undefined" || member_id == ""){
        alert("회원 로그인 후 사용 하실 수 있습니다.");
        return false;
    }


    // 찜 되어 있는 숙소인지 여부
    let wish_mode = "add";
    if($(btn).hasClass("on")) {
        wish_mode = "del";
    }


    $.ajax({
        contentType : "application/x-www-form-urlencoded;charset=UTF-8",
        type : "post",
        url : "stayWishOk.do",
        data : {
            wish_mode : wish_mode,
            stay_no : stay_no,
            member_id : member_id
        },

        success : function(data) {
            let wish_btn = $("#stay_"+stay_no+" .slw-wish");
            let wish_ico = $("#stay_"+stay_no+" .slw-wish > i");

            if(data.trim() == "add_ok") {
                wish_btn.addClass("on");
                wish_ico.removeClass("fa-heart-o").addClass("fa-heart");

            }else if(data.trim() == "del_ok") {
                wish_btn.removeClass("on");
                wish_ico.removeClass("fa-heart").addClass("fa-heart-o");

            }else{
                alert('처리중 오류가 발생하였습니다.');
            }
        },

        error : function(e){
            alert("Error : " + e.status);
        }
    });

}




// 리뷰 그래프
function drawReview(canvasID, point1, point2, point3, point4, point5, point6){
    var canvas = document.getElementById(canvasID);
    if(canvas.getContext){
        var ctx = canvas.getContext("2d");

        const calc_width = document.getElementById(canvasID).offsetWidth;
        const calc_height = document.getElementById(canvasID).offsetHeight;
        const calc_w_full = calc_width/2;
        const calc_w_half = calc_width/4;
        const calc_h_full = calc_height/2;
        const calc_h_half = calc_height/4;

        var grd = ctx.createLinearGradient(0, 0, calc_width, calc_height);
        grd.addColorStop(0, "#e67000");
        grd.addColorStop(1, "#f40086");
        ctx.fillStyle = grd;

        ctx.beginPath();

        ctx.moveTo(calc_w_full, (calc_h_full-((point1/10)*calc_h_full))); //접근성
        ctx.lineTo((calc_w_full*(point2/10)+calc_w_full), (calc_h_half-((point2/10)*calc_h_half)+calc_h_half)); //객실시설
        ctx.lineTo(((calc_w_full*point3/10)+calc_w_full), ((calc_h_half*(point3/10))+calc_h_full)); // 부대시설
        ctx.lineTo(calc_w_full, (((point4/10)*calc_h_full)+calc_h_full)); //만족도
        ctx.lineTo((calc_w_full*((10-point5)/10)), (((point5/10)*calc_h_half)+calc_h_full)); //식음료
        ctx.lineTo((calc_w_full*((10-point6)/10)), ((calc_h_half*(1-(point6/10)))+calc_h_half)); //서비스

        ctx.fill();
    }
}



// 리뷰 목록 클릭
$(function(){
    $(".stay-view .sv-review .svr-list table tr.rlist").on("click", function(){
        if($(this).find(".arrow i").hasClass("fa-chevron-down")){
            $(this).find(".arrow i").removeClass("fa-chevron-down").addClass("fa-chevron-up");
        }else{
            $(this).find(".arrow i").removeClass("fa-chevron-up").addClass("fa-chevron-down");
        }

        const num = $(this).attr("num");
        $(".stay-view .sv-review .svr-list table tr#show_" + num).toggle();
    });
});




