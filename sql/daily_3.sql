-- 문제 1. 직원들 개인의 입사 이후 현재까지의 평균 연봉을 구해서 80000이 넘는 사람들만 출력하라. (내림차순으로 상위 100명만)
-- 출력 예시 (emp_no, last_name, avg)
select e.emp_no, last_name, round(avg(salary), 0) as avg
from salaries as s
join employees as e on s.emp_no = e.emp_no
group by s.emp_no
having avg > 80000
order by avg desc
limit 100;

-- 문제 2. 전체 평균 급여를 소수점 제외 도출하고 급여가 평균을 넘는 사원의 이름을 출력하세요.
select e.emp_no, last_name, round(avg(salary), 0) as avg
from salaries as s
join employees as e on s.emp_no = e.emp_no
group by s.emp_no
having avg > (select avg(salary) from salaries); 


-- 문제 3. 각 직급의 이름과 직급마다의 평균 급여를 출력
-- 단, 평균 급여의 소수점 자리는 없고 급여를 내림차순으로 출력
select title, round(avg(salary), 0) as avg
from salaries as s
join titles as t on s.emp_no = t.emp_no
group by title
order by avg desc;

-- 문제 4. employees 테이블에서 first_name, last_name, hire_date를 출력하고 hire_date를 내림차순으로 9번부터 시작해서 15개를 출력해라
select emp_no, first_name, last_name, hire_date
from employees
limit 8, 15;

select *, (year(hire_date) - year(birth_date)) as age
from employees as e
join salaries as s on e.emp_no = s.emp_no
where hire_date = from_date;


desc departments;
desc dept_emp;
desc dept_manager;
desc employees;
desc salaries;
desc titles;
select * from departments;
select * from dept_emp;
select * from dept_manager;
select * from employees;
select * from salaries;
select * from titles;