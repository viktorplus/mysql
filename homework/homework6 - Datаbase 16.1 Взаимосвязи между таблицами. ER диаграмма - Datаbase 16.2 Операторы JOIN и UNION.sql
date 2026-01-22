-- 1 Выведите одним запросом с использованием UNION столбцы id, employee_id из таблицы orders и соответствующие им столбцы 
-- из таблицы purchase_orders В таблице purchase_orders  created_by соответствует employee_id

use northwind;
SELECT id, employee_id
FROM orders
UNION ALL
SELECT id, created_by
FROM purchase_orders;

-- 2 Из предыдущего запроса удалите записи там где employee_id не имеет значения Добавьте дополнительный столбец со сведениями
--  из какой таблицы была взята запись

SELECT id, employee_id, 'orders' AS source_table
FROM orders
WHERE employee_id IS NOT NULL
UNION ALL
SELECT id, created_by, 'purchase_orders'
FROM purchase_orders;
-- WHERE created_by IS NOT NULL;

-- 3 Выведите все столбцы таблицы order_details а также дополнительный столбец payment_method из таблицы purchase_orders 
-- Оставьте только заказы для которых известен payment_method

SELECT od.*, po.payment_method
FROM northwind.order_details AS od
JOIN northwind.purchase_orders AS po
ON od.purchase_order_id = po.id
WHERE payment_method IS NOT NULL;

-- 4 Выведите заказы orders и фамилии клиентов customers для тех заказов по которым были инвойсы таблица invoices

SELECT o.*, c.last_name, i.id
FROM northwind.orders AS o
LEFT JOIN northwind.customers AS c
ON o.customer_id = c.id
LEFT JOIN northwind.invoices AS i
ON o.id = i.order_id
WHERE i.order_id IS NOT NULL;

-- вариант 2

SELECT o.*, c.last_name, i.id AS invoice_id
FROM northwind.orders AS o
JOIN northwind.customers AS c
ON o.customer_id = c.id
JOIN northwind.invoices AS i
ON o.id = i.order_id;

--  5 Подсчитайте количество инвойсов для каждого клиента из предыдущего запроса 

SELECT c.id, c.last_name, COUNT(i.id) AS invoice_count
FROM northwind.orders AS o
LEFT JOIN northwind.customers AS c
ON o.customer_id = c.id
LEFT JOIN northwind.invoices AS i
ON o.id = i.order_id
WHERE i.order_id IS NOT NULL
GROUP BY c.id;

-- вариант 2, проверил тот же ответ

SELECT c.id, c.last_name, COUNT(i.id) AS invoice_count
FROM northwind.orders AS o
JOIN northwind.customers AS c
ON o.customer_id = c.id
JOIN northwind.invoices AS i
ON o.id = i.order_id
GROUP BY c.id;



-- HR. Посчитать сколько сотрудников работают в каждом из городов, в том числе города без сотрудников

use hr;
SELECT city, COUNT(*)
FROM locations AS loc
LEFT JOIN departments AS d
ON d.location_id = loc.location_id
LEFT JOIN employees AS e
ON e.department_id = d.department_id
GROUP BY city;





