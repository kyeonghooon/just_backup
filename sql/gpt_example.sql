-- 배우의 성이 "Pitt"인 배우가 출연한 모든 영화의 제목을 나열하세요.
-- sql
-- 코드 복사
-- SELECT title
-- FROM film
-- WHERE film_id IN (
--     SELECT film_id
--     FROM film_actor
--     WHERE actor_id = (
--         SELECT actor_id
--         FROM actor
--         WHERE last_name = 'Pitt'
--     )
-- );
-- 연습문제 2: 특정 영화의 대여 정보
-- 문제: 특정 영화가 대여된 모든 날짜와 고객의 이름을 검색합니다.

-- 질문:

-- 영화 제목이 "ACADEMY DINOSAUR"인 영화가 대여된 모든 날짜와 고객의 이름을 나열하세요.
-- sql
-- 코드 복사
-- SELECT r.rental_date, c.first_name, c.last_name
-- FROM rental r
-- JOIN customer c ON r.customer_id = c.customer_id
-- WHERE r.inventory_id IN (
--     SELECT inventory_id
--     FROM inventory
--     WHERE film_id = (
--         SELECT film_id
--         FROM film
--         WHERE title = 'ACADEMY DINOSAUR'
--     )
-- );
-- 연습문제 3: 가장 많이 대여된 영화
-- 문제: 가장 많이 대여된 영화의 제목을 검색합니다.

-- 질문:

-- 대여 횟수가 가장 많은 영화의 제목을 나열하세요.
-- sql
-- 코드 복사
-- SELECT title
-- FROM film
-- WHERE film_id = (
--     SELECT film_id
--     FROM inventory
--     GROUP BY film_id
--     ORDER BY COUNT(*) DESC
--     LIMIT 1
-- );
-- 연습문제 4: 특정 카테고리의 영화 대여 정보
-- 문제: 특정 카테고리의 영화가 대여된 횟수를 검색합니다.

-- 질문:

-- "Action" 카테고리에 속한 모든 영화의 대여 횟수를 나열하세요.
-- sql
-- 코드 복사
-- SELECT f.title, COUNT(r.rental_id) AS rental_count
-- FROM film f
-- JOIN inventory i ON f.film_id = i.film_id
-- JOIN rental r ON i.inventory_id = r.inventory_id
-- WHERE f.film_id IN (
--     SELECT film_id
--     FROM film_category
--     WHERE category_id = (
--         SELECT category_id
--         FROM category
--         WHERE name = 'Action'
--     )
-- )
-- GROUP BY f.title
-- ORDER BY rental_count DESC;
-- 연습문제 5: 특정 고객의 대여 기록
-- 문제: 특정 고객이 대여한 모든 영화의 제목과 대여 날짜를 검색합니다.

-- 질문:

-- 고객의 성이 "Smith"인 모든 고객이 대여한 영화의 제목과 대여 날짜를 나열하세요.
-- sql
-- 코드 복사
-- SELECT f.title, r.rental_date
-- FROM rental r
-- JOIN inventory i ON r.inventory_id = i.inventory_id
-- JOIN film f ON i.film_id = f.film_id
-- WHERE r.customer_id IN (
--     SELECT customer_id
--     FROM customer
--     WHERE last_name = 'Smith'
-- )
-- ORDER BY r.rental_date;
-- 이 연습문제들은 다양한 서브쿼리와 조인 쿼리를 사용하여 Sakila 데이터베이스의 데이터를 탐색하고 분석하는 데 도움이 됩니다. 각 문제를 해결하면서 서브쿼리의 사용 방법과 SQL 쿼리 작성 능력을 향상시킬 수 있습니다.


-- 혹시 employees db 는 알아?
-- ChatGPT
-- 네, MySQL Employees 데이터베이스는 MySQL에서 학습과 실습을 위해 제공되는 또 다른 예제 데이터베이스입니다. 이 데이터베이스는 다양한 SQL 쿼리와 데이터베이스 관리 작업을 실습하는 데 사용됩니다. Employees 데이터베이스는 회사의 인사 관리 시스템을 모델링한 데이터베이스로, 다음과 같은 다양한 테이블과 관계를 포함하고 있습니다:

-- employees: 직원 정보를 저장
-- departments: 부서 정보를 저장
-- salaries: 직원 급여 정보를 저장
-- titles: 직원 직함 정보를 저장
-- dept_emp: 직원과 부서 간의 관계 정보를 저장
-- dept_manager: 부서 관리자 정보를 저장
-- 이 데이터베이스는 직원의 고용 이력, 부서 배치, 급여 변동 등과 같은 다양한 시나리오를 모델링하여 복잡한 SQL 쿼리와 데이터베이스 관리 작업을 연습할 수 있게 해줍니다.

-- Employees 데이터베이스를 사용한 서브쿼리 연습문제
-- 연습문제 1: 특정 직함을 가진 직원 목록
-- 문제: 특정 직함을 가진 모든 직원의 이름과 고용 날짜를 검색합니다.

-- 질문:

-- "Engineer" 직함을 가진 모든 직원의 이름과 고용 날짜를 나열하세요.
-- sql
-- 코드 복사
-- SELECT first_name, last_name, hire_date
-- FROM employees
-- WHERE emp_no IN (
--     SELECT emp_no
--     FROM titles
--     WHERE title = 'Engineer'
-- );
-- 연습문제 2: 특정 부서에서 일한 직원 목록
-- 문제: 특정 부서에서 일한 모든 직원의 이름과 부서에 속한 기간을 검색합니다.

-- 질문:

-- "Sales" 부서에서 일한 모든 직원의 이름과 부서에 속한 기간을 나열하세요.
-- sql
-- 코드 복사
-- SELECT e.first_name, e.last_name, de.from_date, de.to_date
-- FROM employees e
-- JOIN dept_emp de ON e.emp_no = de.emp_no
-- WHERE de.dept_no = (
--     SELECT dept_no
--     FROM departments
--     WHERE dept_name = 'Sales'
-- );
-- 연습문제 3: 가장 최근에 고용된 직원
-- 문제: 가장 최근에 고용된 직원의 이름과 고용 날짜를 검색합니다.

-- 질문:

-- 가장 최근에 고용된 직원의 이름과 고용 날짜를 나열하세요.
-- sql
-- 코드 복사
-- SELECT first_name, last_name, hire_date
-- FROM employees
-- ORDER BY hire_date DESC
-- LIMIT 1;
-- 연습문제 4: 특정 급여 이상을 받은 직원 목록
-- 문제: 특정 급여 이상을 받은 모든 직원의 이름과 급여를 검색합니다.

-- 질문:

-- 100000 이상의 급여를 받은 모든 직원의 이름과 급여를 나열하세요.
-- sql
-- 코드 복사
-- SELECT first_name, last_name, salary
-- FROM employees
-- JOIN salaries ON employees.emp_no = salaries.emp_no
-- WHERE salary >= 100000
-- ORDER BY salary DESC;
-- 연습문제 5: 특정 기간 동안 관리자였던 직원 목록
-- 문제: 특정 기간 동안 부서 관리자였던 모든 직원의 이름과 부서를 검색합니다.

-- 질문:

-- 1990-01-01부터 2000-01-01까지 부서 관리자였던 모든 직원의 이름과 부서를 나열하세요.
-- sql
-- 코드 복사
-- SELECT e.first_name, e.last_name, d.dept_name
-- FROM employees e
-- JOIN dept_manager dm ON e.emp_no = dm.emp_no
-- JOIN departments d ON dm.dept_no = d.dept_no
-- WHERE dm.from_date <= '2000-01-01' AND dm.to_date >= '1990-01-01';






