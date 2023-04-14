-- 숙소 테이블
drop table staykey_stay purge;

create table staykey_stay(
    stay_no number(5) primary key,
    stay_type varchar2(100) not null,
    stay_name varchar2(50) not null,
    stay_desc varchar2(100),
    stay_location varchar2(50) not null,
    stay_addr varchar2(100) not null,
    stay_phone varchar2(20) not null,
    stay_email varchar2(100) not null,
    stay_content1 varchar2(4000),
    stay_content2 varchar2(4000),
    stay_content3 varchar2(4000),
    stay_info1 varchar2(4000),
    stay_info2 varchar2(4000),
    stay_info3 varchar2(4000),
    stay_file1 varchar2(200),
    stay_file2 varchar2(200),
    stay_file3 varchar2(200),
    stay_file4 varchar2(200),
    stay_file5 varchar2(200),
    stay_option1_name varchar2(50),
    stay_option1_price number(10),
    stay_option1_desc varchar2(1000),
    stay_option1_photo varchar2(200),
    stay_option2_name varchar2(50),
    stay_option2_price number(10),
    stay_option2_desc varchar2(1000),
    stay_option2_photo varchar2(200),
    stay_option3_name varchar2(50),
    stay_option3_price number(10),
    stay_option3_desc varchar2(1000),
    stay_option3_photo varchar2(200),
    stay_room_price_min number(10) default 0,
    stay_room_price_max number(10) default 0,
    stay_room_people_min number(10) default 0,
    stay_room_people_max number(10) default 0,
    stay_hit number(10) default 0,
    stay_reserv number(10) default 0,
    stay_date date default sysdate
);

comment on column staykey_stay.stay_no is '숙소 번호';
comment on column staykey_stay.stay_type is '숙소 타입';
comment on column staykey_stay.stay_name is '숙소 이름';
comment on column staykey_stay.stay_desc is '간략 설명';
comment on column staykey_stay.stay_location is '숙소 위치';
comment on column staykey_stay.stay_addr is '숙소 주소';
comment on column staykey_stay.stay_phone is '숙소 연락처';
comment on column staykey_stay.stay_email is '숙소 이메일';
comment on column staykey_stay.stay_content1 is '내용 컨텐츠 1';
comment on column staykey_stay.stay_content2 is '내용 컨텐츠 2';
comment on column staykey_stay.stay_content3 is '내용 컨텐츠 3';
comment on column staykey_stay.stay_info1 is '안내사항 1';
comment on column staykey_stay.stay_info2 is '안내사항 2';
comment on column staykey_stay.stay_info3 is '안내사항 3';
comment on column staykey_stay.stay_file1 is '소개 사진 1';
comment on column staykey_stay.stay_file2 is '소개 사진 2';
comment on column staykey_stay.stay_file3 is '소개 사진 3';
comment on column staykey_stay.stay_file4 is '소개 사진 4';
comment on column staykey_stay.stay_file5 is '소개 사진 5';
comment on column staykey_stay.stay_option1_name is '옵션1 이름';
comment on column staykey_stay.stay_option1_price is '옵션1 가격';
comment on column staykey_stay.stay_option1_desc is '옵션1 설명';
comment on column staykey_stay.stay_option1_photo is '옵션1 사진';
comment on column staykey_stay.stay_option2_name is '옵션2 이름';
comment on column staykey_stay.stay_option2_price is '옵션2 가격';
comment on column staykey_stay.stay_option2_desc is '옵션2 설명';
comment on column staykey_stay.stay_option2_photo is '옵션2 사진';
comment on column staykey_stay.stay_option3_name is '옵션3 이름';
comment on column staykey_stay.stay_option3_price is '옵션3 가격';
comment on column staykey_stay.stay_option3_desc is '옵션3 설명';
comment on column staykey_stay.stay_option3_photo is '옵션3 사진';
comment on column staykey_stay.stay_room_price_min is '숙소 숙박비 최저';
comment on column staykey_stay.stay_room_price_max is '숙소 숙박비 최고';
comment on column staykey_stay.stay_room_people_min is '숙소 인원수 최소';
comment on column staykey_stay.stay_room_people_max is '숙소 인원수 최대';
comment on column staykey_stay.stay_hit is '숙소 조회수';
comment on column staykey_stay.stay_reserv is '숙소 예약수';
comment on column staykey_stay.stay_date is '숙소 등록일자';

insert into staykey_stay values(1, '호스텔', '바구니호스텔', '여행자를 위한 모든 것을 담다', '전라/순천시', '전라남도 순천시 조곡동 153-16', '010-6404-8925', 'bagunihostel@naver.com', '내용 컨텐츠 1', '내용 컨텐츠 2', '내용 컨텐츠 3', '안내사항 1', '안내사항 2', '안내사항 3', null, null, null, null, null, '바베큐 준비', '30000', '옵션1 설명', null, null, 0, null, null, null, 0, null, null, 0, 0, 0, 0, 12, 1, sysdate);
insert into staykey_stay values(2, '민박', '숙소 이름2', '간략 설명22', '서울/중구', '강원도 속초시 대포동 457-1', '010-2222-2222', 'stayhotel22@stay.com', '내용 컨텐츠 1', '내용 컨텐츠 2', '내용 컨텐츠 3', '안내사항 1', '안내사항 2', '안내사항 3', null, null, null, null, null, '바베큐 준비', '30000', '옵션1 설명', null, null, 0, null, null, null, 0, null, null, 0, 0, 0, 0, 12, 1, sysdate);
insert into staykey_stay values(3, '펜션', '숙소 이름3', '간략 설명22', '강원/속초', '강원도 속초시 대포동 457-1', '010-3333-3333', 'stayhotel33@stay.com', '내용 컨텐츠 1', '내용 컨텐츠 2', '내용 컨텐츠 3', '안내사항 1', '안내사항 2', '안내사항 3', null, null, null, null, null, '바베큐 준비', '30000', '옵션1 설명', null, null, 0, null, null, null, 0, null, null, 0, 0, 0, 0, 12, 1, sysdate);

commit;