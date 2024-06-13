-- 1. 현재 까지 지출한 직급별 평균 연봉의 합산
SELECT SUM(x.avg) AS sum
FROM (
	SELECT AVG(salary) AS avg
	FROM salaries AS s
	JOIN titles AS t ON s.emp_no = t.emp_no
	GROUP BY title
) AS x;

-- 2. db sakila
-- LOVE 라는 단어가 들어간 영화에 가장 많이 출연한 배우는 누구인가
-- 출력 예시 first_name, last_name
SELECT a.first_name, a.last_name, COUNT(a.actor_id) AS 개수
FROM actor AS a
JOIN film_actor AS fa ON a.actor_id = fa.actor_id
JOIN film_text AS ft ON fa.film_id = ft.film_id
WHERE ft.title LIKE '%LOVE%'
GROUP BY a.actor_id
ORDER BY COUNT(a.actor_id) DESC
LIMIT 1;

-- 3. db employees
-- emp_no,birth_date,last_name,dept_no ,gender 그리고
-- demp_no 의 수가 2개 이상인 직원의 나이와 나이순으로 내림차순조회
-- 성별은 여성  부서의끝번호는 1제외, 고용날짜의 달이 짝수인 직원( 서브쿼리 사용안함)
SELECT e.emp_no, e.birth_date, e.last_name, de.dept_no, e.gender, COUNT(e.emp_no), YEAR(CURRENT_TIME())-YEAR(birth_date) AS age
FROM employees AS e
JOIN dept_emp AS de ON e.emp_no = de.emp_no
WHERE e.gender = 'M'
AND MONTH(e.hire_date) % 2 = 0
AND de.dept_no NOT LIKE '%___1'
GROUP BY emp_no
HAVING COUNT(e.emp_no) >= 2
ORDER BY age DESC;

-- 4. db employees 
-- 마케팅 부서에서 재직중이고, 태어난 년도의 일의자리가 1,2,3 이면 O 아니면 X로 표시하세요
-- 사번, 이름(이름 + 성), 생년월일, 체크 로 출력
SELECT e.emp_no, CONCAT(first_name, ' ',last_name) AS 이름, birth_date, 
	CASE
		WHEN YEAR(birth_date) % 10 IN (1,2,3) THEN 'O'
        ELSE 'X'
	END AS 체크
FROM employees AS e
JOIN dept_emp AS de ON e.emp_no = de.emp_no
WHERE de.to_date = '9999-01-01' AND de.dept_no = 'd001';

-- 5. db world
-- 각 아시아 국가의 수도 인구수를 조회하라 수도가 없다면 null로 표시
-- 단, 한국을 제일 위에 표시하라
SELECT ct.Code, ct.Name, c.Name, c.Population
FROM country AS ct
LEFT JOIN city AS c ON ct.Capital = c.ID
WHERE ct.Continent = 'Asia'
ORDER BY (
	CASE WHEN ct.Code = 'KOR' THEN 0
    ELSE 1
    END);

-- 6. db world
-- 각 언어별로 사용하는 인구가 얼마나 되는지 조회하라, 내림차순
-- 언어, 인구수
SELECT Language, SUM(인구) AS 전체인구
FROM (
SELECT cl.*, c.Population, ROUND((cl.Percentage * c.Population) / 100) AS 인구
FROM countrylanguage AS cl
JOIN country AS c ON cl.CountryCode = c.Code) AS sbq
GROUP BY Language
ORDER BY 전체인구 DESC;

-- 7. db employees
-- 부서별 여자직원의 평균연봉을 출력하기
SELECT dept_no, AVG(salary) AS 평균연봉
FROM salaries AS s
JOIN employees AS e ON s.emp_no = e.emp_no
JOIN dept_emp AS de ON de.emp_no = e.emp_no
WHERE e.gender = 'F'
GROUP BY de.dept_no;

-- 8. 마케팅 부서의 현재까지 지출했던 직급별 평균 연봉을 구하고 제일 높은 연봉을 받는 직원의 이름 (f, last name)을 구하시오
-- 출력값 (71832.6356, 73055.0585, Akemi Warwick)
SELECT 
	AVG(CASE WHEN title = 'Staff' THEN salary END) AS 스태프연봉평균,
    AVG(CASE WHEN title = 'Senior Staff' THEN salary END) AS 시니어스태프연봉평균,
    e.최고연봉자
FROM dept_emp AS de
JOIN titles AS t ON de.emp_no = t.emp_no
JOIN salaries AS s ON de.emp_no = s.emp_no
JOIN (
SELECT
    CONCAT(e.first_name, ' ' , e.last_name) AS 최고연봉자
	FROM dept_emp AS d
	JOIN salaries AS s
	ON d.emp_no = s.emp_no
	JOIN employees AS e
	ON d.emp_no = e.emp_no
	WHERE d.dept_no = 'd001'
	ORDER BY s.salary DESC
	LIMIT 1
	) AS e
WHERE de.dept_no = 'd001';

-- 9. 마케팅 부서의 시니어 스태프 사원 수를 출력 (서브쿼리 사용)
-- 출력 dept_no, title, 직원수, dept_name
SELECT de.dept_no, t.title, COUNT(de.emp_no) AS 직원수, d.dept_name
FROM titles AS t
JOIN dept_emp AS de ON t.emp_no = de.emp_no
JOIN employees AS e ON e.emp_no = de.emp_no
JOIN departments AS d ON de.dept_no = d.dept_no
WHERE t.title = 'Senior Staff' AND d.dept_name = (SELECT d.dept_name FROM departments AS d WHERE d.dept_name = 'Marketing')
GROUP BY d.dept_no;

-- 10. 평균 연봉이 가장 높은 부서의 재직중인 매니저의 emp_no, 부서명, 평균연봉, 이름을 출력하시오
-- 소숫점 2자리, first_name과 last_name은 결합하여 출력
SELECT s.emp_no, dept_name,ROUND(AVG(s.salary),2) AS 평균연봉, CONCAT(first_name, SPACE(1), last_name) AS 이름
FROM salaries s
JOIN titles AS t ON s.emp_no = t.emp_no
JOIN employees AS e ON s.emp_no = e.emp_no
JOIN dept_manager AS dm ON s.emp_no = dm.emp_no
JOIN dept_emp de ON s.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE de.to_date = '9999-01-01' AND dm.to_date = '9999-01-01'
GROUP BY d.dept_no
ORDER BY ROUND(AVG(s.salary),2) DESC
LIMIT 1;


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
SELECT * FROM addresstb_member;
SELECT * FROM city;
SELECT * FROM customer;
SELECT * FROM country;
SELECT * FROM inventory;

SELECT * FROM city;
SELECT * FROM country;
SELECT * FROM countrylanguage;

