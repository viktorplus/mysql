use northwind;

/*
1. У каких сотрудников в таблице employees нет привилегий таблица employee_privileges. 
Выведите имя и фамилию. Выполните задание тремя способами - с помощью left join, подзапроса и сte.
*/


-- LEFT JOIN
SELECT id, CONCAT(first_name, ' ', last_name) as employees
FROM employees
LEFT JOIN employee_privileges
ON employees.id = employee_privileges.employee_id
WHERE employee_privileges.employee_id IS NULL;

-- Подзапрос
SELECT employee_id
FROM employee_privileges;

SELECT id, CONCAT(first_name, ' ', last_name) as employees
FROM employees
WHERE employees.id NOT IN
(SELECT employee_id
FROM employee_privileges);

-- CTE


-- SELECT id, CONCAT(first_name, ' ', last_name) as employees
-- FROM employees
-- WHERE employees.id NOT IN (SELECT * FROM employees_with_privileges);

WITH employees_with_privileges AS (
	SELECT employee_id
	FROM employee_privileges
)
SELECT id, CONCAT(first_name, ' ', last_name) as employees
FROM employees
LEFT JOIN employees_with_privileges
ON employees.id = employees_with_privileges.employee_id
WHERE employees_with_privileges.employee_id is NULL;

/*
2. Выберите только тех сотрудников из таблицы, имя которых содержит английскую букву 'e' или их job_title = Sales Representative. 
Из заказов orders выберите заказы в которых город отправки ship_city = Las Vegas. 
Проверьте, отправляли ли найденные сотрудники заказы в Las Vegas. Решите задачу с помощью подзапросов и cte.
*/

SELECT id, CONCAT(first_name, ' ', last_name) as employees, job_title
FROM employees
WHERE first_name LIKE '%e%' OR job_title = 'Sales Representative';

SELECT *
FROM orders
WHERE ship_city = 'Las Vegas';

-- doesnt work
SELECT e.*, o.*
FROM e
LEFT JOIN o
ON e.id = o.employee_id;

SELECT e.*, o.*
FROM 
	(SELECT id, CONCAT(first_name, ' ', last_name) as employees, job_title
	FROM employees
	WHERE first_name LIKE '%e%' OR job_title = 'Sales Representative') as e 
LEFT JOIN 
	(SELECT *
	FROM orders
	WHERE ship_city = 'Las Vegas') as o
ON e.id = o.employee_id;

-- CTE и отобразить как отдельную колонку, вьіполнен ли заказ
WITH e AS (
SELECT id, CONCAT(first_name, ' ', last_name) as employees, job_title
FROM employees
WHERE first_name LIKE '%e%' OR job_title = 'Sales Representative'),
o AS (
SELECT *
FROM orders
WHERE ship_city = 'Las Vegas')

SELECT DISTINCT IF(o.id is NOT NULL, 'TRUE', 'FALSE') as orders_exist, e.*
FROM e
LEFT JOIN o
ON e.id = o.employee_id;

-- добавить колонку с количеством заказов

WITH e AS (
SELECT id, CONCAT(first_name, ' ', last_name) as employees, job_title
FROM employees
WHERE first_name LIKE '%e%' OR job_title = 'Sales Representative'),
o AS (
SELECT *
FROM orders
WHERE ship_city = 'Las Vegas')

SELECT DISTINCT IF(o.id is NOT NULL, 'ORDERED', 'NOT ORDERED') as orders_exist, e.*, COUNT(o.id) as `quantity of orders`
FROM e
LEFT JOIN o
ON e.id = o.employee_id
GROUP BY e.id, orders_exist;


/*
3. Выберите клиентов из компаний A, B, C, D, F. 
Проверьте, делали ли они заказы orders, используя перевозчика shipper_id = 3. 
Выведите имя клиента и наименование перевозчика company из таблицы shippers. 
Решить задачу тремя способами - с помощью JOIN, подзапросов и временных таблиц.
*/


