-- 1. Из таблицы inventory_transactions вывести столбец quantity, а также рассчитанный на его основе столбец
-- category, который принимает значения 'Almost finish', если quantity меньше 20 и 'Enought', если quantity
-- больше либо равно 20. Решить задачу с помощью IF и CASE.
SELECT quantity,  
CASE 
WHEN quantity <20 THEN 'Almost finish'
WHEN quantity >= 20 THEN 'Enought'
END
AS category
FROM northwind.inventory_transactions;

SELECT quantity,  
	IF(quantity<20, 'Almost finish', 'Enought') AS category 
FROM northwind.inventory_transactions 
ORDER BY quantity;

-- 2. Из таблицы purchase_order_details вывести все строки, где purchase_order_id изменяется от 90 до 100
-- включительно. Добавить столбец с категорией по количеству Если quantity меньше 30 то 'small', от 30 до 70
-- включительно - 'medium', в остальных случаях 'large'.
SELECT DISTINCT purchase_order_id, quantity, 
	CASE
		WHEN quantity < 30 THEN "small"
        WHEN quantity BETWEEN 30 AND 70 THEN "medium"
		ELSE 'large'
	END AS new_name
FROM northwind.purchase_order_details 
WHERE purchase_order_id BETWEEN 90 AND 100
ORDER BY purchase_order_id ASC;

-- 3. Решите предыдущую задачу используя вложенные IF.
SELECT DISTINCT purchase_order_id, quantity,
	IF(quantity <30, "small", IF(quantity BETWEEN 30 AND 70, "medium", 'large')) 
    AS new_name
FROM northwind.purchase_order_details 
WHERE purchase_order_id BETWEEN 90 AND 100
ORDER BY purchase_order_id ASC;

-- 4. Вывести уникальные значения purchase_order_id для строк где unit_cost больше 10. Отсортировать данные
-- по убыванию выводимого столбца. Таблица purchase_order_details.
SELECT DISTINCT purchase_order_id
FROM northwind.purchase_order_details
WHERE unit_cost > 10
ORDER BY purchase_order_id DESC;


-- 5. Вывести пять строк начиная со второй из customers, где job_title равно 'Owner'. Отсортировать строки в
-- алфавитном порядке по state_province.
SELECT * FROM northwind.customers 
WHERE job_title = 'Owner' 
ORDER BY state_province 
LIMIT 5 OFFSET 1;

-- 6. Выбрать уникальные id продуктов из таблицы order_details в том случае, если суммарная стоимость
-- продукта quantity*unit_price превышает 200 отсортировать столбец по возрастанию и выбрать 7 строк.
SELECT DISTINCT product_id FROM northwind.order_details 
WHERE quantity*unit_price > 200
ORDER BY product_id
LIMIT 7;

-- 7. Вывести инициалы - первую букву имени и первую букву фамилии сотрудника из таблицы employees.
SELECT CONCAT(LEFT(first_name, 1), '.', LEFT(last_name, 1), '.') AS initials 
FROM northwind.employees;

-- 8. Вывести все строки и вычисляемый столбец - если payment_type не указан, то 'No data' в остальных
-- случаях значение столбца payment_type из таблицы orders. Решить задачу с помощью IF и CASE.
SELECT 
    *,
    IF(payment_type IS NULL,
        'No data',
        payment_type)
		AS new_11,
	CASE 
		WHEN payment_type is NULL THEN 'No data' 
        ELSE payment_type 
	END
	AS new_11
FROM
    orders
;
-- 9. Вывести имя и фамилию клиентов из таблицы customers в верхнем регистре.
SELECT 
    UPPER(first_name) AS first_name_upper,
    UPPER(last_name)  AS last_name_upper
FROM northwind.customers;