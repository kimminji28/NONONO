-- oracle(DBMS) - version(21c) - xe(database명)
-- user(scott) - 테이블.
-- Structured Query Language (SQL)
select studno, name --colnum명(전체)
from student; --테이블명

-- 1. professor 테이블. 전체 컬럼 조회.
select * --소문자 사용 가능
from professor;

-- git (이력관리) / github(원격)
-- git init
-- git add (스테이지 상태로 변경)
-- (상태) unstage(저장) -> stage(커밋하기위해 스테이지 상태로 변경) -> commit (스냅샷) - push(깃에 원격으로 동기화)_(id/pw)
--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 (깃허브 토근 주소)

-- 2. student 테이블에서 학생번호, 이름, 학년 조회
select studno, name, grade
from student;

--git add SCOTT.sql
--git commit -m "commit 메세지"
--git push origin main (자료 보내기)

--origin(원격) -> clone(로컬)
--git clone https://github.com/kimminji28/oracle-sql.git (원격지 주소)

--git pull origin main (자료 가져오기)

--https://github.com/kimminji28/oracle-sql.git
-- 숙제완료함.

-- 3. 원격 repository => javascript 생성.
--javascript 폴더의 내용을 동기화 작업.

select name || '의 아이디는 ' || id as "전체설명" --별칭(alias)
    ,grade as "학년"
from student;
--James Seo의 '아이디'는 75true이고, 4학년입니다. => alias (학년설명)
select name || '의 ''아이디''는 ' || id || '이고 ' || grade || '학년입니다.' as "학년설명"
from student;

SELECT DISTINCT name, grade --중복된 값은 제외, 대표값만 가지고 옴
from student;

--연습문제 1)
SELECT *
from student;

SELECT name || '''s ' || 'ID: ' || id || ' , ' || 'weight ' || 'is ' || weight || 'kg'
from student;

--연습문제 2)
SELECT *
from emp;

SELECT ENAME || '(' || JOB || ')' || ', ' || ENAME || '''' || JOB || '''' AS "NAME AND JOB"
FROM EMP;

--where
SELECT *
from   student
where weight BETWEEN 60 and 70
and    deptno1 in (101, 201);

SELECT *
from student
where deptno2 is not null;

--비교연산자 연습1) emp테이블 급여 3000보다 큰 직원.
SELECT *
from emp
where sal > 3000;

--비교연산자 연습2) emp테이블 보너스 있는 직원.
SELECT * 
from emp
where comm is not null;

--비교연산자 연습3) student테이블 주전공학과: 101, 102, 103인 학생.
SELECT *
from student
where deptno1 in (101, 102, 103);

-- AND / OR
-- IF (sal > 100 && height > 170)
-- IF (sal > 100 or height > 170)
SELECT studno
    , name
    , grade
    , height
    , weight
from student
where (height > 170
or weight > 60)
and (grade = 4 or height > 150);

--비교연산자 연습4) 급여가 2,000 이상인 직원. 커미션(급여 + 커미션)
SELECT *
from emp
where sal > 2000 or (sal + comm) > 2000;

SELECT *
from professor;

--교수=>연봉이 3000 이상. 보너스 3번?
--> 교수번호, 이름, 연봉으로 출력.
SELECT profno
    ,name
    ,pay
    ,bonus
    ,pay * 12 as total_1
    ,pay * 12 + bonus * 3 as total_2
from professor
--where (pay * 12) + (bonus * 3) >= 4000; is not null 안넣으면 값이 바뀔 수 있음 error
--교수님 버전
where (pay * 12>= 3000 AND bonus is null)
OR (pay * 12 + bonus * 3 >= 3000 AND bonus is not null)
order by 5 --정렬기준
;

--문자열 like 연산자.
SELECT *
from student
where name like '%on____%';

SELECT profno
    ,name
    ,pay
    ,bonus
    ,hiredate
from professor
where hiredate > to_date('1999-01-01', 'rrrr-mm-dd')
order by hiredate; --1970.01.01

--학생테이블, 전화번호(02, 031, 051, 052, 053..)
SELECT *
from student
ORDER by jumin;

--=>부산에 거주하는 사람 데이터 뽑아 (051).
SELECT tel
from student
where tel like '%051%';

--이름 M 8개 이상인 사람.
SELECT *
from student
where name like '%m_______%';

--주민번호 10월에 태어난 사람 조회.
SELECT *
from student
<<<<<<< HEAD
where jumin like '%__10_________%';

SELECT ENAME || '''s ' || ( 'sal ')  || ('is ') || ('$') || sal || '' AS "Name And Sal"
from emp
order by sal;
=======
where jumin like '%__10_________%';
>>>>>>> 7e178a7 (함수완료)
