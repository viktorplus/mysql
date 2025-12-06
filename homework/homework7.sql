/*Databases 2025: Домашнее задание 7
1   Вывести названия продуктов таблица products, включая количество заказанных единиц quantity для каждого продукта таблица order_details.
Решить задачу с помощью cte и подзапроса */

USE northwind;
-- подзапрос

SELECT id, product_name, sumtable.sum_q
FROM products
LEFT JOIN (
	SELECT product_id, 
	SUM(quantity) AS sum_q
	FROM order_details
	GROUP BY product_id
) AS sumtable
ON sumtable.product_id = products.id
;

-- CTE
WITH pn AS (
	SELECT id, product_name 
	FROM products
),
suma AS (
	SELECT
	product_id,
	SUM(quantity) AS sum_q
	FROM order_details
	GROUP BY product_id
)

SELECT pn.*, suma.*
FROM pn
LEFT JOIN suma
ON pn.id = suma.product_id;

-- 2  Найти все заказы таблица orders, сделанные после даты самого первого заказа клиента Lee таблица customers.
    
SELECT *
FROM orders
WHERE order_date > (
	SELECT MIN(order_date)
	FROM customers
	JOIN orders
	ON customers.id = orders.customer_id
	WHERE last_name = 'Lee'
);

-- 3 Найти все продукты таблицы  products c максимальным target_level

SELECT * 
FROM products
WHERE target_level = (
	SELECT max(target_level)
	FROM products
);
