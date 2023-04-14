-- 후기 테이블
drop table staykey_review purge;

create table staykey_review(
    review_no number(5) primary key,
    review_stayno number(5) not null,
    review_stayname varchar2(50) not null,
    review_roomno number(5) not null,
    review_roomname varchar2(50) not null,
    review_point_total number(2,1),
    review_point1 number(2) default 10 not null,
    review_point2 number(2) default 10 not null,
    review_point3 number(2) default 10 not null,
    review_point4 number(2) default 10 not null,
    review_point5 number(2) default 10 not null,
    review_point6 number(2) default 10 not null,
    review_content varchar2(1000) not null,
    review_file varchar2(200),
    review_id varchar2(30) not null,
    review_pw varchar2(50) not null,
    review_name varchar2(50) not null,
    review_date date default sysdate
);

comment on column staykey_review.review_no is '리뷰 번호';
comment on column staykey_review.review_stayno is '숙소 번호';
comment on column staykey_review.review_stayname is '숙소 이름';
comment on column staykey_review.review_roomno is '방 번호';
comment on column staykey_review.review_roomname is '방 이름';
comment on column staykey_review.review_point_total is '합계 평점';
comment on column staykey_review.review_point1 is '평점 접근성';
comment on column staykey_review.review_point2 is '평점 서비스';
comment on column staykey_review.review_point3 is '평점 객실시설';
comment on column staykey_review.review_point4 is '평점 부대시설';
comment on column staykey_review.review_point5 is '평점 식음료';
comment on column staykey_review.review_point6 is '평점 만족도';
comment on column staykey_review.review_content is '리뷰 내용';
comment on column staykey_review.review_file is '리뷰 파일이름';
comment on column staykey_review.review_id is '작성자 아이디';
comment on column staykey_review.review_pw is '작성자 비번';
comment on column staykey_review.review_name is '작성자 이름';
comment on column staykey_review.review_date is '리뷰 작성일';

insert into staykey_review values(1, 1, '숙소 이름', 1, '방 이름', 7.5, 10, 9, 8, 7, 6, 5, '리뷰내용1
줄바꿈 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용', null, 'test', '1234', '테스트1', sysdate);
insert into staykey_review values(2, 2, '숙소 이름2', 1, '방 이름', 7.5, 10, 9, 8, 7, 6, 5, '리뷰내용2
줄바꿈 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용', null, 'test', '1234', '테스트2', sysdate);
insert into staykey_review values(3, 1, '숙소 이름', 2, '방 이름2', 7.5, 10, 9, 8, 7, 6, 5, '리뷰내용3
줄바꿈 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용 리뷰내용', null, 'test', '1234', '테스트1', sysdate);

commit;