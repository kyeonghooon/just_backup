
-- 데이터 베이스 생성
CREATE DATABASE shopdb;

-- 데이터 베이스 사용 선언
USE shopdb;

-- 주석(한줄 주석)

/*
	여러줄 주석
*/

-- 테이블 생성
create table tb_member(
	memberID char(8) not null primary key,
    memberName char(5) not null,
    memberAddress char(20)
);

-- 테이블 구조 확인 명령어
desc tb_member;

-- 테이블 조회 명령어(DML - Data Manipulation Language) : 데이터 조작 언어
select * from tb_member;
select memberID, memberName from tb_member;

-- 혹시나 테이블을 잘못 만들었다면 테이블 제거 명령어를 배워보자
-- drop, update, delete 명령어는 주석해두는 습관을 가지자 !!
-- drop table tb_member;

-- C R U D

-- 데이터를 입력하는 SQL ( insert )
-- insert into tb_member() values (); - 기본 형태
insert into tb_member(memberID, memberName, memberAddress)
values ('M000001', '홍길동', '서울특별시강남구역삼동123-456');

select * from tb_member;

insert into tb_member(memberID, memberName, memberAddress)
values ('M000002', '김철수', '서울특별시송파구잠실동789-123');
insert into tb_member(memberID, memberName, memberAddress)
values ('M000003', '이영희', '부산광역시수영구광안동456-789');

select * from tb_member where memberName = '홍길동';
select * from tb_member where memberAddress LIKE '서울특별시%';
