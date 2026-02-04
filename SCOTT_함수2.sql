SELECT *
FROM EMP;

SELECT *
from dept;

--ORACLE vs.
SELECT e.*, dname, loc
from emp e, dept d
where e.deptno = d.deptno;

--ANSI vs. ORACLE
SELECT *
from emp e
join dept d ON e.deptno = d.deptno
where job = 'SALESMAN';

SELECT *
from student;

SELECT *
from professor;

SELECT studno, s.name, p.profno, p.name --컬럼을 각각 입력
from student s --주테이블
full outer join professor p ON s.profno = p.profno; --보조테이블
--student, professor
--left outer : from이 주테이블이라 student의 null값만 표시
--right outer : join이 주테이블이라 professor의 null값만 표시
--full outer : student, professor 둘 다 null값을 표시해줌 (*값)

--학생번호, 학생이름, 담당교수이름 / 담당교수없음
--0615, Daniel Day-Lewis, Jodie Foster
--9712, Sean Connery, 담당교수없음
SELECT s.studno "학생번호"
    ,s.name "학생이름"
    ,nvl(p.name, '담당교수없음') "교수이름"
from student s
left outer join professor p ON s.profno = p.profno;

--nvl(), decode('A', 'B', '같다', '다르다'), case when end
--student 지역번호 구분 02(서울) 031(경기도) 051(부산) 그외(기타)
SELECT name
    ,substr(tel, 1, instr(tel, ')', 1) -1) tel
    ,case substr(tel, 1, instr(tel, ')', 1) -1) when '02' then '서울'
                                                when '031' then '경기도'
                                                when '051' then '부산'
                                                else '기타'
    end "지역명"
from student
order by 3;

SELECT name
    ,substr(jumin, 1, 6) || '-' || substr(jumin, 7, 13) "주민번호"
    ,case when substr(jumin, 3, 2) BETWEEN '01' and '03' then '1/4분기'
          when substr(jumin, 3, 2) BETWEEN '04' and '06' then '2/4분기'
          when substr(jumin, 3, 2) BETWEEN '07' and '09' then '3/4분기'
          when substr(jumin, 3, 2) BETWEEN '10' and '12' then '4/4분기'
    end "분기"
from student
order by 3;

--123page
SELECT empno
    ,ename
    ,sal
    ,CASE when sal BETWEEN '1' and '1000' then 'LEVEL1'
          when sal BETWEEN '1001' and '2000' then 'LEVEL2'
          when sal BETWEEN '2001' and '3000' then 'LEVEL3'
          when sal BETWEEN '3001' and '4000' then 'LEVEL4'
          when sal BETWEEN '4001' and '5000' then 'LEVEL5'
          else '기타'
    end "LEVEL"
from emp
ORDER BY 4 DESC;

--156page (복수행_group 함수)
SELECT job
    ,count(*) "count"
    ,to_char(sum(sal), '999,999') "sum"
    ,round(avg(sal), 1) "avg"
    ,min(hiredate)
    ,max(ename)
    ,max(sal)
from emp
group by job;

SELECT * 
from emp;

--부서별 부서명, 급여합계, 평균급여, 인원
SELECT d.dname, e.* --메인쿼리
from  (SELECT deptno --메인 안에 있는 서브쿼리 / 일종의 테이블
            ,sum(sal) "sum"
            ,round(avg(sal), 1) "avg"
            ,count(*) "cnt"
        from emp
        group by deptno) e
join dept d ON e.deptno = d.deptno;
--emp dept 조인.
SELECT d.dname
    ,sum(e.sal) "급여합계"
    ,round(avg(e.sal + nvl(comm, 0)), 1) "평균급여"
    ,count(*) "인원"
from emp e
join dept d ON e.deptno = d.deptno
GROUP by d.dname;

--rollup()
--부서별 직무별(job) 평균급여, 사원수.
--부서별 평균급여, 사원수.
--전체 평균급여, 사원수.

--1. 부서별 직무별(job) 평균급여, 사원수.
SELECT deptno
    ,job
    ,round(avg(sal), 1)
    ,count(*)
from emp
group by deptno
    ,job
union
--2. 부서별 평균급여, 사원수.
SELECT deptno
    ,'소계'
    ,round(avg(sal), 1)
    ,count(*)
from emp
GROUP by deptno
union
--3. 전체 평균급여, 사원수.
SELECT 99
      ,'전체집계'
      ,round(avg(sal), 1)
      ,count(*) 
from emp
order by 1;

--rollup
SELECT deptno
    ,job
    ,round(avg(sal), 1)
    ,count(*) 
from emp
group by rollup(deptno, job)
order by 1;

--게시판(board) 생성
--[글번호, 제목, 작성자, 글내용, 작성시간] 조회수, 수정시간, 수정자...
drop table board;
create table board(
    board_no number(10) primary key,--글번호(키역할_중복된 역할은 안받는다.)
    title    varchar2(300) not null,--제목
    writer   varchar2(50) not null,--작성자
    content  varchar2(100) not null,--글내용
    created_at date default sysdate --작성시간
);
--컬럼추가.
alter table board add (click_cnt number);
--add(추가) / click_cnt number 클릭 카운트라는 컬럼추가(형태:숫자)
alter table board modify content varchar(1000);
--content의 입력수를 1000으로 늘리겠다.

desc board;

--not null : 값을 반드시 입력하겠다.
--primary key : 중복 불가능
--default sysdate : sysdate 값을 기본값으로 설정하겠다.
--drop : table 삭제

--값 입력
insert into board (board_no, title, writer, content)
values (1, 'test', 'user01', '연습글입니다');

insert into board (board_no, title, writer, content)
values (2, 'test2', 'user02', '연습글입니다2');

insert into board (board_no, title, writer, content)
values (3, 'test3', 'user03', '연습글입니다3');

SELECT *
from board;
commit;

update board
set    title = 'test3'
where  board_no = 4;

update board
set    title = 'test3'
where  content = '5시간50분남았다.';