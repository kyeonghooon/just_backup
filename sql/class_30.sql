-- 사전 데이터 확인
SELECT *
FROM employees;

SELECT *
FROM dept_manager
WHERE to_date = '9999-01-01';

-- 직원 테이블에서 매니저인 사원을 출력 하자. !!
SELECT *
FROM employees
WHERE emp_no IN (
		SELECT emp_no
		FROM dept_manager
		WHERE to_date = '9999-01-01');
        
-- FROM 절에 사용하는 인라인 뷰
-- 현재 다니고 있는 매니저들의 평균 연봉 구하기.

SELECT * FROM dept_manager WHERE to_date = '9999-01-01';
SELECT * FROM salaries WHERE emp_no = 10001;

-- 한 직원의 평균 연봉, emp_no 그룹바이 처리
SELECT emp_no, AVG(salary) AS 평균연봉
FROM salaries AS s
GROUP BY emp_no;

-- 인라인뷰를 사용했던 개념
SELECT emp_no, 평균연봉
FROM (SELECT emp_no, AVG(salary) AS 평균연봉
		FROM salaries AS s
		GROUP BY emp_no) AS avg_salary
WHERE emp_no = '10001';

-- 인라인 뷰, 중첩 서브쿼리를 동시에 사용
SELECT emp_no, 평균연봉
FROM (SELECT emp_no, AVG(salary) AS 평균연봉
		FROM salaries AS s
		GROUP BY emp_no) AS avg_salary
WHERE emp_no IN (SELECT emp_no
					FROM dept_manager
					WHERE to_date = '9999-01-01');
                    
-- 23847.66 비용 발생

-- 위와 같은 결과 집합을 INNER JOIN 을 활용해서 똑같이 만들어라
SELECT s.emp_no, AVG(salary) AS 평균연봉
FROM salaries AS s
JOIN dept_manager AS dm ON s.emp_no = dm.emp_no 
	AND dm.to_date = '9999-01-01'
GROUP BY emp_no;

-- 각 직원의 평균 연봉 구하기
SELECT emp_no AS outer_emp_no, (SELECT AVG(salary)
									FROM salaries
                                    WHERE emp_no = outer_emp_no) AS 평균연봉
FROM employees