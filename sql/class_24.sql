create database b_demo1;
use b_demo1;

CREATE TABLE 직원 (
    직원ID INT AUTO_INCREMENT PRIMARY KEY,
    직원이름 VARCHAR(100) NOT NULL,
    부서 VARCHAR(30) NOT NULL,
    지역 VARCHAR(10) NOT NULL
);


INSERT INTO 직원 (직원ID, 직원이름, 부서, 지역) VALUES
(1000, '김철수', '영업', '부산'),
(1001, '박영희', '마케팅', '부산'),
(1002, '이민지', '인사', '서울'),
(1003, '최민수', '디자인', '서울'),
(1004, '야스오', '디자인', '서울');

select * from 직원;

-- 이상현상을 방지하고자 테이블을 분리해 보자.
CREATE TABLE tb_departments (
    부서ID INT AUTO_INCREMENT PRIMARY KEY,
    부서명 VARCHAR(30) NOT NULL,
    지역 VARCHAR(10) NOT NULL
);

CREATE TABLE tb_employees (
    직원ID INT AUTO_INCREMENT PRIMARY KEY,
    직원이름 VARCHAR(100) NOT NULL,
    부서ID INT,
    FOREIGN KEY (부서ID)
        REFERENCES tb_departments (부서ID)
);

INSERT INTO tb_departments (부서명, 지역) VALUES
('영업', '부산'),
('마케팅', '부산'),
('인사', '서울'),
('디자인', '서울');

INSERT INTO tb_employees (직원이름, 부서ID) VALUES
('김철수', 1),
('박영희', 2),
('이민지', 3),
('최민수', 4),
('야스오', 4);

select * from tb_departments;
select * from tb_employees;

-- 직원의 정보와 부서가 있다면 부서명을 함께 출력
-- inner, outer 중에 어떤 녀석을 선택해야 할까?
SELECT e.*, 부서명
FROM tb_employees AS e
LEFT JOIN tb_departments AS d 
ON e.부서ID = d.부서ID;

-- 마게팅 부서의 이름을 HR로 수정
UPDATE tb_departments 
SET 부서명 = 'HR'
WHERE 부서명 = '마케팅';