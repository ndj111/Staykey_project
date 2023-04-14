-- 일대일문의(게시판) 테이블
drop table staykey_qna purge;

create table staykey_qna(
    bbs_no number(5) primary key,
    bbs_status varchar2(50) default 'send',
    bbs_title varchar2(100) not null,
    bbs_content varchar2(2000) not null,
    bbs_file1 varchar2(200),
    bbs_file2 varchar2(200),
    bbs_hit number(5) default 0 not null,
    bbs_comment number(5) default 0 not null,
    bbs_writer_name varchar2(50) not null,
    bbs_writer_id varchar2(30) not null,
    bbs_writer_pw varchar2(50) not null,
    bbs_date date default sysdate not null
);

comment on column staykey_qna.bbs_no is '번호';
comment on column staykey_qna.bbs_status is '상태 (send/ing/done)';
comment on column staykey_qna.bbs_title is '제목';
comment on column staykey_qna.bbs_content is '내용';
comment on column staykey_qna.bbs_file1 is '첨부파일1';
comment on column staykey_qna.bbs_file2 is '첨부파일2';
comment on column staykey_qna.bbs_hit is '조회수';
comment on column staykey_qna.bbs_comment is '댓글 갯수';
comment on column staykey_qna.bbs_writer_name is '작성자';
comment on column staykey_qna.bbs_writer_id is '아이디';
comment on column staykey_qna.bbs_writer_pw is '비밀번호';
comment on column staykey_qna.bbs_date is '작성일자';

insert into staykey_qna values(1, 'send', '문의 제목1', '문의 내용1
줄바꿈', null, null, 0, 0, '관리자1', 'test', '1234', sysdate);
insert into staykey_qna values(2, 'done', '문의 제목2', '문의 내용2
줄바꿈', null, null, 0, 0, '관리자1', 'test2', '1234', sysdate);
insert into staykey_qna values(3, 'ing', '문의 제목3', '문의 내용3
줄바꿈', null, null, 0, 0, '관리자1', 'test', '1234', sysdate);

commit;