use employees;

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

-- 1. 현재 Senior Engineer 인 직원의 employees 테이블을 조회하라
select e.*, t.title
from employees as e
join titles as t
on e.emp_no = t.emp_no
where t.title = 'Senior Engineer'
and t.to_date = '9999-01-01';

-- 2. 모든 부서의 관리자 변동 내역을 조회하라
select d.dept_name, m.*
from departments as d
left join dept_manager as m
on d.dept_no = m.dept_no;

-- 3. 각 부서의 현재 매니저의 승진 이력을 조회하라
select m.*, t.*
from dept_manager as m
join titles as t
on m.emp_no = t.emp_no
where m.to_date = '9999-01-01';

-- 4. 모든 마케팅 부서 직원의 이름을 조회하라
select e.emp_no,e.first_name,e.last_name,d.dept_name
from dept_emp as d_e
join employees as e on d_e.emp_no = e.emp_no
join departments as d on d_e.dept_no= d.dept_no
where d.dept_name = 'Marketing';

-- 5. 전직원 2000년도의 연봉을 출력하세요(출력 예시 :  id , firstname, lastname,slalary)
select e.emp_no, e.first_name, e.last_name, s.salary
from employees as e
join salaries as s on e.emp_no = s.emp_no
where s.from_date like '2000%';

-- 6. 'd004'  부서의 남자직원의 이름을 출력하세요 (출력예시 : firstname , M , 'd004' )
select e.first_name, e.gender, d.dept_no
from employees as e
join dept_emp as d on e.emp_no = d.emp_no
where dept_no = 'd004'
and e.gender = 'm';

-- 7. 각 직원의 정보를 확인하기 (직원번호, 생년월일, 이름, 성,부서번호, 부서명, 직업명)
select em.emp_no, em.birth_date, em.first_name, em.last_name, t.title
from employees as em
join dept_emp as de on em.emp_no = de.emp_no
join titles as t on em.emp_no = t.emp_no
join departments as d on de.dept_no = d.dept_no
where t.to_date = '9999-01-01';

-- 8. 1990년 이상 입사자 이름과 급여 부서 직책
select em.first_name, s.salary, de.dept_no, t.title
from employees as em
join salaries as s
join dept_emp as de
join titles as t
on em.emp_no = s.emp_no
and em.emp_no = de.emp_no
and em.emp_no = t.emp_no
where em.hire_date >= '1990-01-01'
and de.to_date = '9999-01-01'
and t.to_date = '9999-01-01'
and s.to_date = '9999-01-01';

-- 9. 부서 매니저들의 평균 연봉을 추출하라
select avg(salary) as avg
from dept_manager as dm
join salaries as s on dm.emp_no = s.emp_no
where s.to_date = '9999-01-01';

-- 10. 시니어 엔지니어의 월급중 6만달러가 넘는 사람은 몇명인가?
select count(s.emp_no) as `number of people`
from salaries as s
join titles as t on s.emp_no = t.emp_no
where title = 'Senior Engineer'
and salary > 60000
and s.to_date = '9999-01-01';


