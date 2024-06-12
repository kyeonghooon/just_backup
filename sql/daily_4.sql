-- 문제1. staff들 중 first_name이 Georgi인 동명이인을 찾고 나이가 많은 사람 순으로 정렬하시오.
-- 출력 title, first_name, last_name, brith_date
select title, first_name, last_name, birth_date
from employees e
join titles t on e.emp_no = t.emp_no
where first_name = 'Georgi'
and title = 'staff'
order by birth_date;

-- 문제 2. 생일에 입사한 사람을 모두 조회하라
-- 출력예시 employees.*
select *
from employees
where month(birth_date) = month(hire_date)
and day(birth_date) = day(hire_date);

-- 문제 3. 재직중이고 현재 연봉이 100000 이상인 직원수가 가장 많은 3개 부서를 출력하세요(부서, 고소득직원수)
select dept_name, count(*)
from departments d
join dept_emp de on d.dept_no = de.dept_no
join salaries s on s.emp_no = de.emp_no
where salary > 10000
group by d.dept_no
limit 3;

-- 문제 4. 승진을 2회 이상 하여 3개 이상의 직급을 지닌 이력이 있는 사람의 승진 날짜를 모두 출력하라
-- 출력 예시 last_name, title, from_date
select last_name, title, from_date
from titles t
join employees e on e.emp_no = t.emp_no
where t.emp_no in(select emp_no from titles group by emp_no having count(*) >= 3);

-- 문제 5. 부서 이동이 있었던 사원의 사번, 부서번호, 성, 이름, 이동 전,후 부서의 소속 기간을 출력하시오.
select de.emp_no, dept_no, last_name, first_name, to_date, from_date
from dept_emp de
join employees e on e.emp_no = de.emp_no
where de.emp_no in(
	select emp_no
    from dept_emp
    group by emp_no
    having count(*) > 1
);

-- 문제 6. 퇴사 이력(dept_emp의 to_date가 9999-01-01이 아니고 부서이동한것도 아닌 경우)을 조회하여 퇴사 날짜를 내림차순으로 정렬
select *
from dept_emp
where emp_no in (
	select emp_no
    from dept_emp
    group by emp_no
    having count(*) = 1)
and to_date != '9999-01-01'
order by to_date desc;

-- 문제 7. 재직중인 senior Engineer 들의 부서와 first_name 그리고 가장 최근 연봉을 출력하세요
select title, dept_name, first_name, salary
from employees e
join titles t on e.emp_no = t.emp_no
join salaries s on e.emp_no = s.emp_no
join dept_emp de on e.emp_no = de.emp_no
join departments d on de.dept_no = d.dept_no
where title = 'Senior Engineer'
and s.to_date = '9999-01-01';

-- 문제 8. 평균 연봉이 가장 높은 부서의 최상위 평균 연봉 10명만 조회하라 내림차순
-- 출력 예시 first_name, 평균연봉, 부서명
select first_name, round(avg(salary)) as avg, dept_name
from employees e
join salaries s on e.emp_no = s.emp_no
join dept_emp de on de.emp_no = e.emp_no
join departments d on d.dept_no = de.dept_no
join (
	select dept_no, avg(salary) as avg
	from salaries s
	join dept_emp de on de.emp_no = s.emp_no
	group by dept_no
	order by avg desc
	limit 1) as x on de.dept_no = x.dept_no
group by s.emp_no
order by avg desc
limit 10;

-- 문제 9. 남자 최고 연봉, 여자 최고 연봉을 구하라
select gender, max(salary)
from salaries s
join employees e on s.emp_no = e.emp_no
group by gender;

-- 문제 10. 각 직급별 최고 연봉을 구하라
select title, max(salary)
from salaries s
join titles t on s.emp_no = t.emp_no
group by title;


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