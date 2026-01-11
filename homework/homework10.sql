-- Databases 2025: Домашнее задание 10
-- Таблица order_details
-- 1 Для каждого product_id выведите inventory_id, а также предыдущий и последующей inventory_id по убыванию quantity
SELECT * FROM northwind.order_details;
SELECT product_id, inventory_id, 
	LAG (inventory_id) OVER (ORDER BY quantity DESC) AS lage,
	LEAD (inventory_id) OVER (ORDER BY quantity DESC) AS leade
FROM order_details;
    
-- 2 Выведите максимальный и минимальный unit_price для каждого order_id с помощью функции FIRST VALUE.
--  Вывести order_id и полученные значения

SELECT DISTINCT order_id,
FIRST_VALUE (unit_price) OVER (PARTITION BY order_id ORDER BY unit_price) AS min,
FIRST_VALUE (unit_price) OVER (PARTITION BY order_id ORDER BY unit_price DESC) AS max
FROM order_details;

-- 3 Выведите order_id и столбец с разницей между  unit_price для каждого заказа и минимальным unit_price
--  в рамках одного заказа. Задачу решить двумя способами - с помощью First VAlue и MIN

SELECT order_id, 
	unit_price - FIRST_VALUE(unit_price) OVER (PARTITION BY order_id ORDER BY unit_price) AS diff
FROM order_details;

SELECT order_id, 
	unit_price - MIN(unit_price) OVER (PARTITION BY order_id ORDER BY unit_price) AS diff
FROM order_details;

-- 4 Присвойте ранг каждой строке используя RANK по убыванию quantity

SELECT  *,
	RANK () OVER (ORDER BY quantity DESC) AS rank_quantity
FROM order_details;

-- 5  Из предыдущего запроса выберите только строки с рангом до 10 включительно

SELECT *
FROM (
	SELECT  
		*,
		RANK () OVER (ORDER BY quantity DESC) AS rank_quantity 
	FROM order_details) AS t
WHERE rank_quantity <= 10;