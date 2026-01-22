-- 1. Выведите Ваш возраст на текущий день в секундах
SELECT TIMESTAMPDIFF(SECOND, '1978-04-08 08:00:00', NOW()) AS MY_AGE_SECOND;

-- 2. Выведите какая дата будет через 51 день
SELECT CURRENT_DATE + INTERVAL 51 DAY AS DATE_NOW_PLUS_51_DAY;

-- 3. Отформатируйте предыдущей запрос - выведите день недели для этой даты Используйте документацию My SQL
SET lc_time_names = 'ru_RU'; -- вид на русском, нужно менять локаль
SELECT DATE_FORMAT((CURRENT_DATE + INTERVAL 51 DAY), '%W') AS DAY_OF_WEEK_NOW_PLUS_51_DAY;

-- 4.  Подключитесь к базе данных northwind Выведите столбец с исходной датой создания транзакции transaction_created_date из таблицы inventory_transactions, 
-- а также столбец полученный прибавлением 3 часов к этой дате
USE `northwind`;
SELECT transaction_created_date, transaction_created_date + INTERVAL 3 HOUR AS PLUS_3_HOUR
FROM inventory_transactions;

-- 5. Выведите столбец с текстом  'Клиент с id <customer_id> сделал заказ <order_date>' из таблицы orders
SELECT CONCAT(
         'Клиент с id ', customer_id,
         ' сделал заказ ', order_date
       ) AS text
FROM orders;

-- Запрос написать двумя способами - с использованием неявных преобразований а также с указанием изменения типа данных для столбца customer_id
SELECT CONCAT(
		'Клиент с id ', CAST(customer_id AS CHAR), 
		' сделал заказ ', DATE_FORMAT(order_date, '%d.%m.%Y') -- выводим только дату без времени
        ) AS text
FROM orders;