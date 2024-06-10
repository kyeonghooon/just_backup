-- 사용자 생성하기 (비밀번호 함께 설정)

-- 사용자 계정 생성은 (원격지, 로컬 환경)이 있다.

-- 원격지에서 접근하는 사용자 계정 생성
-- 루트 권한을 제외하고 비밀번호 설정에 대한 제약이 있을 수 있다.
create user 'tenco1'@'%' identified by '1q2w3e4r5t!';

-- localhost 에서 접근 가능한 계정 생성
create user 'tenco1'@'localhost' identified by '1q2w3e4r5t!';


-- 사용자 계정 권한 확인
show grants for 'tenco1'@'%';
show grants for 'tenco1'@'localhost';

-- 작업별 권한을 할당
-- grant select, insert, update, delete on mydb2.* to 'tenco1'@'%'; 
grant select, update, delete on mydb2.* to 'tenco1'@'%';
grant select, update, delete on mydb2.* to 'tenco1'@'localhost';

-- root 권한으로 새로운 사용자 생성 및 권한 할당
-- 권한 바로 적용하기(세션 종료 후에 재접속하면 적용됨)
flush privileges;

select * from tb_student;

-- 문제 1 : 새로운 계정 tenco2 생성(단순 연습)하고 각 조장이 사용하고 있는
-- RDBMS에 tenco2라는 계정으로 접근

create user 'tenco2'@'%' identified by '1q2w3e4r5t!';


