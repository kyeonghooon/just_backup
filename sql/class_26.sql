create database m_board;
use m_board;

CREATE TABLE user (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL,
    userRole VARCHAR(20),
    createDate TIMESTAMP
);

-- board table, reply table

CREATE TABLE board (
    id INT PRIMARY KEY AUTO_INCREMENT,
    userId INT,
    title VARCHAR(100) NOT NULL,
    content TEXT,
    readCount INT,
    FOREIGN KEY (userId)
        REFERENCES user (id)
);

CREATE TABLE reply (
    id INT PRIMARY KEY AUTO_INCREMENT,
    userId INT,
    boardId INT,
    content VARCHAR(300) NOT NULL,
    createDate TIMESTAMP,
    FOREIGN KEY (userId)
        REFERENCES user (id)
        ON DELETE SET NULL,
    FOREIGN KEY (boardId)
        REFERENCES board (id)
);

-- 스키마 구조를 변경하는 쿼리 --- DDL, DML, DCL
-- user 테이블에 address 컬럼을 추가해라
alter TABLE user add address varchar(100) not null;

INSERT INTO user (username, password, email, address, userRole, createDate)
VALUES
('홍길동', '1234', 'hong@example.com', '서울시 강남구', 'admin', NOW()),
('이순신', '1234', 'lee@example.com', '부산시 해운대구', 'user', NOW()),
('김유신', '1234', 'kim@example.com', '대구시 수성구', 'user', NOW());

INSERT INTO board (userId, title, content, readCount)
VALUES
(1, '첫 번째 글입니다', '안녕하세요, 홍길동입니다. 이것은 테스트 게시글입니다.', 150),
(2, '이순신의 포스팅', '부산에서 이순신입니다. 바다가 아름다운 날입니다.', 45),
(3, '대구의 뜨거운 여름', '여름이 기승을 부리는 대구에서 김유신입니다.', 30);

INSERT INTO reply (userId, boardId, content, createDate)
VALUES
(2, 1, '홍길동님의 글 잘 읽었습니다!', NOW()),
(3, 1, '저도 의견이 같네요.', NOW()),
(1, 2, '부산도 좋지만 서울도 좋아요!', NOW()),
(1, 3, '대구가 그렇게 덥군요, 조심하세요!', NOW());

-- 특정 사용자의 게시글 조회 (사용자 ID가 1인 홍길동의 모든 게시글을 보고 싶다면
SELECT title, content, readCount
FROM board
WHERE userId = 1;

-- 1번 게시글에 대한 모든 댓글 조회
SELECT username, content, r.createDate
FROM reply r
LEFT JOIN user u ON r.userId = u.id
WHERE r.boardId = 1;

-- 게시글에 댓글 달기
-- 예를 들어, 사용자 ID 2가 게시글 ID 1에
-- "새로운 댓글입니다"라는 내용의 댓글을 추가하려면 다음 쿼리를 사용합니다.
INSERT INTO reply(userId, boardId, content, createDate)
VALUES (2, 1, "새로운 댓글입니다", now());

-- 특정 사용자의 게시글에 해당하는 게시글의 댓글 수 조회
-- 제목, 내용, 작성자 이름, 댓글 수
SELECT b.title, b.content, u.username, count(*) as 댓글수
FROM board b
LEFT JOIN reply r ON b.id = r.boardId
JOIN user u ON r.userId = u.id
GROUP BY b.id;

-- 조회수가 가장 높은 게시글 상위 2개만 조회
SELECT *
FROM board
ORDER BY readCount DESC
LIMIT 2;