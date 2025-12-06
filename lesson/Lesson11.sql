USE 101025_viktor;
-- CREATE VIEW Employees AS
-- SELECT * FROM Employees;

-- SELECT * FROM 101025_viktor.Employees;

-- CREATE VIEW employees_view AS
-- SELECT * FROM Employees;

-- CREATE VIEW employees_name_view AS
-- SELECT FirstName, LastName FROM Employees;

-- CREATE VIEW employees_tax_view AS
-- SELECT EmployeeID, FirstName, LastName, Salary, Salary * 0.4 as Tax, Salary * 1.4 as Total FROM Employees;

-- INSERT INTO Employees (FirstName, LastName, BirthDate, Salary, Email)
-- VALUES ('Edward', 'Black', '1987-09-30', 61000.00, 'edward.black@example.com');

-- INSERT INTO Employees (FirstName, LastName, BirthDate, Salary, Email)
-- VALUES ('Bob', 'Black', '1997-09-30', 61000.00, 'bob.black@example.com');

-- SELECT FirstName, LastName, Salary, Tax, Total FROM employees_tax_view;

/*
1. Создайте таблицу products со следующими столбцами и ограничениями:
● product_id — тип INT, автоинкремент, первичный ключ.
● product_name — тип VARCHAR100, не может быть пустым.
● category — тип VARCHAR50, значение по умолчанию — 'General'.
● price — тип DECIMAL8, 2, не может быть отрицательным, добавьте ограничение CHECK (price >= 0.
● stock_quantity — тип INT, не может быть отрицательным.
● supplier_id — тип INT, может быть NULL, указывает на поставщика продукта.
2. Заполните таблицу products 5 строками данных.
3. Измените значение в таблице, например, уменьшите количество на складе для продукта с product_id = 1
*/

CREATE TABLE IF NOT EXISTS products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) DEFAULT 'General',
    price DECIMAL(8,2) NOT NULL CHECK (price >= 0),
    stock_quantity INT NOT NULL CHECK (stock_quantity >= 0),
    supplier_id INT
);

INSERT INTO products (product_name, category, price, stock_quantity, supplier_id)
VALUES
('Laptop', 'Electronics', 1200.00, 10, 1),
('Smartphone', 'Electronics', 800.00, 5, 2),
('Desk Chair', 'Furniture', 150.00, 20, NULL),
('Notebook', 'Office', 2.50, 100, NULL),
('Headphones', 99.99, 15, 3);

INSERT INTO products (product_name, category, price, stock_quantity, supplier_id)
VALUES
('Headphones2', DEFAULT, 99.99, 15, 3);


UPDATE products
SET stock_quantity = stock_quantity -1
WHERE produduct_id = 1;

SET SQL_SAFE_UPDATES = 0;

UPDATE products
SET price = round(price * 1.15, 2);

SET SQL_SAFE_UPDATES = 0;

/*
4. Создайте представление product_overview, которое будет содержать следующие данные:
● product_name — название продукта.
● category — категория продукта.
● stock_value — расчетная стоимость запасов (произведение price и stock_quantity).
● stock_status — строка "Low Stock", если stock_quantity меньше 20, и "In Stock" в противном случае.
*/

CREATE OR REPLACE VIEW product_overview AS
SELECT 
    product_name,
    category,
    (price * stock_quantity) AS stock_value,
--     CASE
--         WHEN stock_quantity < 20 THEN 'Low Stock'
--         ELSE 'In Stock'
--     END AS stock_status
	IF (stock_quantity < 20, 'Low Stock', 'In Stock') AS stock_status
FROM products;

SELECT * FROM product_overview;

SELECT * FROM products;








  /* 5. Вам необходима таблица с данными о мониторинге основных показателей здоровья. Подумайте какие
столбцы и с какими ограничениями вы будете использовать. Создайте такую таблицу и заполните ее тремя
тестовыми строками. Обсудите результаты с коллегами.
*/  



CREATE TABLE IF NOT EXISTS health_monitoring (
    record_id INT PRIMARY KEY AUTO_INCREMENT,
    measurement_time DATETIME NOT NULL,
    
    heart_rate INT NOT NULL CHECK (heart_rate BETWEEN 30 AND 220),
    blood_pressure_systolic INT NOT NULL CHECK (blood_pressure_systolic BETWEEN 50 AND 250),
    blood_pressure_diastolic INT NOT NULL CHECK (blood_pressure_diastolic BETWEEN 30 AND 150),
    
    temperature DECIMAL(4,1) NOT NULL CHECK (temperature BETWEEN 34.0 AND 43.0),
    
    notes VARCHAR(255)
);

INSERT INTO health_monitoring (
    measurement_time, heart_rate, blood_pressure_systolic, blood_pressure_diastolic, temperature, notes
)
VALUES
('2025-01-10 08:30:00', 72, 120, 80, 36.8, 'Normal morning measurement'),
('2025-01-10 18:00:00', 88, 135, 90, 37.2, 'After light exercise'),
('2025-01-11 07:45:00', 95, 145, 95, 38.5, 'Feeling unwell, possible fever');


