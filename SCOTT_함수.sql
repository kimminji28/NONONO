-- 함수 (260203).
select profno
    ,name
    ,pay * 12 + nvl(bonus, 0) * 3 as "연봉"
    ,pay
    ,nvl(bonus, 0) as "bonus" --bonus 값이 null이면 0으로 계산해줘라.
from professor;

--initcap('문자열'/컬럼)
SELECT initcap('hello')
from dual; --규칙을 만들기위해 의미없는 테이블을 만듦.

SELECT profno
    ,INITCAP(name) "INITCAP"
    ,lower(name) "LOWER"
    ,upper(name) "UPPER"
    ,LENGTH('부케') "LENGTH"
    ,LENGTHB('뽀야미') "LENGTHB"
    ,concat('co','coa') "CONCAT"
from professor;

--예1) 교수테이블의 이름에 'st'가 포함된 교수의 교수번호, 이름, 입사일 출력
SELECT frofno
    ,name
    ,hiredate
from student
where name like '%st%';
--예2) 교수테이블의 교수이름이 10글자가 안되는 교수의 번호, 이름, 이메일 출력
select profno
    ,name
    ,email
    ,profno || name
    ,concat(profno, name)
from professor
where length(name) < 10;

--substr (값 빼오기) 79p
select 'hello, world'
	,substr('hello, world', 1, 5) substr1 -- +값이면 왼쪽 순번.
	,substr('hello, world', -5, 5) substr2 -- -값이면 오른쪽부터 왼쪽으로
    ,substr('0'||5, -2 , 2) mm --앞과 뒤 문자열 붙여서 월 완성
    ,instr('02)3456-2345', ')', 1) instr1
    ,instr('031)2345-2312', ')', 1) instr2 --문자열에서 찾는 문자열의 위치 반환.
    ,substr('02)3456-2345', 1, instr('02)3456-2345', ')', 1) -1) instr3
    ,substr('031)2345-2312', 1, instr('031)2345-2312', ')', 1) -1) instr4
from dual;

SELECT *
from student;

--주전공이(201) -> 전화번호, 지역번호 구분
SELECT name
    ,tel
    ,substr(tel, 1, instr(tel, ')', 1) -1) AS "AREA CODE" --출력 방식
    ,substr(tel                               --문자열.
    ,instr(tel, ')', 1)+1                     --시작위치.
    ,instr(tel, '-', 1) - instr(tel, ')', 1) -1
    ) as "1st No" --크기. (몇글자 가져오겠다.)
--    ,substr('hpage', 1, instr('hpage', ':', 1) -1) as "hpage"
from student s
where deptno1 = 201; --얘가 조건

--lpad / rpad
SELECT lpad('hello', 10, '*') ㅣpad --빈 문자열이 생기면 지정한 문자로 왼쪽부터 채우겠다.
from dual;

SELECT rpad('hello', 10, '*') rpad --빈 문자열이 생기면 지정한 문자로 오른쪽부터 채우겠다.
from dual;

-- lpad 퀴즈
SELECT lpad(ename, 9, '1234567') lpad
    ,rpad(ename, 9, substr('123456789', length(ename)+1)) rpad
    ,substr('123456789', length(ename)+1) str
from emp
where deptno = 10;

-- ltrim('값', '찾을문자열')
SELECT rtrim('Hello', 'o')
FROM dual;

--replace('값', '찾을문자열', '대체문자열')
SELECT replace('Hello', 'o', 'o, World')
from dual;

SELECT ename
    ,replace(ename, substr(ename, 1, 2), '**') repalce
    ,substr(ename, 1, 2) destination
from emp
where deptno = 10;

SELECT *
from emp;

--문제1)
SELECT ename
    ,replace(ename, substr(ename, 2, 2), '--') repalce
    ,substr(ename, 2, 2) destination
from emp
where deptno = 20;

--문제2)
SELECT name
    ,substr(jumin, 1, 6) || '-' || substr(jumin, 7, 13) jumin
    ,replace(jumin, substr(jumin, -7, 7), '-/-/-/-') replace
    ,substr(jumin, -7, 7) destination
from student
where deptno1 = 101;

--문제3)
SELECT name
    ,tel
    ,replace(tel, substr(tel, 5, 3), '***') replace
    ,substr(tel, 5, 3) destination
from student
where deptno1 = 102;

--문제4)
SELECT name
    ,tel
    ,replace(tel, substr(tel, -4, 4), '****') replace
    ,substr(tel, -4, 4) destination
