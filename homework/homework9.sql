-- Таблица purchase_order_details
SELECT * FROM northwind.purchase_order_details;

-- 1. Для каждого заказа order_id выведите минимальный, максмальный и средний unit_cost

SELECT purchase_order_id, 
	MIN(unit_cost) OVER(PARTITION BY purchase_order_id) AS min_unit_cost,
    MAX(unit_cost) OVER (PARTITION BY purchase_order_id) AS max_unit_cost,
    AVG(unit_cost) OVER (PARTITION BY purchase_order_id) AS avg_unit_cost
FROM purchase_order_details
;

-- 2.  Оставьте только уникальные строки из предыдущего запроса

SELECT DISTINCT purchase_order_id, 
	MIN(unit_cost) OVER(PARTITION BY purchase_order_id) AS min_unit_cost,
    MAX(unit_cost) OVER (PARTITION BY purchase_order_id) AS max_unit_cost,
    AVG(unit_cost) OVER (PARTITION BY purchase_order_id) AS avg_unit_cost
FROM purchase_order_details
;

-- 3. Посчитайте стоимость продукта в заказе как quantity*unit_cost 
-- Выведите суммарную стоимость продуктов с помощью оконной функции Сделайте то же самое с помощью GROUP BY

SELECT purchase_order_id,
product_id,
quantity*unit_cost AS sum_cost_product_id,
SUM(quantity*unit_cost) OVER (PARTITION BY purchase_order_id) AS summ_order_id
FROM purchase_order_details
ORDER BY purchase_order_id, product_id
;

SELECT table1.purchase_order_id,
product_id,
quantity*unit_cost AS sum_cost_product_id,
table1.summ_order_id
FROM purchase_order_details
JOIN (
SELECT purchase_order_id, SUM(quantity*unit_cost) AS summ_order_id
FROM purchase_order_details
GROUP BY purchase_order_id
)AS table1
USING (purchase_order_id)
ORDER BY purchase_order_id, product_id;

-- 4. Посчитайте количество заказов по дате получения и posted_to_inventory Если оно превышает 1 то выведите '>1' в противном случае '=1'
-- Выведите purchase_order_id, date_received и вычисленный столбец
SELECT DISTINCT purchase_order_id, date_received,
CASE 
WHEN  COUNT(purchase_order_id) OVER (PARTITION BY date_received, posted_to_inventory) > 1 THEN '>1'
ELSE '=1'
END AS count_order
FROM purchase_order_details;

