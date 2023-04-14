-- 회원 찜한 숙소 내역 테이블
drop table staykey_member_wish purge;

create table staykey_member_wish(
    wish_no number(5) primary key,
    wish_stayno number(5) not null,
    wish_memid varchar2(30) not null,
    wish_date date default sysdate
);

comment on column staykey_member_wish.wish_no is '찜 번호';
comment on column staykey_member_wish.wish_stayno is '숙소 번호';
comment on column staykey_member_wish.wish_memid is '찜 회원 아이디';
comment on column staykey_member_wish.wish_date is '찜한 일자';

insert into staykey_member_wish values(1, 1, 'test', sysdate);
insert into staykey_member_wish values(2, 1, 'test2', sysdate);
insert into staykey_member_wish values(3, 2, 'test', sysdate);

commit;