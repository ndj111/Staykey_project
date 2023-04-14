-- 예약 목록 테이블
drop table staykey_reserv purge;

create table staykey_reserv(
    reserv_no number(5) primary key,
    reserv_status varchar2(50) default 'reserv' not null,
    reserv_sess varchar2(50) not null,
    reserv_stayno number(5) not null,
    reserv_stayname varchar2(50) not null,
    reserv_roomno number(5) not null,
    reserv_roomname varchar2(50) not null,
    reserv_memid varchar2(30) not null,
    reserv_memname varchar2(50) not null,
    reserv_memphone varchar2(20) not null,
    reserv_mememail varchar2(100) not null,
    reserv_start date not null,
    reserv_end date not null,
    reserv_daycount number(3) default 1,
    reserv_basic_price number(10) default 0,
    reserv_option1_name varchar2(50),
    reserv_option1_price number(10) default 0,
    reserv_option2_name varchar2(50),
    reserv_option2_price number(10) default 0,
    reserv_option3_name varchar2(50),
    reserv_option3_price number(10) default 0,
    reserv_total_price number(10) default 0,
    reserv_people_adult number(5) default 0,
    reserv_people_kid number(5) default 0,
    reserv_people_baby number(5) default 0,
    reserv_pickup varchar2(10) default 'N',
    reserv_request varchar2(500),
    reserv_date date default sysdate
);

comment on column staykey_reserv.reserv_no is '예약 번호';
comment on column staykey_reserv.reserv_status is '예약 상태';
comment on column staykey_reserv.reserv_sess is '예약 주문번호';
comment on column staykey_reserv.reserv_stayno is '숙소 번호';
comment on column staykey_reserv.reserv_stayname is '숙소 이름';
comment on column staykey_reserv.reserv_roomno is '방 번호';
comment on column staykey_reserv.reserv_roomname is '방 이름';
comment on column staykey_reserv.reserv_memid is '예약자 아이디';
comment on column staykey_reserv.reserv_memname is '예약자 이름';
comment on column staykey_reserv.reserv_memphone is '예약자 전화번호';
comment on column staykey_reserv.reserv_mememail is '예약자 이메일';
comment on column staykey_reserv.reserv_start is '예약 일자 시작';
comment on column staykey_reserv.reserv_end is '예약 일자 종료';
comment on column staykey_reserv.reserv_daycount is '예약 숙박일수';
comment on column staykey_reserv.reserv_basic_price is '기존 요금';
comment on column staykey_reserv.reserv_option1_name is '옵션1 이름';
comment on column staykey_reserv.reserv_option1_price is '옵션1 가격';
comment on column staykey_reserv.reserv_option2_name is '옵션2 이름';
comment on column staykey_reserv.reserv_option2_price is '옵션2 가격';
comment on column staykey_reserv.reserv_option3_name is '옵션3 이름';
comment on column staykey_reserv.reserv_option3_price is '옵션3 가격';
comment on column staykey_reserv.reserv_total_price is '최종 결제금액';
comment on column staykey_reserv.reserv_people_adult is '성인 인원수';
comment on column staykey_reserv.reserv_people_kid is '아동 인원수';
comment on column staykey_reserv.reserv_people_baby is '영아 인원수';
comment on column staykey_reserv.reserv_pickup is '픽업 여부 (Y/N)';
comment on column staykey_reserv.reserv_request is '요청사항';
comment on column staykey_reserv.reserv_date is '예약 일자';

insert into staykey_reserv values(1, 'reserv', '221031-123456', 1, '테스트숙소1', 1, '테스트방1', 'test', '테스트', '010-1111-1111', 'test@test.com', '2022/10/18 12:00:00', '2022/10/20 12:00:00', 2, 150000, '바베큐 세팅', 20000, null, 0, null, 0, 168000, 2, 1, 0, 'N', '요청사항입력1
줄바꿈', sysdate);
insert into staykey_reserv values(2, 'cancel', '221031-654321', 2, '테스트숙소2', 2, '테스트방5', 'test2', '테스트2', '010-2222-2222', 'test2@test.com', '2022/10/30 12:00:00', '2022/10/31 12:00:00', 1, 70000, null, 0, null, 0, null, 0, 70000, 2, 0, 0, 'Y', '요청사항입력2
줄바꿈', sysdate);
insert into staykey_reserv values(3, 'reserv', '221031-451236', 3, '테스트숙소1', 3, '테스트방3', 'test2', '테스트', '010-1111-1111', 'test@test.com', '2022/11/05 12:00:00', '2022/11/06 12:00:00', 1, 90000, '풍선 이벤트', 50000, null, 0, null, 0, 140000, 2, 0, 0, 'N', '요청사항입력3
줄바꿈', sysdate);

commit;