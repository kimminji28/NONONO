--emp 260202
SELECT ENAME || '''s ' || ( 'sal ')  || ('is ') || ('$') || sal || '' AS "Name And Sal"
from emp
order by sal;

--2026.02.03 (화) TODO.

--107page, 108page, 113page(nv12).

--학생테이블의 생년월일을 기준으로 1~3 => 1/4분기
--                           4~6 => 2/4분기
--                           7~9 => 3/4분기
--                           10~12 => 4/4분기
SELECT NAME
    ,SUBSTR(BIRTHDAY, 6, 2) "생년"
    ,DECODE(TO_CHAR(BIRTHDAY,'MM')
        ,01, '1/4분기'
        ,02, '1/4분기'
        ,03, '1/4분기'
        ,04, '2/4분기'
        ,05, '2/4분기'
        ,06, '2/4분기'
        ,07, '3/4분기'
        ,08, '3/4분기'
        ,09, '3/4분기'
        ,10, '4/4분기'
        ,11, '4/4분기'
        ,12, '4/4분기'
    ) "birthday"
FROM STUDENT
order by 2;

select name
    ,to_char(birthday, 'Q') || '/4분기' quarter1
    ,ceil(to_char(birthday, 'MM') / 3) || '/4분기' quarter2
    ,decode(to_char(birthday, 'MM')
    ,01, '1/4분기', 02, '1/4분기', 03, '1/4분기'
    ,04, '2/4분기', 05, '2/4분기', 06, '2/4분기'
    ,07, '3/4분기', 08, '3/4분기', 09, '3/4분기'
    ,10, '4/4분기', 11, '4/4분기', 12, '4/4분기') quarter3
from student;


--107page 1번
select empno
    ,ename
    ,sal
    ,comm
    ,to_char((sal*12)+comm, '999,999') "SALARY"
from emp
where ename = 'ALLEN';

--107page 2번
SELECT NAME
    ,PAY
    ,BONUS
    ,to_char((pay*12)+bonus, '999,999')"TOTAL"
FROM PROFESSOR
WHERE deptno = 201;

--108page
SELECT empno
    ,ename
    ,to_char(hiredate, 'rrrr-mm-dd') "HIREDATE"
    ,to_char((sal*12)+comm, '$999,999') "SAL"
    ,to_char(((sal*12+comm)*0.15)+(sal*12+comm), '$999,999') "15% up"
from emp
WHERE to_char((sal*12)+comm) IS NOT NULL;

--113page
SELECT empno
    ,ename
    ,comm
    ,nvl2(comm, 'Exist', 'NULL') "NVL2"
from emp
where deptno = 30
ORDER BY 1;