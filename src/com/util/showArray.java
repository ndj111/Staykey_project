package com.util;

import java.util.ArrayList;
import java.util.List;

public class showArray {
    public List<String> listArr = new ArrayList<>();

    public void getList(String type) {
        if(type.equals("stayType")){
            listArr.add("호텔");
            listArr.add("호스텔");
            listArr.add("게스트하우스");
            listArr.add("민박");
            listArr.add("펜션");
            listArr.add("리조트");
            listArr.add("렌탈하우스");
            listArr.add("한옥");
            listArr.add("캠핑&아웃도어");

        }else if(type.equals("roomType")){
            listArr.add("기본형");
            listArr.add("거실형");
            listArr.add("독채형");
            listArr.add("원룸형");
            listArr.add("투룸형");
            listArr.add("복층형");
            listArr.add("오픈형");

        }else if(type.equals("roomFeat")){
            listArr.add("야외가구");
            listArr.add("천창");
            listArr.add("수영장");
            listArr.add("갤러리");
            listArr.add("실내 스파");
            listArr.add("월풀 스파");
            listArr.add("오픈 배스");
            listArr.add("썬베드");
            listArr.add("정원");
            listArr.add("개별 BBQ 데크");
            listArr.add("그네");
            listArr.add("테라스");
            listArr.add("독립 키친");
            listArr.add("독립 화장실");
            listArr.add("빅테이블");
            listArr.add("산책로");
            listArr.add("웰컴티");
            listArr.add("조식");
            listArr.add("주차");
            listArr.add("빔 프로젝터");
            listArr.add("샤워실");
            listArr.add("공용 키친");
            listArr.add("공용 화장실");
            listArr.add("자전거 렌탈");
            listArr.add("락커");
            listArr.add("픽업");
            listArr.add("캠핑테이블체어");

        }else if(type.equals("roomAmeni")){
            listArr.add("무선 인터넷");
            listArr.add("빔 프로젝트");
            listArr.add("TV");
            listArr.add("냉장고");
            listArr.add("세탁기");
            listArr.add("제습기");
            listArr.add("건조기");
            listArr.add("블루투스 스피커");
            listArr.add("헤어드라이어");
            listArr.add("전기포트");
            listArr.add("전자레인지");
            listArr.add("식기세척기");
            listArr.add("에어컨");
            listArr.add("인덕션");
            listArr.add("청소기");
            listArr.add("치약");
            listArr.add("샴푸");
            listArr.add("컨디셔너");
            listArr.add("바디로션");
            listArr.add("바디워시");
            listArr.add("핸드워시");
            listArr.add("샤워가운");
            listArr.add("빗");
            listArr.add("타월");
            listArr.add("세탁세제");
            listArr.add("모기약");
            listArr.add("연고");
            listArr.add("룸 슬리퍼");
            listArr.add("와인오프너");
            listArr.add("와인잔");
            listArr.add("토스터기");
            listArr.add("캡슐커피머신");
            listArr.add("보드게임");
            listArr.add("다기");
            listArr.add("조리도구");
            listArr.add("조미료");
            listArr.add("정수기");
            listArr.add("생수");

        }else if(type.equals("roomService")){
            listArr.add("현금영수증");
            listArr.add("BBQ");
            listArr.add("조식");
            listArr.add("침구추가");
            listArr.add("강아지간식");

        }
    }
}
