-- 1. 현재 근무 중인 직원들 중에 38년 이상 근무했으나 직급이 Staff이고 salary_standard가 Low인 직원만 출력해주세요.
-- (salary가 70000 이상이면 'High', 50000 이상이면 'Medium', 50000 미만이면 'Low'라고 표시하되 표기명은 salary_standard입니다.)
-- (단, 같은 직원일 경우 가장 높은 급여만 'max_salary'라는 표기로 출력해야 합니다.)
SELECT e.emp_no,e.first_name,e.last_name,t.title, MAX(s.salary) AS max_salary, 
CASE
WHEN MAX(s.salary) >= 70000
THEN 'High'
WHEN MAX(s.salary) >= 50000
THEN 'Medium'
ELSE 'Low'
END AS 'salary_standard'
FROM salaries AS s
JOIN employees AS e ON s.emp_no = e.emp_no
JOIN titles AS t ON e.emp_no = t.emp_no 
WHERE t.to_date = '9999-01-01'
AND YEAR(CURRENT_DATE) - YEAR(hire_date) >= 38
AND t.title = 'Staff'
GROUP BY s.emp_no
HAVING salary_standard = 'Low';

-- 2. db sakila 에서
-- 가장 많은 작품에 출현한 배우 10명만 조회하라
-- 출력 예시 (first_name, 작품수 내림차순)
SELECT a.first_name, COUNT(*) AS count
FROM actor AS a
JOIN film_actor AS fa ON a.actor_id = fa.actor_id
GROUP BY fa.actor_id
ORDER BY count DESC
LIMIT 10;

-- 3. db sakila 에서
-- 각 언어 마다 몇개의 영화가 있는지 조회하라 (데이터상 모든 영화가 영어지만, 다른 언어가 0개 임을 표현해야함)
SELECT l.name, COUNT(f.language_id) AS count
FROM language AS l
LEFT JOIN film AS f ON l.language_id = f.language_id
GROUP BY l.language_id;

-- 4. db sakila 에서 
-- 가장 많은 작품을 찍은 배우의 작품을 모두 조회하라
-- 출력 예시 (first_name, title, category_name)
SELECT a.first_name, f.title, c.name AS category_name
FROM film_actor AS fa
JOIN actor AS a ON fa.actor_id = a.actor_id
JOIN film AS f ON fa.film_id = f.film_id
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id
WHERE fa.actor_id = (
	SELECT actor_id
    FROM film_actor
    GROUP BY actor_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

-- 5. (employees DB 사용)
-- 재직중이고 1995년 이후 입사한 Senior Engineer 직원이 가장 많은 부서 3개를 출력하세요
SELECT dept_no, COUNT(*) AS count
FROM employees AS e
JOIN titles AS t ON e.emp_no = t.emp_no
JOIN dept_emp AS de ON e.emp_no = de.emp_no
WHERE t.title = 'Senior Engineer'
AND hire_date >= '1995-01-01'
AND de.to_date = '9999-01-01'
AND t.to_date = '9999-01-01'
GROUP BY de.dept_no
ORDER BY count DESC
LIMIT 3;

-- 6. (sakila db 사용)
-- Horror 영화 중 상영시간이 가장 긴 영화(중복 가능)에 출연한 배우를 모두 조회하라
-- 출력예시 (first_name, last_name)
SELECT first_name, last_name, title 
FROM film_actor AS fa
JOIN actor AS a ON fa.actor_id = a.actor_id
JOIN film AS f ON fa.film_id = f.film_id
JOIN film_category AS fc ON fa.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id
WHERE f.length = (
	SELECT f.length
    FROM film AS f
    JOIN film_category AS fc ON f.film_id = fc.film_id
	JOIN category AS c ON fc.category_id = c.category_id
    WHERE c.name = 'Horror'
    ORDER BY f.length DESC
    LIMIT 1
) AND c.name = 'Horror';

-- 7. demo3 db
-- 제일 비싼 상품을 가지고 있는 카테고리를 출력(카테고리 이름 + 상품 이름 + 가격 )  mydb3 의 tb_products, tb_categories 사용
SELECT c.category_name, p.product_name, p.price
FROM tb_categories AS c
JOIN tb_products AS p ON c.category_id = p.category_id
ORDER BY price DESC
LIMIT 1;

-- 8. employees db
-- 직원번호 10033 직원의 최고 연봉액과 근무일수를 구하시오
SELECT MAX(salary), DATEDIFF(de.to_date, de.from_date) + 1 AS '근무일수'
FROM salaries AS s
JOIN employees AS e ON s.emp_no = e.emp_no
JOIN dept_emp AS de ON de.emp_no = e.emp_no
WHERE s.emp_no = 10033
GROUP BY s.emp_no;

-- 9. 가장 인원이 많은 부서의 매니저 이름을 출력하세요. db = employees
-- (정답 = first_name : Leon , last_name : DasSarma)
-- (퇴사한 매니저는 제외 && 퇴사 직원 제외)
SELECT first_name, last_name, dm.dept_no
FROM employees AS e
JOIN dept_manager AS dm ON e.emp_no = dm.emp_no
WHERE dm.dept_no = (
	SELECT dept_no
    FROM dept_emp AS d
    WHERE d.to_date = '9999-01-01'
    GROUP BY dept_no
    ORDER BY COUNT(*) DESC
    LIMIT 1
)
AND dm.to_date = '9999-01-01';

-- 10. 급여가 85000 이상인 근무중인 직원들 중 생일이 6월달인 직원을 출력(급여가 높은 순으로)
-- 출력 예시 : 직원 이름, 생일, 급여
SELECT CONCAT(e.first_name, ' ', e.last_name) AS name, e.birth_date, s.salary
FROM salaries AS s
LEFT JOIN employees AS e ON s.emp_no = e.emp_no
LEFT JOIN dept_emp AS de ON s.emp_no = de.emp_no
WHERE de.to_date = '9999-01-01' AND s.salary >= 85000
AND DATE_FORMAT(e.birth_date, '%m') = '06'
AND s.to_date = '9999-01-01'
ORDER BY s.salary DESC;

SELECT * FROM actor;
SELECT * FROM category;
SELECT * FROM film;
SELECT * FROM film_actor;
SELECT * FROM film_category;
SELECT * FROM film_text;
SELECT * FROM language;
SELECT * FROM payment;
SELECT * FROM rental;
SELECT * FROM store;
SELECT * FROM staff;
SELECT * FROM address;
SELECT * FROM city;
SELECT * FROM customer;
SELECT * FROM country;
SELECT * FROM inventory;
