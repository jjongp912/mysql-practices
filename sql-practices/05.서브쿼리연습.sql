-- ex1)
-- 현재 Fai Bale이 근무하는 부서의 전체 직원의 사번과 이름을 출력하세요.

-- ex1-sol1)
select dept_no
from dept_emp a, employees b
where a.emp_no = b.emp_no
and a.to_date = '9999-01-01'
and concat(b.first_name, ' ',b.last_name) = 'Fai Bale'; 

select a.emp_no , b.first_name
from dept_emp a, employees b
where a.emp_no = b.emp_no
and a.dept_no = 'd004'
and a.to_date = '9999-01-01';

-- ex1-sol2)
-- 서브 쿼리로 해결
select a.emp_no , b.first_name
from dept_emp a, employees b
where a.emp_no = b.emp_no
and a.dept_no = (	select dept_no
					from dept_emp a, employees b
					where a.emp_no = b.emp_no
					and a.to_date = '9999-01-01'
					and concat(b.first_name, ' ',b.last_name) = 'Fai Bale')
and a.to_date = '9999-01-01';

-- where의 조건식에 서브쿼리를 사용하고 결과가 단일행인 경우:
-- =, !=, >, <, >=, <=

-- ex2)
-- 현재 전체 사원의 평균 연봉보다 적은 급여를 받는 사원들의 이름, 급여를 출력하세요.
select b.first_name, a.salary
from salaries a, employees b
where a.emp_no = b.emp_no
and a.to_date = '9999-01-01'
and a.salary < (select avg(salary) from salaries where to_date='9999-01-01')
order by a.salary desc;

-- where의 조건식에 서브쿼리를 사용하고 결과가 다중행인 경우:
-- in(not in)
-- any: =any(in 동일), >any, <>any(!=any), <=any, >=any
-- all: =all, >all, <all, <>all(!=all, not in), <=all, >=all

-- ex3)
-- 현재 급여가 50000 이상인 직원의 이름과 급여를 출력
--  join
select a.first_name, b.salary
from employees a, salaries b
where a.emp_no = b.emp_no
and b.to_date = '9999-01-01'
and b.salary > 50000
order by b.salary;

--  subquery (멀티행, 멀티열)
select a.first_name, b.salary
from employees a, salaries b
where a.emp_no = b.emp_no
and b.to_date = '9999-01-01'
and (a.emp_no, b.salary) =any (select emp_no, salary from salaries where to_date='9999-01-01' and salary > 50000)
order by b.salary;

--  subquery (멀티행, 멀티열) 
select a.first_name, b.salary
from employees a, salaries b
where a.emp_no = b.emp_no
and b.to_date = '9999-01-01'
and (a.emp_no, b.salary) in (select emp_no, salary from salaries where to_date='9999-01-01' and salary > 50000)
order by b.salary;

--  subquery (멀티행, 멀티열)
select a.first_name, b.salary
from employees a, (select emp_no, salary 
					from salaries 
                    where to_date='9999-01-01' 
                    and salary > 50000) b
where a.emp_no = b.emp_no
order by b.salary;

-- ex4) 현재 가장 적은 평균급여의 직책과 그 평균급여를 출력해보세요.
-- 불가능
select min(avg(salary)) from salaries where to_date='9999-01-01'; 
-- 
select b.title, round(avg(salary)) as avg_salary  -- 소수값은 정확한값이 아니라서 둘이 같다고 할수 없기에 값이 나오지 않음
from salaries a, titles b                         -- 그래서 round 처리
where a.emp_no = b.emp_no
and a.to_date='9999-01-01'
and b.to_date='9999-01-01'
group by b.title
having avg_salary = (	select min(avg_salary)
						from (	select b.title, round(avg(salary)) as avg_salary
								from salaries a, titles b
								where a.emp_no = b.emp_no
								and a.to_date='9999-01-01'
								and b.to_date='9999-01-01'
								group by b.title) a); 
                                
-- 쉬운 방법
select b.title, round(avg(salary)) as avg_salary
from salaries a, titles b
where a.emp_no = b.emp_no
and a.to_date='9999-01-01'
and b.to_date='9999-01-01'
group by b.title
order by avg_salary	-- 오름차순으로 맞춘 뒤
	limit 0, 1; 	-- 처음 값만 뽑으면 된다
    
-- ex5) 현재, 각 부서별로 최고 급여를 받는 사원의 이름과 급여를 출력


select a.dept_no, max(b.salary)
from dept_emp a, salaries b
where a.emp_no = b.emp_no
and a.to_date ='9999-01-01'
and b.to_date ='9999-01-01'
group by a.dept_no;

select a.first_name, b.dept_no, d.dept_name, c.salary
from employees a, dept_emp b, salaries c, departments d, 
(	select a.dept_no, max(b.salary) as max_salary
	from dept_emp a, salaries b
	where a.emp_no = b.emp_no
	and a.to_date ='9999-01-01'
	and b.to_date ='9999-01-01'
	group by a.dept_no
    limit 0, 1) e
where a.emp_no = b.emp_no
and b.emp_no - c.emp_no
and b.dept_no = d.dept_no
and b.dept_no = e.dept_no
and c.salary = e.max_salary
and b.to_date='9999-01-01'
and c.to_date='9999-01-01'
order by c.salary;

