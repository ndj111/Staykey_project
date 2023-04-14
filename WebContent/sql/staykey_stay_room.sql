-- 숙소 방 테이블
drop table staykey_stay_room purge;

create table staykey_stay_room(
    room_no number(5) primary key,
    room_stayno number(5) not null,
    room_name varchar2(50) not null,
    room_desc varchar2(2000),
    room_type varchar2(100),
    room_price number(10) not null,
    room_checkin varchar2(30) not null,
    room_checkout varchar2(30) not null,
    room_people_min number(3) default 1,
    room_people_max number(3),
    room_size number(10) not null,
    room_bed varchar2(500),
    room_features varchar2(500),
    room_amenities varchar2(500),
    room_service varchar2(500),
    room_photo1 varchar2(200),
    room_photo2 varchar2(200),
    room_photo3 varchar2(200),
    room_photo4 varchar2(200),
    room_photo5 varchar2(200),
    room_tag varchar2(500)
);

comment on column staykey_stay_room.room_no is '방 번호';
comment on column staykey_stay_room.room_stayno is '숙소 번호';
comment on column staykey_stay_room.room_name is '방 이름';
comment on column staykey_stay_room.room_desc is '간략 설명';
comment on column staykey_stay_room.room_type is '방 타입';
comment on column staykey_stay_room.room_price is '숙박비';
comment on column staykey_stay_room.room_checkin is '체크인 시간';
comment on column staykey_stay_room.room_checkout is '체크아웃 시간';
comment on column staykey_stay_room.room_people_min is '기준인원';
comment on column staykey_stay_room.room_people_max is '최대인원';
comment on column staykey_stay_room.room_size is '방 크기';
comment on column staykey_stay_room.room_bed is '침대 정보';
comment on column staykey_stay_room.room_features is '방 특징';
comment on column staykey_stay_room.room_amenities is '어메니티';
comment on column staykey_stay_room.room_service is '서비스';
comment on column staykey_stay_room.room_photo1 is '방 사진1';
comment on column staykey_stay_room.room_photo2 is '방 사진2';
comment on column staykey_stay_room.room_photo3 is '방 사진3';
comment on column staykey_stay_room.room_photo4 is '방 사진4';
comment on column staykey_stay_room.room_photo5 is '방 사진5';
comment on column staykey_stay_room.room_tag is '방 태그';

insert into staykey_stay_room values(1, 1, '방 이름1', '간략 설명', '원룸형', 70000, '15:00', '11:00', 2, 6, 55, '싱글 침대 1', '/특징1/특징2/특징3/특징4/', '/어메니티1/어메니티2/어메니티3/어메니티4/', '/서비스1/서비스2/서비스3/', null, null, null, null, null, '/캡슐 베드/개인 락커/와이파이/');
insert into staykey_stay_room values(2, 1, '방 이름2', '간략 설명', '복층형', 120000, '15:00', '11:00', 2, 6, 55, '더블 침대 1, 싱글 침대 1', '/특징1/특징2/특징3/특징4/', '/어메니티1/어메니티2/어메니티3/어메니티4/', '/서비스1/서비스2/서비스3/', null, null, null, null, null, '/온돌/금고/와이파이/');
insert into staykey_stay_room values(3, 1, '방 이름3', '간략 설명', '거실형', 90000, '15:00', '11:00', 2, 6, 55, '더블 침대 1', '/특징1/특징2/특징3/특징4/', '/어메니티1/어메니티2/어메니티3/어메니티4/', '/서비스1/서비스2/서비스3/', null, null, null, null, null, '/와이파이/대욕탕/샴페인/');

commit;