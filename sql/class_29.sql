CREATE TABLE tb_products(
	product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255),
    category_id INT,
    price DECIMAL(10, 2),
    size VARCHAR(10),
    color VARCHAR(50),
    FOREIGN KEY(category_id) REFERENCES tb_categories(category_id)
);

-- 남성복 상품 입력
INSERT INTO tb_products(product_name, category_id, price, size, color)
	VALUES	('남성셔츠', 4, 49900, 'L', '퍼플'),
			('남성면바지', 7, 54900, 'M', '핑크'),
			('남성슬랙스', 8, 104900, 'XL', '샤인');
            
-- 여성복 상품 입력
INSERT INTO tb_products(product_name, category_id, price, size, color)
	VALUES	('여성셔츠', 6, 49900, 'L', '퍼플'),
			('여성면바지', 9, 54900, 'M', '핑크'),
			('여성슬랙스', 10, 104900, 'XL', '샤인');
            
SELECT * FROM tb_products;
SELECT * FROM tb_categories;

-- 특정 카테고리에 속하는 모든 상품 조회
-- 1단계 (남성, 여성 팬츠에 속하는 상품을 조회)
SELECT p.product_name, p.price, p.size, p.color
FROM tb_products p
JOIN tb_categories c ON p.category_id = c.category_id
WHERE c.category_name = '면바지';

-- 2단계 (만약 여성 면바지만 출력 해야 된다면)
-- 조인 --> 서브쿼리
SELECT p.product_name, p.price, p.size, p.color, c.parent_id
FROM tb_products p
JOIN tb_categories c ON p.category_id = c.category_id
WHERE c.category_name = '면바지' AND c.parent_id = 5;

-- ------------------------------------
SELECT p.product_name, p.price, p.size, p.color, c.parent_id
FROM tb_products p
JOIN tb_categories c ON p.category_id = c.category_id
WHERE c.category_name = '면바지' AND c.parent_id = (
	SELECT category_id
    FROM tb_categories
    WHERE category_name = '팬츠'
    AND parent_id = 2
);

-- 문제 1 남성복 셔츠만 출력하시오
SELECT p.product_name, p.price, p.size, p.color, c.parent_id
FROM tb_products p
JOIN tb_categories c ON p.category_id = c.category_id
WHERE c.category_name = '셔츠' AND c.parent_id = (
	SELECT category_id
    FROM tb_categories
    WHERE category_name = '남성복'
);
-- 문제 2 여성복 슬랙스만 출력하시오
SELECT p.product_name, p.price, p.size, p.color, c.parent_id
FROM tb_products p
JOIN tb_categories c ON p.category_id = c.category_id
WHERE c.category_name = '슬랙스' AND c.parent_id = (
	SELECT category_id
    FROM tb_categories
    WHERE category_name = '팬츠'
    AND parent_id = 2
);

-- 특정 색상의 상품이 있는 모든 카테고리 조회 (서브쿼리 사용할 필요 없음)
-- 예를 들어, '흰색' 상품이 있는 모든 카테고리를 조회하는 쿼리입니다.
SELECT c.*
FROM tb_products AS p
JOIN tb_categories AS c ON p.category_id = c.category_id
WHERE color = '샤인';

-- 가장 비싼 상품을 가진 카테고리 찾기 (서브쿼리 사용할 필요 없음)
-- 각 카테고리 중 가장 비싼 상품을 가지고 있는 카테고리와 그 상품의 정보를 조회하는 쿼리입니다.
SELECT *
FROM tb_products AS p
JOIN tb_categories AS c ON p.category_id = c.category_id
ORDER BY price DESC
LIMIT 1;