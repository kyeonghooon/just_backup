-- 1. 각 직급별 현재(to_date '9999-01-01' 기준) 직원수와 평균 연봉을 구하라 (소수점 생략)
-- 표시 예시(title, '직원수' ,avg)
select t.title, count(s.emp_no) as '직원수', round(avg(salary)) as avg
from salaries as s
join titles as t on s.emp_no = t.emp_no
and s.to_date = t.to_date
where t.to_date = '9999-01-01'
group by t.title;

-- 2. 각 부서별 현재(to_date '9999-01-01' 기준) 직원수와 평균 연봉을 구하라 (소수점 생략)
-- 표시 예시 (dept_no, dept_name, '직원수', avg)
select d.dept_no, d.dept_name, count(s.emp_no) as '직원수', round(avg(salary)) as avg
from salaries as s
join dept_emp as e
join departments as d
on s.emp_no = e.emp_no
and e.dept_no = d.dept_no
and e.to_date = s.to_date
where s.to_date = '9999-01-01'
group by dept_no;

-- 문제 3. 직원의 정보를 출력하라
-- 출력 예시 (Mr. Ms. last_name as name(남녀 구분), age(만나이), dept_name, title, 총 근무년차 as 년차)
select 
case
	when e.gender = 'M' then concat('Mr. ', last_name)
    else concat('Ms. ', last_name)
end as name,
truncate((to_days(now()) - to_days(birth_date))/365, 0) as age, dept_name, title,
(year(current_date) - year(hire_date)) + 1 as '년차'
from employees as e
join dept_emp as de
join departments as d
join titles as t
on e.emp_no = de.emp_no
and e.emp_no = t.emp_no
and de.dept_no = d.dept_no;

-- 문제 4. 매니저들의 최고 급여를 추출하세요
select max(salary)
from dept_manager as d
join salaries as s on d.emp_no = s.emp_no;

-- 문제 5. 퇴사자와 재직자를 구분 하며 퇴사자의 경우 재지년수를 출력하세요
-- (출력예시 = first_name, last_name, 근무상태(재직중 or 퇴사자경우 근무연수, 부서이동자의 경우 이전 부서에서의 년수))
select first_name, last_name, 
case
	when to_date = '9999-01-01' then '재직중'
    else concat((year(to_date) - year(hire_date)), "년") 
end as '근무상태'
from employees as e
join dept_emp as d on e.emp_no = d.emp_no;

-- 문제 6. 직원의 이름(first_name + last_name), 근무연수, 부서 출력
-- 단, 근무연수 35년 이상
select concat(first_name, ' ', last_name) as name, (year(current_date) - year(hire_date)) as '근무연수', dept_no
from employees as e
join dept_emp as d on e.emp_no = d.emp_no
where (year(current_date) - year(hire_date)) >= 35;

-- 문제 7. salaries테이블의 salary(연봉)을 월급으로 나누고(환율1365)
-- dept_name, dept_no, emp_no, from_date,to_date 조회하시오(조인필요)
-- 단 (from,to _date)는 salary의 테이블, 월급은 1,000,000 이상부터
select dept_name, de.dept_no, s.emp_no, s.from_date, s.to_date, (salary / 12) * 1365 as '월급'
from salaries as s
join dept_emp as de on s.emp_no = de.emp_no
join departments as d on de.dept_no = d.dept_no
where (salary / 12) * 1365 > 1000000;

-- 문제 8. first_name의 두 번째 알파벳이 a인 직원의 평균연봉을 구하세요.
select first_name , round(avg(salary)) as avg
from employees as e
join salaries as s on e.emp_no = s.emp_no
where substring(e.first_name, 2, 1) = 'a'
group by e.emp_no;

-- 문제 9. 마케팅부 30년차 근로자들 중 연봉이 80000 이상이면 O 아니면 X로 표기하세요.
--    이름(first_name + last_name), 년차, 연봉, 체크(O,X) 로 표시
select concat(first_name, ' ', last_name) as name, year(current_date) - year(hire_date) + 1 as '년차', salary,
case
	when salary > 80000 then 'O'
    else 'X'
end as `check`
from employees as e
join salaries as s on e.emp_no = s.emp_no
join dept_emp as d on e.emp_no = d.emp_no
where dept_no = 'd001'
and year(current_date) - year(hire_date) + 1 = 30
and s.to_date = '9999-01-01';

-- 문제 10. first_name과 last_name이 모두 같은 동명이인이 3명 이상인 경우는 몇가지인가?
select count(t.first_name) as '몇가지'
from (
select first_name
from employees
group by last_name, first_name
having count(last_name) > 2
and count(first_name) > 2) as t;

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