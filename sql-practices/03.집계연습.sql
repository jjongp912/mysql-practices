-- 예제1
-- 예제: salaries 테이블에서 현재 전체 직원의 평균급여 출력

select avg(salary) ,max(salary)
from salaries
where to_date = '9999-01-01';

-- 예제2
-- 예제: salaries 테이블에서 사번이 10060인 직원의 평균급여와 총합계 출력

select avg(salary), sum(salary)
  from salaries
 where emp_no=10060;

-- 예제3
-- 이 예제 직원의 최저 임글을 받은 시기와 최대 임금을 받은 시기를 각 각 출력
-- select 절에 집계함수가 있으면 다른, 컬럼은 올 수 없다.
-- 따라서 "받은 시기"는 조인이나 서브쿼리를 통해서 구해야한다.
-- ex) select avg(salary), sum(salary), from_date 일때
-- from_date 는 값이 나오긴 하지만 from_date는 쓰레기값이 나옴
select max(salary), min(salary)
  from salaries
 where emp_no=10060;


-- 예제4
-- dept_emp 테이블에서 d008에 현재 근무하는 인원수
select count(*)
from dept_emp
where dept_no='d008' and to_date='9999-01-01';

-- 예제5
-- 각 사원별로 평균연봉 출력
select emp_no,avg(salary) as avg_salary
from salaries
group by emp_no
order by avg_salary desc;

-- 예제6
-- salaries 테이블에서 현재 전체 직원별로 평균급여가 35000 이상인 직원의 평균 급여를 큰 순서로 출력

select emp_no,avg(salary)
from salaries
where to_date='9999-01-01' -- 여기서 35000이상 조건을 넣을 수 없다
group by emp_no  			-- group by를 활용해서 값을 뽑을 것이기 때문에 where로 다시 돌아갈 수 없다
having avg(salary) > 35000
order by avg(salary) desc;







