-- Объедините с помощью UNION ALL названия компаний сотрудников из таблицы employees, названия компаний клиентов из таблицы customers и названия компаний для поставщиков из таблицы suppliers.

SELECT company AS nuw_company
FROM employees
UNION ALL
SELECT company
FROM customers
UNION ALL
SELECT company
FROM suppliers;

-- Объясните почему в предыдущем запросе не стоит использовать UNION ALL.Добавьте к предыдущему запросу столбец, показывающий из какой таблицы была взята запись.

SELECT company as companys, 'employees' as name_table FROM employees
UNION
SELECT company, 'suppliers' FROM suppliers
UNION
SELECT company, 'customers' FROM customers;

-- У каких сотрудников в таблице employees нет привилегий таблица employee_privileges. Выведите имя и фамилию.

SELECT e.last_name, e.first_name, ep.privilege_id 
FROM employees AS e
LEFT JOIN employee_privileges AS ep
ON e.id = ep.employee_id
WHERE ep.privilege_id IS NULL;

-- Работаем с таблице inventory_transactions. Выведите transaction_created_date, а также название типа транзакции и название продукта.

SELECT transaction_created_date, type_name, product_name
FROM inventory_transactions
LEFT JOIN inventory_transaction_types
ON inventory_transactions.transaction_type = inventory_transaction_types.id
LEFT JOIN products
ON inventory_transactions.product_id = products.id;

-- Используя предыдущий запрос, посчитайте количество транзакций по типу. Оставьте только те типы транзакций, в которых отсутствует слово 'Sold'.

SELECT type_name, COUNT(*) as cnt
FROM inventory_transactions
LEFT JOIN inventory_transaction_types
ON inventory_transactions.transaction_type = inventory_transaction_types.id
WHERE type_name NOT LIKE '%Sold%'
GROUP BY type_name;

-- В таблице orders расшифруйте значения всех столбцов, в именах которых присутствует 'id' и для которых в базе данных имеются 
-- соответствующие таблицы. Выведите все строки в которых ship_city Seattle. Объясните почему в данном случае важно использовать LEFT JOIN.
SELECT 
	orders.id as order_id,
    concat_ws(' ', emp.last_name, emp.first_name) as employee_name,
    concat_ws(' ', cust.last_name, cust.first_name) as customer_name,
    order_date, 
    ship.company as shipper_name, 
    ship_city, 
    ots.tax_status_name as tax_name, 
    os.status_name
FROM orders
LEFT JOIN employees as emp
ON employee_id = emp.id
LEFT JOIN customers as cust
ON customer_id = cust.id
LEFT JOIN shippers as ship
ON shipper_id = ship.id
LEFT JOIN orders_tax_status as ots
ON tax_status_id = ots.id
LEFT JOIN orders_status as os
ON status_id = os.id
WHERE ship_city = 'Seattle';