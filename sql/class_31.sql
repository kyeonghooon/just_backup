USE demo3;

-- 복합키 생성 방법 확인
CREATE TABLE 수강정보_수정전(
	학생ID INT,
    과목코드 VARCHAR(10),
    과목명 VARCHAR(10),
    담당교수 VARCHAR(10),
    PRIMARY KEY(학생ID, 과목코드)
);

DESC 수강정보;

-- 수강 정보 테이블 만들기
create table 수강정보(
	학생ID INT,
    과목코드 VARCHAR(10),
    FOREIGN KEY(과목코드) REFERENCES 과목정보(과목코드)
);

-- 과목 정보 테이블 만들기
create table 과목정보(
	과목코드 VARCHAR(10),
    과목명 VARCHAR(10),
    담당교수 VARCHAR(10)
);