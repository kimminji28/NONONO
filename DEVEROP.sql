SELECT * 
from emp;

--추가작업(origin merge 테스트)
SELECT * 
from dept;

--DML (insert, update, delete, merge)
--1) insert into table명 (컬럼1, 컬럼2, ...) values(값1, 값2, ...); 외우거라.
SELECT * from board;

--4/타이틀-글등록연습/user01/sql연습중
--insert 완성.
insert into board (board_no, title, writer, content)
values((SELECT max(board_no)+1 from board)
        ,:title
        ,:writer
        ,:content);
--사용자에게 값을 입력받아서 넣겠다.

--보드 뒤에 칼럼 입력안해도 되는데 모든 값을 무조건 넣어줘야함
insert into board
values(8, 'title', 'user02', 'content', sysdate, 0);
SELECT * from board;

SELECT max(board_no)+1 from board; --순차적으로 보드 넘에 1씩 증가

update board
set    click_cnt = click_cnt + 1 --click_cnt 삽입할 때마다 +1씩 증가
      ,title = :title --'new Title'
      ,content = :content --'new ' || content
where board_no = :bno; --무조건 어디에 있는 컨텐트를 업뎃할거라는걸 입력해줘야함 아님 고객 데이터 다 날라감

delete from board
where content like '%바인드%'; --where writer = 'uesr01';  where board_no = 1;

SELECT * from board;

delete from emp
where ename like 'KIMMINJI';

SELECT * from emp ORDER BY 1 DESC;
--max+1, 이름, SALESMAN, '', 2026-02-01, 3000, 10, 30 
insert into emp (empno, ename, job, mgr, hiredate, sal, comm, deptno)
values ((SELECT max(empno)+1 from emp), '김민지', 'SALESMAN', '', to_date('2026-02-01', 'rrrr-mm-dd'), 3000, 10, 30);

--30부서의 MANAGER의 사번.
UPDATE emp
set    mgr = (SELECT empno from emp
              where deptno = 30
              ane   job = 'MANAGER')
where empno = 7936;

SELECT *
from emp
where deptno = 30
and job = 'MANAGER';

--상품테이블 (문구)
--상품코드(a001 to_char) 중복안됨, 상품명 반드시 입력, 가격(number) 반드시 입력, 상품설명 반드시 입력, 평점(max=5, min=1) number 기본값 3점, 제조사(date), 등록일자 기본값=sysdate
drop table myproduct;
CREATE TABLE myproduct(
    mpno      number(10) primary key, --상품코드
    mpname    varchar2(300) not null, --상품명
    mpprice   number(10) not null, --가격
    mpcontent varchar2(1000) not null, --상품설명
    mpreview  number(10) default 3, --평점
    mpzezo    varchar2(50), --제조사
    mpdate    date default sysdate --등록일자
);

insert into myproduct values ((SELECT max(mpno)+1 from myproduct), :mpname, :mpprice, :mpcontent, :mpreview, :mpzezo, to_date('2026-02-04', 'rrrr-mm-dd'));

select *
from myproduct
order by 1 desc;

update myproduct
set    mpname = '수납장'
where  mpcontent = '수납할 공간이 여유로움';

--머지 구문이 머지다
--merge into table1
--using table2
--on 병합조건
--when matched then
--update ...
--when not matched then
--insert ...

merge into myproduct tbl1
using (select '11' "mpno"
                ,'새로운상품' mpname
                ,14000 mpprice
                ,'아주 좋은 상품' mpcontent
       from dual) tbl2
on (tbl1.mpno = tbl2.mpno)
when matched then
  update set
     tbl.mpname = tbl2.mpname
    ,tbl1.mpprice = tbl2.mpprice
    ,tbl1.mpcontent = tbl2.mpcontent
when not matched then
  insert (mpno, mpname, mppirce, mpcontent)
  values (tbl2.mpno, tbl2.mpname, tbl2.mpprice, tbl2.mpcontent);