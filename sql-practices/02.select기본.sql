-- show tables;

-- select count(*) from employees;

-- select * from employees where emp_no=10001;
-- select * from salaries where emp_no=10001 and to_date='9999-01-01';

select * from departments;
select first_name as '이름' , last_name as '성', hire_date as'입사일'
	from employees;
select concat(first_name,' ',last_name) as '이름' , last_name as '성', hire_date as'입사일'
	from employees;
select concat(first_name,' ',last_name) as '이름' , 
	   length(first_name),
       gender as '성 별', 
       hire_date as'입사일'
	from employees;    

-- distinct
select distinct title from titles;

-- order by
select concat(first_name,' ',last_name) as '이름' , 
	   length(first_name),
       gender as '성 별', 
       hire_date as'입사일'
	from employees
    order by hire_date desc;


-- 월급순으로 출력
-- Like 검색
select * from employees where first_name like 'p%'; -- p로 시작하는 직원
select * from employees where first_name like '%pe'; -- pe로 끝나는 직원
select * from employees where first_name like 'p____'; -- p로 시작하는 뒤 4글자 직원
select * from salaries where from_date like '2001-06%'; -- 2001-06 으로 시작하는 입사일

-- 1.salaries 데이블에서 2001년 월급이 가장 높은순으로 사번 월급순으로 출력
select emp_no, salary
from salaries where from_date like '2001-%' order by salary desc;
-- 2.salaries 데이블에서 2001년 월급이 가장 높은순으로 사번 월급순으로 출력
select emp_no, salary
from salaries 
where from_date > '2000-12-31' and from_date < '2002-01-01'
 order by salary desc;
 -- 3.salaries 데이블에서 1991년 이전에 입사한 직원의 이름, 성별, 입사일을 출력
select first_name, gender, hire_date
from employees 
where hire_date < '1991-01-01'
order by hire_date desc;

-- 4.employees 데이블에서 1989년 이전에 입사한 야직원의 이름
select first_name, gender, hire_date
from employees 
where hire_date < '1989-01-01' and gender = 'F'
order by hire_date desc;

-- date_format
select first_name, gender, date_format(hire_date, '%Y년 %m월 %d일 %h:%i:%s') as hire_date
from employees 
where hire_date < '1989-01-01' and gender = 'F'
order by hire_date desc;