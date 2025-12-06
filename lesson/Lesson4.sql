-- Составьте запрос чтобы: вывести имя продукта из таблицы products и его категорию.

-- standard_cost > 20 - 'Expensive'. 
-- В обратном случае - 'Affordable' с применением оператора IF.

-- SELECT * FROM northwind.products ;
-- SELECT product_name, standard_cost, IF(standard_cost > 20,'Expensive','Affordable') FROM products ;


-- use northwind ; 
-- SELECT * FROM northwind.products ;
-- select  product_name, standard_cost ,
-- 	Case 
-- 		When standard_cost > 50 
--         then "Дорогой"
--         When standard_cost > 20  and standard_cost <= 50 
--         then "Средний"
--         When standard_cost <= 20 
--         then "Дешевый"
--         End
-- 	    as price_type 
--         from products ;

-- SELECT product_name, standard_cost, 
-- 	IF(standard_cost > 50,'Expensive', 
-- 		IF(standard_cost < 20, "Cheap", 'Affordable')) FROM products ;

-- SELECT 
-- 	company,
-- 	RIGHT (company, 2) AS ShortName
-- FROM customers;

-- SELECT 
-- business_phone , SUBSTRING(business_phone, 6, 3)
-- FROM customers;

-- SELECT 
-- product_name , SUBSTRING(product_name, 19)
-- FROM products;

-- SELECT * FROM employees;
-- SELECT last_name AS LN, first_name AS FN, concat(last_name, " ", first_name) AS full_name FROM employees;
-- SELECT 
-- 	last_name, first_name, 
-- 	concat(last_name, " - ", first_name, " - ", email_address) AS full_name 
-- FROM employees;
-- SELECT 
-- 	last_name, first_name, 
-- 	concat_ws(" - ", last_name, first_name, email_address) AS full_name 
-- FROM employees;

-- SELECT product_name, LENGTH(product_name) AS name_length FROM products;

-- SELECT product_name, REPLACE(product_name, 'Olive Oil', 'Oil') AS new_name FROM products;

-- SELECT UPPER('sql функции'), 'hello';
-- SELECT product_name, UPPER(product_name) AS new_name FROM products;

-- SELECT * 
-- FROM northwind.products;

-- SELECT * 
-- FROM northwind.products
-- order by standard_cost desc, product_name;

-- SELECT * 
-- FROM northwind.products
-- order by category, standard_cost desc;

-- SELECT * 
-- FROM northwind.products
-- where standard_cost > 8
-- order by target_level, standard_cost desc, product_name desc;

-- SELECT * 
-- FROM northwind.products;

-- SELECT * 
-- FROM northwind.products
-- order by standard_cost desc, product_name;

-- SELECT * 
-- FROM northwind.products
-- order by category, standard_cost desc;

-- SELECT * 
-- FROM northwind.products
-- where standard_cost > 8
-- order by target_level, standard_cost desc, product_name desc;

-- SELECT * 
-- FROM northwind.products
-- ORDER BY product_name asc
-- LIMIT 10 OFFSET 20;

-- ----------------
-- SELECT * FROM northwind.products;
-- SELECT category FROM northwind.products;
-- SELECT DISTINCT category FROM northwind.products order by category;


-- SELECT category, minimum_reorder_quantity FROM northwind.products;
-- SELECT DISTINCT category, minimum_reorder_quantity FROM northwind.products order by category;