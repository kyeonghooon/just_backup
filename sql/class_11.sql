-- 멤버 테이블 설계
-- unique 제약 설정
create table member(
	id int primary key auto_increment,
    email varchar(50) unique,
    phone varchar(20),
    address varchar(100) not null
);
desc member;

INSERT INTO member (email, phone, address)
VALUES 
('hong@test.com', '010-1234-5678', '서울시 강남구'),
('kim@test.com', '010-2345-6789', '서울시 서초구'),
('lee@test.com', '010-3456-7890', '서울시 종로구'),
('park@test.com', '010-4567-8901', '서울시 마포구'),
('choi@test.com', '010-5678-9012', '서울시 강서구'),
('kang@test.com', '010-6789-0123', '서울시 송파구');

select * from member;

-- 1. id 2인 회원의 전화번호를 010-2222-2222로 수정하라
UPDATE member
SET phone = '010-2222-2222'
WHERE id = 2;
-- 2. id 5인 회원의 email과 주소를 'a@naver.com', '부산시 진구'로 수정
UPDATE member
SET email = 'a@naver.com', address = '부산시 진구'
WHERE id = 5;

-- 3. id 1번 회원의 email을 a@naver.com 으로 수정
UPDATE member
set email = 'a@naver.com'
where id = 1;
-- email 컬럼에 'a@naver.com' 먼저 들어가 있어서 업데이트 불가
-- unique 제약이라 중복을 허용하지 않습니다.