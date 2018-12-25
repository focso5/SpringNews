--뉴스게시물 작성
CREATE TABLE news
(ID NUMBER(8) PRIMARY KEY,
WRITER VARCHAR2(500) NOT NULL,
TITLE VARCHAR2(4000),

CONTENT VARCHAR2(4000) NOT NULL,
WRITEDATE DATE NOT NULL,
CNT NUMBER(8)
);
create sequence news_seq start with 1 increment by 1;
select * from news;
drop table news;

INSERT INTO news VALUES(NEWS_SEQ.nextval, '박윤수', ' 여성단체 "불편한 용기" 오늘 마지막 시위', '이른바 "홍대 누드모델 몰카" 사건 이후 불법 촬영 범죄 등을 규탄해온 여성단체 "불편한 용기"의 마지막 시위가 오늘(22일) 열립니다. \r"불편한 용기\"는 오늘 오후 2시부터 2만여 명이 참가해 서울 광화문광장에서 \"불법촬영 편파수사 규탄 6차 집회\"를 열겠다고 밝혔습니다. \r주최 측은 인터넷 카페를 통해 \"이번을 마지막으로 다음 시위를 무기한 연기한다"면서 "6차 시위 이후 지난 7개월을 돌아보고 앞으로 여성들에게 어떠한 반발이 밀려오는지 고찰하겠다"고 밝혔습니다.', '2018-12-22', 0);

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



