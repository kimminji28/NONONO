--emp 테이블을 조회하여 모든 사원의 이름과 급여를 아래와 같은 형태로 출력하세요.
SELECT ENAME || '''s ' || ( 'sal ')  || ('is ') || ('$') || sal || '' AS "Name And Sal"
from emp
order by sal;