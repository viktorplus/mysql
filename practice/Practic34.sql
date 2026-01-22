/*
Создайте таблицу products с колонками id (INT) и product_name (VARCHAR), price.
Вставьте несколько записей в таблицу.
Создайте хранимую процедуру с IN-параметром для поиска имени товара по его идентификатору.
Вызовите эту процедуру и проверьте результат.*/

CREATE TABLE products
(
	id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
	price INT
);

INSERT INTO products (product_name, price) 
VALUES
	('Laptop', 1200),
	('Smartphone', 800),
	('Tablet', 450),
	('Headphones', 150),
	('Keyboard', 90),
	('Mouse', 60),
	('Monitor', 300),
	('Printer', 250),
	('Webcam', 110),
	('External SSD', 180);


DELIMITER //
CREATE PROCEDURE get_by_id(
	IN product_id INT 
)
BEGIN
	SELECT product_name
    FROM products
    WHERE id = product_id;

END //

DELIMITER ;

CALL get_by_id(3);