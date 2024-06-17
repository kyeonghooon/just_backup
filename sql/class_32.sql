USE demo3;
SELECT * FROM users;

DESC users;

INSERT INTO users(name, email) VALUES('admin', 'admin@naver.com');

SHOW PROCESSLIST;

-- DML DCL DDL
-- 컬럼 추가하는 쿼리를 만들어 보자.

DROP TABLE users;

CREATE TABLE users(
	id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL
);
DESC users;

ALTER TABLE users ADD COLUMN email VARCHAR(100) NULL;

-- 이메일에다가 unique 제약을 추가해보자.
ALTER TABLE users ADD CONSTRAINT unique_email UNIQUE(email);

SELECT * FROM users;

INSERT INTO users(username, password, email)
VALUES	('홍길동', 'asd123', 'a@naver.com'),
		('이순신', 'asd123', 'b@naver.com'),
		('박태환', 'asd123', 'c@naver.com');

SELECT * FROM users WHERE username = '홍길동' AND password = 'asd123';