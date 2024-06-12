
CREATE TABLE tb_categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

INSERT INTO tb_categories(category_name) VALUES('상의');
INSERT INTO tb_categories(category_name) VALUES('하의');
INSERT INTO tb_categories(category_name) VALUES('외투');

CREATE TABLE tb_products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255),
    category_id INT,
    price DECIMAL(10 , 2 ),
    size ENUM('S', 'M', 'L', 'XL'),
    color VARCHAR(50),
    FOREIGN KEY (category_id)
        REFERENCES tb_categories (category_id)
);

SELECT * FROM tb_categories;

INSERT INTO tb_products(product_name, category_id, price, size, color)
VALUES('티셔츠', 1, 19900, 'M', '흰색');

INSERT INTO tb_products(product_name, category_id, price, size, color)
VALUES('청바지', 2, 49900, 'L', '청색');

INSERT INTO tb_products(product_name, category_id, price, size, color)
VALUES('자켓', 3, 99900, 'L', '검정색');

INSERT INTO tb_products(product_name, category_id, price, size, color)
VALUES('셔츠', 1, 29900, 'S', '보라색');

SELECT * FROM tb_products;

-- 특정 카테고리에 속하는 모든 상품을 조회하는 쿼리
SELECT p.product_name, p.price, p.size, p.color
FROM tb_products p
JOIN tb_categories c ON p.category_id = c.category_id
WHERE c.category_name = '상의';