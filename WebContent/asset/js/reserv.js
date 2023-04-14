/////////////////////////////////////////////////////
// 예약 관련
/////////////////////////////////////////////////////


// 예약하기 폼 - 인원 변경
$(function(){
    $(".people .select select").on("change", function(){
        const maxPeople = Number($(this).attr("max"));
        let getAdult = Number($(".people .select select[name='reserv_people_adult']").val());
        let getKid = Number($(".people .select select[name='reserv_people_kid']").val());
        let getBaby = Number($(".people .select select[name='reserv_people_baby']").val());
        let sumPeople = getAdult + getKid + getBaby;

        if(sumPeople > maxPeople){
            alert("최대 "+maxPeople+"명까지만 선택 할 수 있습니다.");
            if($(this).attr("name") == "reserv_people_adult"){
                $(this).val(1);
            }else{
                $(this).val(0);
            }
        }
    });
});



// 예약하기 폼 - 옵션 선택
$(function(){
    let basicPrice = $(".reserv-form input[name='reserv_basic_price']").val();
    let totalPrice = $(".reserv-form td.total-price dl > dd.total");

    $(".option-select .sel-option input[type='radio']").on("click", function(){
        let sumOptionPrice = 0;
        $(".reserv-form td.total-price dl > dt.opt-show .plus-option-wrap").html("")

        // 선택된 옵션 가격의 총 합
        $(".option-select .sel-option input[value='Y']:checked").each(function(){
            var thisName = $(".reserv-form input[name='reserv_option"+$(this).attr("num")+"_name']").val();
            var thisPrice = $(".reserv-form input[name='reserv_option"+$(this).attr("num")+"_price']").val();
            sumOptionPrice += Number(thisPrice);

            // 옵션 내용 표시
            $(".reserv-form td.total-price dl > dt.opt-show .plus-option-wrap").append("<li class=\"plus-option\">"+thisName+"</li>");
        });

        // 옵션 총 금액 표시
        $(".reserv-form td.total-price dl > dd.opt-price").text("₩"+setComma(sumOptionPrice));

        // 총 결제금액 인풋 히든
        $(".reserv-form input[name='reserv_total_price']").val(Number(basicPrice) + sumOptionPrice);

        // 총 결제금액 표시
        $(totalPrice).text("₩"+setComma(Number(basicPrice) + sumOptionPrice));
    });
});



// 예약하기 폼 - 동의
$(function(){
    $(".reserv-form input[name='agree_all']").on("click", function(){
        $(".reserv-form .rf-wrap .rfw-agree > ul > li > label > input[type='checkbox']").each(function(){
            if($(".reserv-form input[name='agree_all']").is(":checked")){
                $(this).prop("checked", true);
            }else{
                $(this).prop("checked", false);
            }
        });
    });

    $(".reserv-form .rf-wrap .rfw-agree .fold > li").on("click", function(){
        $(this).find(".view").toggle();
    });
});



// 예약하기 폼 - 체크
function chkReservForm(form) {
    if(form.agree_service.checked == false){
        alert("서비스 이용 약관에 동의해주세요.");
        form.agree_service.focus();
        return false;
    }

    if(form.agree_privacy.checked == false){
        alert("개인정보 처리방침에 동의해주세요.");
        form.agree_privacy.focus();
        return false;
    }

    if(form.agree_refund.checked == false){
        alert("환불규정에 동의해주세요.");
        form.agree_refund.focus();
        return false;
    }


    let showMsg = "* 스테이 이름 : " + $(".reserv-form input[name='reserv_stayname']").val() + "\n";
        showMsg += "* Room 선택 : " + $(".reserv-form input[name='reserv_roomname']").val() + "\n";
        showMsg += "* 숙박 기간 : " + $(".reserv-form input[name='reserv_start']").val().substr(0,10) + " ~ " + $(".reserv-form input[name='reserv_end']").val().substr(0,10) + " (" + $(".reserv-form input[name='reserv_daycount']").val() + "박 " + (Number($(".reserv-form input[name='reserv_daycount']").val())+1) + "일)\n";
        showMsg += "* 숙박 인원 : 성인 " + $(".reserv-form select[name='reserv_people_adult']").val() + "명, 아동 " + $(".reserv-form select[name='reserv_people_kid']").val() + "명, 영아 " + $(".reserv-form select[name='reserv_people_baby']").val() + "명\n\n";
        showMsg += "* 최종 결제금액 : " + setComma(Number($(".reserv-form input[name='reserv_total_price']").val())) + "원\n\n";
        showMsg += "위 예약내용이 맞으신가요?\n내용을 확인 하시면 예약이 완료됩니다. :-)";

    if(confirm(showMsg)){
        form.submit;
    }else{
        return false;
    }
}





