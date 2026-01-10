-- 1 Для каждого product_id выведите inventory_id, а также предыдущий и последующей inventory_id 
-- по убыванию quantity
SELECT 
	product_id, inventory_id, 
	LEAD(inventory_id) OVER (partition by product_id order by quantity desc),
	LAG(inventory_id) OVER (partition by product_id order by quantity desc)
FROM order_details;


-- 2 Выведите максимальный и минимальный unit_price для каждого order_id с помощью функции FIRST VALUE.  
-- Вывести order_id и полученные значения
SELECT 
	order_id, 
	FIRST_VALUE(unit_price) OVER (partition by order_id ORDER BY unit_price) as min_,
	FIRST_VALUE(unit_price) OVER (partition by order_id ORDER BY unit_price DESC) as max_,
	last_value(unit_price) 
		over(PARTITION BY order_id order by unit_price asc 
			ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as max_2,
	last_value(unit_price) 
		over(PARTITION BY order_id order by unit_price desc 
			ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as min_2
FROM order_details;


-- 3 Выведите order_id и столбец с разницей между  unit_price для каждого заказа 
-- и минимальным unit_price в рамках одного заказа. 
-- Задачу решить двумя способами - с помощью First VAlue и MIN
SELECT 
	order_id, unit_price,
	unit_price - FIRST_VALUE(unit_price) OVER (partition by order_id ORDER BY unit_price) as diff_min_1,
	unit_price - MIN(unit_price) OVER (partition by order_id) as diff_min_2
FROM order_details;

-- 4 Присвойте ранг каждой строке используя RANK по убыванию quantity
SELECT *, RANK() OVER (order by quantity desc) as rn_
FROM order_details;

-- 5  Из предыдущего запроса выберите только строки с рангом до 10 включительно
SELECT *
FROM
	(SELECT *, RANK() OVER (order by quantity desc) as rn_
	FROM order_details) as a
WHERE rn_ <= 10;


