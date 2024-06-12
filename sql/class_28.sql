CREATE DATABASE demo3;
USE demo3;

-- 카테고리 테이블 (상위, 하위 개념 추가)
CREATE TABLE tb_categories(
	category_id INT AUTO_INCREMENT PRIMARY KEY,
    parent_id INT NULL,
    category_name VARCHAR(100),
    FOREIGN KEY(parent_id) REFERENCES tb_categories(category_id)
);

DESC tb_categories;

INSERT INTO tb_categories(category_name) VALUES('남성복');
INSERT INTO tb_categories(category_name) VALUES('여성복');

SELECT * FROM tb_categories;

-- 남성복의 하위 카테고리
INSERT INTO tb_categories(parent_id, category_name)
	VALUES(1, '팬츠');
INSERT INTO tb_categories(parent_id, category_name)
	VALUES(1, '셔츠');
    
-- 여성복의 하위 카테고리
INSERT INTO tb_categories(parent_id, category_name)
	VALUES(2, '팬츠');
INSERT INTO tb_categories(parent_id, category_name)
	VALUES(2, '셔츠');
    
-- 남성복 팬츠의 하위 카테고리
INSERT INTO tb_categories(parent_id, category_name)
	VALUES(3, '면바지');
INSERT INTO tb_categories(parent_id, category_name)
	VALUES(3, '슬랙스');
    
-- 여성복 팬츠의 하위 카테고리
INSERT INTO tb_categories(parent_id, category_name)
	VALUES(5, '면바지');
INSERT INTO tb_categories(parent_id, category_name)
	VALUES(5, '슬랙스');