-- 2. Выберите только тех сотрудников из таблицы, имя которых содержит английскую букву 'e' или
--  их job_title = Sales Representative. Из заказов orders выберите заказы в которых город отправки ship_city = Las Vegas. 
-- Проверьте, отправляли ли найденные сотрудники заказы в Las Vegas. Решите задачу с помощью подзапросов и cte.

-- подзапрос
SELECT e.id, e.first_name, e.job_title
FROM employees AS e
WHERE e.first_name LIKE '%e%' OR job_title = 'Sales Representative'
;

SELECT *
FROM orders AS o
WHERE ship_city = 'Las Vegas'
;

SELECT e.*, o.*
FROM (
	SELECT e.id, e.first_name, e.job_title
	FROM employees AS e
	WHERE e.first_name LIKE '%e%' OR job_title = 'Sales Representative'
) AS e
LEFT JOIN (
	SELECT *
	FROM orders AS o
	WHERE ship_city = 'Las Vegas'
) AS o
ON e.id = o.employee_id
;

-- SELECT e.*, o.*
-- FROM e
-- LEFT JOIN o
-- ON e.id = o.employee_id
-- ;

-- СTE
WITH e AS (
SELECT e.id, e.first_name, e.job_title
FROM employees AS e
WHERE e.first_name LIKE '%e%' OR job_title = 'Sales Representative'
),
o AS (
SELECT *
FROM orders AS o
WHERE ship_city = 'Las Vegas'
)
SELECT e.*, o.*
FROM e
LEFT JOIN o
ON e.id = o.employee_id
;

-- Extra
-- Добавьте колонку с информацией есть ли заказы и отобразите работников однократно каждого
WITH e AS (
SELECT e.id, e.first_name, e.job_title
FROM employees AS e
WHERE e.first_name LIKE '%e%' OR job_title = 'Sales Representative'
),
o AS (
SELECT *
FROM orders AS o
WHERE ship_city = 'Las Vegas'
)
SELECT DISTINCT IF(o.id IS NULL, false, true) AS orders_exists, e.*
FROM e
LEFT JOIN o
ON e.id = o.employee_id
;

--  подсчитать кол-во заказов у каждого

WITH e AS (
SELECT e.id, e.first_name, e.job_title
FROM employees AS e
WHERE e.first_name LIKE '%e%' OR job_title = 'Sales Representative'
),
o AS (
SELECT *
FROM orders AS o
WHERE ship_city = 'Las Vegas'
)
SELECT IF(o.id IS NULL, false, true) AS orders_exists, e.*, COUNT(o.id)
FROM e
LEFT JOIN o
ON e.id = o.employee_id
GROUP BY e.id, orders_exists, job_title
;




