--°Τ½ΓΖΗ
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

INSERT INTO news VALUES(NEWS_SEQ.nextval, 'λ°μ€?', ' ?¬?±?¨μ²? "λΆνΈ? ?©κΈ?" ?€? λ§μ?λ§? ??', '?΄λ₯Έλ° "??? ??λͺ¨λΈ λͺ°μΉ΄" ?¬κ±? ?΄? λΆλ² μ΄¬μ λ²μ£ ?±? κ·ν?΄?¨ ?¬?±?¨μ²? "λΆνΈ? ?©κΈ?"? λ§μ?λ§? ??κ°? ?€?(22?Ό) ?΄λ¦½λ?€. \r"λΆνΈ? ?©κΈ?\"? ?€? ?€? 2?λΆ??° 2λ§μ¬ λͺμ΄ μ°Έκ??΄ ??Έ κ΄νλ¬Έκ΄?₯?? \"λΆλ²μ΄¬μ ?Έ???¬ κ·ν 6μ°? μ§ν\"λ₯? ?΄κ² λ€κ³? λ°ν?΅??€. \rμ£Όμ΅ μΈ‘μ? ?Έ?°?· μΉ΄νλ₯? ?΅?΄ \"?΄λ²μ λ§μ?λ§μΌλ‘? ?€? ??λ₯? λ¬΄κΈ°? ?°κΈ°ν?€"λ©΄μ "6μ°? ?? ?΄? μ§?? 7κ°μ? ??λ³΄κ³  ??Όλ‘? ?¬?±?€?κ²? ?΄? ? λ°λ°?΄ λ°?? €?€?μ§? κ³ μ°°?κ² λ€"κ³? λ°ν?΅??€.', '2018-12-22', 0);

--ΘΈΏψ°‘ΐΤ
CREATE TABLE member
(NAME VARCHAR2(20)  NOT NULL,
PASSWORD VARCHAR2(50) NOT NULL,
EMAIL VARCHAR2(1000) PRIMARY KEY
);
DROP TABLE member;
select * from member;

commit;

INSERT into member values('±θΉΞΑ€', '1234', 'focso5@gmail.com' );