from student
where deptno1 = 101;


SELECT name
--    ,replace(jumin, substr(jumin, 7, 1), '-')
    ,jumin
    ,substr(jumin, 1, 6) || '-' || substr(jumin, 7, 13)
from student
where deptno1 = 101;

--round(123.4)
SELECT round(123.456, -2) round
    ,trunc(123.4567, -1) trunc
    ,mod(12, 5) mod
    ,ceil(12.3) ceil
    ,floor(12.3) floor
    ,to_char(trunc(sysdate, 'mi'), 'rrrr/mm/dd hh24:mi:ss') trunc2 -- 년/월/일/시/분/초
from dual;

--날짜관련함수
SELECT add_months(sysdate, -1) next_month --28
    ,months_between(sysdate + 28, sysdate) months
from dual;

--사원번호, 이름, 근속년수 (23년 7개월)
SELECT empno
    ,ename
    ,hiredate
    ,trunc(months_between(sysdate, hiredate) / 12) || '년' ||
    mod(trunc(months_between(sysdate, hiredate)), 12)||'개월' "근속연수"
from emp;

--교수번호, 이름, 입사일자, 급여 (30년 이상)
SELECT profno, name, hiredate, position, pay, p.deptno
from professor p
where months_between(sysdate, hiredate) / 12 >= 20
ORDER BY 3;

--문제
SELECT profno, name, hiredate, position, pay, d.dname
from professor p, department d
where p.deptno = d.deptno
and d.dname = 'Software Engineering'
and months_between(sysdate, hiredate) /12 >= 20;

--sales부서에서 근속년 40년이 넘는 사람
--사번, 이름, 급여, 부서명
SELECT e.empno
    ,e.ename
    ,e.sal
    ,d.dname
from emp e, dept d
where e.deptno = d.deptno
and d.dname = 'SALES'
and months_between(sysdate, hiredate)/12 >= 40
order by e.empno;

--학과.
SELECT *
from professor;

--전공
SELECT *
from department;

SELECT profno, name, p.deptno, d.deptno, dname
from professor p, department d
where p.deptno = d.deptno
and d.dname = 'Computer Engineering'; --16*12=192

SELECT 2 + to_number('2', 9)
    ,concat(2, '2')
    ,sysdate
FROM dual
where sysdate > '2026/02/03';

--to_char(날짜, '포맷문자')
SELECT sysdate
    ,to_char(sysdate, 'rrrr-month-dd hh24:mi:ss') to_char
    ,to_date('05/2024/03', 'mm/rrrr/dd') to_date
from dual;

--to char
SELECT to_char(12345.6789, '099,999.$99') --반올림한 값을 문자로 출력.
from dual;

SELECT studno
    ,name
    ,birthday
    ,to_char(birthday, 'dd-month-rr')
FROM student
where to_char(birthday, 'mm') = '01';

--nvl()
SELECT nvl(10, 0) -- null ? 0 : 10
from dual;

SELECT pay + nvl(bonus, 0) "급여"
from professor;

-- student(profno) -> 담당교수가 없으면 9999 / 담당교수번호
SELECT nvl(profno, 9999)
    ,nvl(profno||'', '담당교수없음')
from student
order by 1 DESC;
-- student(profno) -> 담당교수가 없으면 담당교수없음 / 담당교수번호
SELECT nvl(to_char(profno), '담당교수없음')
from student;

--decode(A, B, '같은조건', '다른조건') A와 B가 같으면 같은조건, 다르면 다른조건을 출력함
SELECT decode(10, 20, '같다', '다르다') -- 10 == 20 ? '같다' : '다르다'
from dual;

SELECT studno, profno, decode(profno, null, 9999, profno)
from student
order by profno desc;

SELECT decode('C', 'A', '현재A', 'B', '현재B', '기타')
FROM dual;

--114p 유형1번
SELECT deptno
    ,name
    ,decode(deptno, 101, 'Computer Engineering', ' ') DNAME
from professor;

--115p 유형2번
SELECT deptno
    ,name
    ,decode(deptno, 101, 'Computer Engineering', 'ETC') DNAME
from professor;

--116p 유형3번
SELECT deptno
    ,name
    ,decode(deptno, 101, 'Computer Engineering', 102, 'Multimedia Engineering', 103, 'Software Engineering', 'ETC') DNAME
from professor;

--116p 유형4번
SELECT deptno
    ,name
    ,decode(deptno, 101, decode(name, 'Audie Murphy', 'BEST!', ' '), ' ') ETC
from professor;