-- 매거진(게시판) 테이블
drop table staykey_magazine purge;

create table staykey_magazine(
    bbs_no number(5) primary key,
    bbs_title varchar2(100) not null,
    bbs_list_img varchar2(200),
    bbs_top_img varchar2(200),
    bbs_youtube varchar2(1000),
    bbs_detail_img1 varchar2(200),
    bbs_content1 varchar2(2000) not null,
    bbs_detail_img2 varchar2(200),
    bbs_content2 varchar2(2000) not null,
    bbs_map varchar2(1000),
    bbs_content3 varchar2(2000) not null,
    bbs_stayno varchar2(100),
    bbs_hit number(5) default 0 not null,
    bbs_writer_name varchar2(50) not null,
    bbs_writer_id varchar2(30) not null,
    bbs_writer_pw varchar2(50) not null,
    bbs_date date default sysdate not null
);

comment on column staykey_magazine.bbs_no is '번호';
comment on column staykey_magazine.bbs_title is '제목';
comment on column staykey_magazine.bbs_list_img is '목록 이미지';
comment on column staykey_magazine.bbs_top_img is '상단 이미지';
comment on column staykey_magazine.bbs_youtube is '유튜브';
comment on column staykey_magazine.bbs_detail_img1 is '상세이미지1';
comment on column staykey_magazine.bbs_content1 is '글내용1';
comment on column staykey_magazine.bbs_detail_img2 is '상세이미지2';
comment on column staykey_magazine.bbs_content2 is '글내용2';
comment on column staykey_magazine.bbs_map is '지도';
comment on column staykey_magazine.bbs_content3 is '글내용3';
comment on column staykey_magazine.bbs_stayno is '숙소 번호';
comment on column staykey_magazine.bbs_hit is '조회수';
comment on column staykey_magazine.bbs_writer_name is '작성자';
comment on column staykey_magazine.bbs_writer_id is '아이디';
comment on column staykey_magazine.bbs_writer_pw is '비밀번호';
comment on column staykey_magazine.bbs_date is '작성일자';

insert into staykey_magazine values(1, '제목1', null, null, null, null, '글내용1-1', null, '글내용1-2', null, '글내용1-3', '/1/2/3/', default, '홍길동1', 'user1', '1234', default);
insert into staykey_magazine values(2, '제목2', null, null, null, null, '글내용2-1', null, '글내용2-2', null, '글내용2-3', '/1/2/', default, '홍길동2', 'user2', '1234', default);
insert into staykey_magazine values(3, '제목3', null, null, null, null, '글내용3-1', null, '글내용3-2', null, '글내용3-3', '/1/3/', default, '홍길동3', 'user3', '1234', default);



commit;