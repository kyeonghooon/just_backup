create database mydb;

use mydb;

-- 테이블 생성
create table student(
	student_id int,
    name varchar(50) not null,
    grade int not null,
    major varchar(50) not null
);

select * from student;
desc student;

-- 과목 테이블 생성
create table subject(
	subject_id int,
    subject_name varchar(50) not null,
    credit int not null,
    department varchar(50),
    professor char(50) not null
);

SELECT * FROM subject;

-- 이미 생성된 테이블에 기본키를 추가하는 방법
ALTER TABLE student ADD PRIMARY KEY(student_id);
DESC student;
-- 사전 기반 지식 (데이터가 들어가 있는 상태에서 빈 값이 포함되어 있다면
-- 기본키를 추가할 수 없다.) 즉 NULL 값이 있어서는 안됨

alter table subject add primary key(subject_id);
desc subject;



-- 주문
-- order
-- row --> id : pk
-- 고객 주문 내용 - 문자
-- 상품 이름
-- 상품 가격
-- 수량

-- 예약어는 기본적으로 테이블 이름으로 사용할 수 없다.
-- 하지만 강제적으로 ``를 사용해서 테이블 이름이라고 명시할 수 있다.
create table `order`(
	id int primary key,
    price bigint,
    customer_order varchar(50),
    product_name varchar(20) not null,
    quantity int not null,
    order_data date not null 
);

desc `order`;
-- 도전 과제 : 위 형식에 맞는 insert 를 진행하세요
insert into `order` (id, price, customer_order, product_name, quantity, order_data)
values (1, 5500, 'or123', '유가네 닭갈비 볶음밥', 2, '2024-05-30');

-- delete from `order`;

select * from `order`;

create table employee(
	id int primary key,
	name varchar(50) not null,
    age int,
    department varchar(50) not null
);

create table customer(
	id int primary key,
    name varchar(50) not null,
    email varchar(50),
    address varchar(100) not null
);
desc customer;
