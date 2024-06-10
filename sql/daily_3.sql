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

-- 문제 5. 입사 당시 나이가 30세 이하인 사람 중 초봉이 70000 이상인 사람을 조회하라 (내림차순)
-- 출력 예시 (emp_no, last_name, age, salary)
select e.emp_no, last_name, (year(hire_date) - year(birth_date)) as age, salary
from employees as e
join salaries as s on e.emp_no = s.emp_no
where hire_date = from_date
and (year(hire_date) - year(birth_date)) <= 30
and salary >= 70000
order by salary desc;

-- 문제 6. 재직중인 사원들 중 평균 연봉이 가장 큰 3명의 first_name, 평균 연봉(소숫점 제거),부서, 근무 년수 을 추출하시오.
select first_name, round(avg(salary)) as avg, dept_name, (year(current_date) - year(hire_date)) as 근무년수
from salaries as s
join employees as e on s.emp_no = e.emp_no
join dept_emp as de on e.emp_no = de.emp_no
join departments as d on de.dept_no = d.dept_no
group by s.emp_no
order by avg desc
limit 3;

-- 문제 7. Engineer에서 Senior Engineer로 승진했던 직원의 직원 번호와 first_name last_name을 합친 이름을 출력하시오
select e.emp_no, concat(first_name, " ", last_name) as name
from employees as e
join titles as t on e.emp_no = t.emp_no
where title = 'Engineer' or title = 'Senior Engineer'
group by e.emp_no
having count(title) >= 2;

-- 문제 8. 근무기간이 30년이상인 Staff 직원들중에서 emp_no낮은순서부터 200명 중에서 가장 오래된 근무년수는?
select max(t.workyear) as max
from (
select (year(current_date) - year(hire_date)) as workyear
from employees as e
join titles as t on e.emp_no = t.emp_no
where title = 'Staff' and to_date = '9999-01-01'
having workyear >= 30
limit 200
) as t;

-- 문제 9 부서별 평균급여계산 후 60000보다 높으면 'High' 낮으면 'Low' (부서, 부서평균, 급여수준 ('High' or 'Low')) 부서평균은 내림차순, 소수점 제거 해라
select dept_no, round(avg(salary)) as avg,
case
	when round(avg(salary)) > 60000 then 'High'
    else 'Low'
end as '급여수준'
from salaries as s
join dept_emp as e on s.emp_no = e.emp_no
group by dept_no
order by avg desc;

-- 문제 10 전직원에게 생일 상여금 지급 하기로 하였다. 월별 지급해야할 인원수를 구하세요(퇴사자 제외 || 출력예시 월, 인원수)
select month(birth_date) as month, count(*) as '인원수'
from employees as e
join dept_emp as de on e.emp_no = de.emp_no
where to_date = '9999-01-01'
group by month
order by month;

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