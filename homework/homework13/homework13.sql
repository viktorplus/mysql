-- Databases 2025: Домашнее задание 13
-- 1 Выберите только те строки из таблицы suppliers, где company имеет значение Supplier A

USE northwind;
SELECT * 
FROM suppliers s
WHERE s.company = "Supplier A"

-- 2 Вывести все строки там, где purchase_order_id не указано. 
-- При этом дополнительно создать столбец total_price как произведение quantity * unit_price

SELECT *, quantity * unit_price total_price 
FROM order_details
WHERE purchase_order_id IS NULL

-- 3 Выведите какая дата будет через 51 день
SELECT DATE_ADD(CURDATE(), INTERVAL 51 DAY) AS date_in_51_days;

-- 4  Посчитайте количество уникальных заказов purchase_order_id
SELECT COUNT(DISTINCT purchase_order_id)
FROM order_details

-- 5 Выведите все столбцы таблицы order_details, а также дополнительный столбец payment_method 
-- из таблицы purchase_orders. Оставьте только заказы для которых известен payment_method

SELECT order_details.*,  purchase_orders.payment_method
FROM order_details
LEFT JOIN purchase_orders
ON order_details.purchase_order_id = purchase_orders.id
WHERE purchase_orders.payment_method IS NOT NULL
