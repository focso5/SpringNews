--뉴스게시물 작성
CREATE TABLE news
(ID VARCHAR2(8) PRIMARY KEY,
WRITER VARCHAR2(50) NOT NULL,
TITLE VARCHAR2(180),
CONTENT VARCHAR2(4000) NOT NULL,
WRITEDATE DATE NOT NULL,
CNT NUMBER(8)
);
create sequence news_seq start with 1 increment by 1;
select * from news;


--회원가입
CREATE TABLE member
(NAME VARCHAR2(20)  NOT NULL,
PASSWORD VARCHAR2(50) NOT NULL,
EMAIL VARCHAR2(1000) PRIMARY KEY
);
DROP TABLE member;
select * from member;

commit;

INSERT into member values('김민정', '1234', 'focso5@gmail.com' );



