-- 1. use employees
-- 1995년 이후에 입사한 현재 근무중인 직원들 중 '개발'부서에 '엔지니어' 직함을 
-- 가지고 있는 평균 연봉이 가장 높은 직원 10명을 출력
SELECT CONCAT(e.first_name, ' ', e.last_name) AS 이름, e.hire_date AS 고용일,
de.dept_no AS 부서번호, d.dept_name AS 부서, t.title AS 직함, AVG(s.salary) AS 급여
FROM employees AS e
JOIN dept_emp AS de 
ON e.emp_no = de.emp_no
JOIN departments AS d 
ON de.dept_no = d.dept_no
JOIN titles AS t 
ON e.emp_no = t.emp_no
JOIN salaries AS s
ON e.emp_no = s.emp_no
WHERE t.title = 'Engineer' AND d.dept_name = 'Development'
AND de.to_date = '9999-01-01' AND t.to_date = '9999-01-01' 
AND e.hire_date >= '1995-01-01'
AND s.salary >= 80000
GROUP BY e.emp_no
ORDER BY AVG(s.salary) DESC
LIMIT 10;

-- 2. use demo3 
-- 카테고리 번호 나누기 제품번호 의 나머지가 1일때는 컬러가'핑크'
-- 3보다 크거나 같을때는 제품이름에 남성이 포함 ,나머지는 컬러가 '퍼플' 로
-- 카테고리번호,제품이름,가격(십의자리숫자까지) 
SELECT c.category_id, product_name, SUBSTR(price,1,2)
FROM tb_categories c
JOIN tb_products p ON c.category_id=p.category_id
WHERE CASE
		WHEN c.category_id % p.product_id = 1 THEN p.color = '핑크'
		WHEN c.category_id % p.product_id >= 3 THEN product_name LIKE '%남성'
		ELSE p.color='퍼플' END;

-- 3. use world
-- world db에서 country 테이블과 contrylanguage를 활용하여 'KOR'의 국가코드, 지역, 정부, 언어를 출력해라
SELECT c.Code, c.Region, c.GovernmentForm, cl.Language
FROM country AS c 
JOIN countrylanguage AS cl
ON c.Code = cl.CountryCode 
WHERE c.Code = 'KOR'
AND cl.IsOfficial = 'T';

-- 4. use employees
-- Development 부서에서 재직중인 매니저인 직원의 최대 연봉을 조회하시오. (직원 번호, 최대 연봉)
SELECT s.emp_no, MAX(salary) AS 최대연봉
FROM salaries AS s
JOIN dept_manager AS dm ON s.emp_no = dm.emp_no AND dm.dept_no = 'd005'
WHERE dm.to_date = '9999-01-01	'
GROUP BY s.emp_no;

-- 5. use employees
-- 재직중인 매니저 성과 이름 조회하라
SELECT e.last_name, e.first_name
FROM employees AS e
JOIN dept_manager AS dm ON e.emp_no = dm.emp_no AND dm.to_date = '9999-01-01';

-- 6. use employees
-- 현재 재직중인 인원 중 권고사직할 인원 10명을 랜덤으로 추출하시오 (출력값 직원번호, 풀네임)
SELECT e.emp_no, CONCAT(e.first_name, ' ', e.last_name) AS 권고사직명단
FROM employees AS e
JOIN dept_emp AS de
ON e.emp_no = de.emp_no
WHERE de.to_date LIKE '9999%'
ORDER BY RAND()
LIMIT 10; 

-- 7. use employees
-- 마케팅 부서의 남자를 출력하세요(emp_no, dept_no, gender, name)
SELECT e.emp_no, dept_no, gender, last_name
FROM employees AS e
JOIN dept_emp AS de ON e.emp_no = de.emp_no AND de.dept_no = 'd001'
WHERE gender = 'M';

-- 8. use employees
-- 오늘자(년도 x) 생일자를 구하고 해당 부서의 매니저를 출력하시오
SELECT birth_date, last_name, dm.emp_no AS '매니저'
FROM employees AS e
JOIN dept_emp AS de 
ON e.emp_no = de.emp_no
JOIN dept_manager AS dm
ON de.dept_no = dm.dept_no
WHERE MONTH(CURRENT_DATE) = MONTH(birth_date)
AND DAY(CURRENT_DATE) = DAY(birth_date)
AND de.to_date = '9999-01-01';

-- 9. use employees
-- 현재 재직중인 사람중에서 직급별 평균연봉을 구하시오
SELECT title, AVG(salary) AS avg
FROM salaries AS s
JOIN dept_emp AS de
ON s.emp_no = de.emp_no AND de.to_date = '9999-01-01'
JOIN titles AS t 
ON s.emp_no = t.emp_no
GROUP BY title;

-- 10. use employees
-- 재직중인 senior engineer 의 평균연봉을 구하시오 (서브쿼리이용)
SELECT title, AVG(salary) AS avg
FROM (SELECT title, salary
		FROM salaries AS s
        JOIN titles AS t
        ON s.emp_no = t.emp_no
        WHERE title = 'Senior Engineer') AS se_salary
GROUP BY title;

SELECT * FROM departments;
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM employees;
SELECT * FROM salaries;
SELECT * FROM titles;

SELECT * FROM city;
SELECT * FROM country;
SELECT * FROM countrylanguage;