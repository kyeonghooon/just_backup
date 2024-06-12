-- 1. 현재 까지 지출한 직급별 평균 연봉의 합산
select sum(x.avg) as sum
from (
	select avg(salary) as avg
	from salaries as s
	join titles as t on s.emp_no = t.emp_no
	group by title
) as x;