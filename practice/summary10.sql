-- 5. Выберите ТОП 5 продуктов с максимальным quantity, используя DENSE RANK.

with t as
(select distinct product_id, quantity,
DENSE_RANK() over (order by quantity desc) as max_q
from northwind.purchase_order_details)
select product_id, quantity, max_q from t
where max_q <= 5
;

select purchase_order_id, product_id, quantity,
DENSE_RANK() over (order by quantity desc) as max_q
from northwind.purchase_order_details;

select product_id, sum(quantity),
DENSE_RANK() over (order by sum(quantity) desc) as max_q
from northwind.purchase_order_details
GROUP BY product_id;

--
WITH new_t AS 
	(SELECT 
		*, 
		DENSE_RANK() over (order by sum_q desc) as rank_q
	FROM 
		(select product_id, sum(quantity) as sum_q
		from northwind.purchase_order_details
		GROUP BY product_id) as t)
SELECT * FROM new_t
where rank_q <= 5
;

--
SELECT * FROM
	(SELECT 
		*, 
		DENSE_RANK() over (order by sum_q desc) as rank_q
	FROM 
		(select product_id, sum(quantity) as sum_q
		from northwind.purchase_order_details
		GROUP BY product_id) as t) AS new_t
where rank_q <= 5
;
--
WITH t1 AS 
	(select product_id, sum(quantity) as sum_q
	from northwind.purchase_order_details
	GROUP BY product_id),
t2 AS
	(SELECT *, 
		DENSE_RANK() over (order by sum_q desc) as rank_q
	FROM t1
	)
SELECT * FROM t2
where rank_q <= 5;
    
    
-- -------------------------------------------------
-- Пронумеруйте строки в соответствии с убывание inventory_id. 
-- Выведите только 13 строчку.
-- purchase_order_details

SELECT * FROM northwind.purchase_order_details;

SELECT *, 
	ROW_NUMBER() OVER (ORDER BY inventory_id DESC)
FROM purchase_order_details;

WITH t AS
	(SELECT *, 
		ROW_NUMBER() OVER (ORDER BY inventory_id DESC) AS row_num
	FROM purchase_order_details) 
SELECT * FROM t
WHERE row_num = 13;

SELECT * 
FROM purchase_order_details
ORDER BY inventory_id DESC
LIMIT 1
OFFSET 12;

SELECT * 
FROM purchase_order_details
ORDER BY inventory_id DESC
LIMIT 12, 1;
