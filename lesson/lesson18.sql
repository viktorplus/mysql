USE hr;

-- where one
SELECT AVG(salary)
FROM employees;

SELECT first_name, last_name, salary as av_s
FROM employees
WHERE salary > 10000;

SELECT first_name, last_name, salary as av_s
FROM hr.employees
WHERE salary > (
SELECT AVG(salary)
FROM employees
);

-- ERROR: WHERE работает до агрегации
SELECT first_name, last_name, salary as av_s
FROM employees
WHERE salary > AVG(salary);

-- Агрегация без группы оставляет одну запись: HAVING нечего фильтровать - осталась одна ячейка
SELECT first_name, last_name, salary as av_s, AVG(salary)
FROM employees
HAVING salary > AVG(salary);

-- many
SELECT max(salary), department_id
FROM employees
GROUP BY department_id;

SELECT first_name, last_name, salary, department_id
FROM employees e
WHERE salary in (
SELECT MAX(salary)
FROM employees
GROUP BY department_id
);


SELECT avg(salary), department_id
FROM employees
GROUP BY department_id
;

SELECT first_name, last_name, salary, department_id
FROM employees e
WHERE salary > (
SELECT AVG(salary)
FROM employees
WHERE department_id = e.department_id
);


-- from
-- Сотрудники и средняя зарплата по всем
SELECT AVG(salary) AS avg_salary
FROM employees;

SELECT e.first_name, e.last_name, e.salary, t.avg_salary
FROM employees AS e
JOIN (
SELECT AVG(salary) AS avg_salary
FROM employees
) AS t
where e.salary > t.avg_salary;


-- Сотрудники и зарплата выше средней в их департаменте
SELECT department_id, AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id;

SELECT e.first_name, e.last_name, e.salary, e.department_id, d.avg_salary
FROM employees AS e
LEFT JOIN (
SELECT department_id, AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id
) AS d
ON e.department_id = d.department_id
where e.salary > d.avg_salary;


-- Найти 10 продуктов, которые были заказаны больше всего, и узнать общую сумму заказов по этим продуктам.
-- Найти 10 продуктов, которые были заказаны больше всего, и узнать общую сумму заказов по этим продуктам.
SELECT * FROM northwind.order_details;

SELECT product_id, COUNT(*) AS count_ordered_prod, ROUND(SUM(unit_price * quantity), 2) AS full_sum_prod
FROM northwind.order_details
GROUP BY product_id
ORDER BY count_ordered_prod DESC
LIMIT 10;

SELECT product_id, product_name, COUNT(*) AS count_ordered_prod, ROUND(SUM(unit_price * quantity), 2) AS full_sum_prod
FROM northwind.order_details
JOIN products 
ON order_details.product_id = products.id
GROUP BY product_id
ORDER BY count_ordered_prod DESC
LIMIT 10;

# добрали колонку с названиями, методом JOIN
SELECT products_info.*, product_name
FROM products
JOIN 
	(SELECT product_id, COUNT(*) AS count_ordered_prod, ROUND(SUM(unit_price * quantity), 2) AS full_sum_prod
	FROM northwind.order_details
	GROUP BY product_id
	ORDER BY count_ordered_prod DESC
	LIMIT 10) AS products_info 
ON  products_info.product_id = products.id;

---------------------------------------
SELECT department_id, AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id;

WITH dept_avg AS (
SELECT department_id, AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id
)
SELECT first_name, last_name, salary, d.department_id
FROM employees e
JOIN dept_avg d 
ON e.department_id = d.department_id
WHERE e.salary > d.avg_salary;

-- Найти 10 продуктов, которые были заказаны больше всего, и узнать общую сумму заказов по этим продуктам 
-- (то есть продукты с наибольшим количеством заказов и их суммарную стоимость).
WITH prod_order_info AS (
SELECT product_id, COUNT(*) AS count_ordered_prod, ROUND(SUM(unit_price * quantity), 2) AS full_sum_prod
FROM northwind.order_details
GROUP BY product_id
ORDER BY count_ordered_prod DESC
LIMIT 10
)
SELECT prod_order_info.*, products.product_name
FROM  prod_order_info
JOIN products
ON products.id = prod_order_info.product_id
;