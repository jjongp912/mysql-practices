-- 현재 근무하고 있는 직원의 이름과 직책을 직원 이름 순으로 출력하세요.
select *
from employees a limit 2, 2; -- 2번째 부터 2개 출력

select a.first_name, b.title
from employees a, titles b
where a.emp_no = b.emp_no -- 두 데이터를 합치는 작업 join condition
and b.to_date = '9999-01-01'  	-- select condition
and a.gender = 'F'				-- select condition
order by a.first_name;

-- 부서별로 현재 직책이 Engineer인 직원들에 대해서만 평균 급여를 구하세요.
select a.dept_no, d.dept_name, avg(b.salary) as avg_salary
from dept_emp a, salaries b, titles c , departments d
where a.emp_no = b.emp_no	-- join condition
and b.emp_no = c.emp_no		-- join condition
and a.dept_no = d.dept_no		-- join condition
and a.to_date = '9999-01-01'	-- select condition
and b.to_date = '9999-01-01'	-- select condition
and c.to_date = '9999-01-01'	-- select condition
and c.title = 'Engineer'
group by a.dept_no
order by avg_salary desc;

-- 현재, 직책별로 급여의 총합을 구하되 Engineer 직책은 제외
-- 단, 총합이 2,000,000,000 이상인 직책만 나타내며 급여의 통합에 대해서는 내림차순(desc)

select a.title, sum(b.salary) as sum_salary
from titles a, salaries b
where a.emp_no = b.emp_no
	and a.title not like 'Engineer'
	and a.to_date = '9999-01-01'
	and b.to_date = '9999-01-01'
group by a.title
  having sum_salary >= 2000000000 -- group by 이후 작업으로 having 사용
order by sum_salary desc;

--
-- ANSI / ISO SQL 1999 JOIN 문법
--
-- join ~ on 표준 문법
select a.first_name, b.title
    from employees a 
    join titles b 
      on a.emp_no = b.emp_no		-- join condition
   where b.to_date = '9999-01-01'  	
     and a.gender = 'F'				
order by a.first_name;

-- natural join
      select a.first_name, b.title
        from employees a 
natural join titles b          -- join 조건이 없고 자동으로 같은 컬럼이름을 찾아서 join
       where b.to_date = '9999-01-01'  	
         and a.gender = 'F'				
    order by a.first_name;
    
-- natural join 단점

select count(*)
  from titles a
  join salaries b
    on a.emp_no = b.emp_no
 where a.to_date = '9999-01-01'
   and b.to_date = '9999-01-01';
   
select count(*)
  from titles a
 natural join salaries b		-- 같은 컬럼이름이 여러개면 의도와 다른값이 나옴
 where a.to_date = '9999-01-01'
   and b.to_date = '9999-01-01';

-- join ~ using
select count(*)
  from titles a
join salaries b
using (emp_no)		-- join 할 컬럼이름 지정
 where a.to_date = '9999-01-01'
   and b.to_date = '9999-01-01';
   
 -- outer join
 
 
-- 1. 테스트 데이터 넣기 
-- insert into dept values(null,'총무');
-- insert into dept values(null,'개발');
-- insert into dept values(null,'영업');

-- insert into emp values(null, '둘리' , 2);
-- insert into emp values(null, '마이콜' , 3);
-- insert into emp values(null, '또치' , 2);
-- insert into emp values(null, '도우너' , 3);
-- insert into emp values(null, '길동' , null);

-- 현재 회사의 직원 이름과 부서이름을 출력하세요.

select a.name, b.name
  from emp a
  join dept b 
    on a.dept_no = b.no;  -- inner join 사용하면 null 값이 빠져서 안나옴)
 
 -- left join
    select a.name, ifnull(b.name,'없음')
      from emp a
 left join dept b 
        on a.dept_no = b.no;
 
 -- right join
    select a.name, ifnull(b.name,'직원없음')
      from emp a
right join dept b 
        on a.dept_no = b.no;
 
 
 
 