use employees;

desc departments;
select * from departments;
desc dept_emp;
select * from dept_emp;
desc dept_manager;
select * from dept_manager;
desc employees;
select * from employees;
desc salaries;
select * from salaries;
desc titles;
select * from titles;

-- 1. 1990년도 이전에 입사한 사람 중 남자만 조회하라
select *
from employees
where hire_date < '1990-01-01'
and gender = 'M';

-- 2. 최종 연봉만 조회하라
select *
from salaries
where to_date = '9999-01-01';

-- 3. staff의 employees 테이블을 조회하라
select employees.*
from employees join titles
on (employees.emp_no = titles.emp_no)
where titles.title = 'staff';
