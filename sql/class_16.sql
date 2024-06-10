use mydb2;
-- drop table tb_student;
-- drop table tb_registration;

create table tb_student(
	no int not null primary key,
    name varchar(20) not null,
    gender enum('F','M') not null,
    grade char(1),
    foreign key(grade) references tb_grade(grade)
);

create table tb_grade(
	grade char(1) primary key,
    score int
);

desc tb_student;

-- 테이블은 정보의 최소 단위이다.

insert into tb_grade 
values 
('A', 100),
('B', 80),
('C', 60),
('D', 40),
('E', 20),
('F', 0);

select * from tb_grade;
select * from tb_student;

-- 오류 발생 아래에서 스키마 추가
-- insert into tb_student(no, name, gender, age, grade)
-- values('100', '길동', 'f', 25 ,'b');
-- 스키마 구조 변경이 필요하다
alter table tb_student add age int;

insert into tb_student(no, name, gender, age, grade)
values('100', '길동', 'f', 25 ,'b');

insert into tb_student(no, name, gender, age, grade)
values
('200', '둘리', 'm', 25 ,'b'),
('300', '마이콜', 'f', 25 ,'c'),
('400', '야스오', 'm', 15 ,'b'),
('500', '티모', 'f', 25 ,'e');

-- JOIN 연산에 ON 절 사용 안해보기 !!
-- 크로스 조인이 된다.
select*
from tb_student
join tb_grade;

select *
from tb_grade
join tb_student;

-- 조인 연산은 가능한 ON 절과 함께 사용하자.
-- JOIN --> INNER JOIN, OUTER JOIN
-- INNER JOIN --> join

-- 1 단계
select *
from tb_student
join tb_grade on tb_student.grade = tb_grade.grade;

-- 2 단계 (필요한 부분만 가져오기)
select s.no, s.name, s.grade, s.age, g.score
from tb_student as s
join tb_grade as g
on s.grade = g.grade;