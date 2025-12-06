-- 1. Выведите текущую дату и время:
SELECT NOW();
-- 2. Выведите день недели, когда был сделан каждый заказ из таблицы orders
SELECT order_date, date_format(order_date, '%W') FROM orders;
SELECT DAYNAME(order_date) FROM orders;
-- 3. Добавьте 30 дней к дате каждого заказа в таблице orders и выведите результат
SELECT order_date, order_date + INTERVAL 30 DAY FROM orders;
SELECT order_date, DATE_ADD(order_date, INTERVAL 30 DAY) FROM orders;

-- 4. Выведите количество дней между датой заказа и датой доставки для каждого заказа из таблицы orders
SELECT order_date, shipped_date, DATEDIFF(shipped_date, order_date) AS INTERVAL2 FROM orders; -- не учитывает время
SELECT order_date, shipped_date, TIMESTAMPDIFF(DAY, shipped_date, order_date) AS INTERVAL2 FROM orders; -- учитывает время

-- 5. Найдите все заказы, сделанные в пятницу из таблицы orders
SELECT order_date, DAYNAME(order_date) FROM orders WHERE WEEKDAY(order_date) = '4';

-- 6. Выведите дату, которая будет через 100 дней от текущей:
SELECT NOW()+ INTERVAL 100 DAY;
SELECT DATE_ADD(NOW(), INTERVAL 100 DAY);

-- 7. Выведите заказы, сделанные в выходные дни (суббота и воскресенье) из таблицы orders
SELECT order_date, DAYNAME(order_date) FROM orders WHERE WEEKDAY(order_date) IN (5,6);
SELECT order_date, DAYNAME(order_date) FROM orders WHERE WEEKDAY(order_date) BETWEEN 5 and 6;

-- 8. Найдите количество дней до конца текущего года
SELECT DATEDIFF(
	CONCAT (
			YEAR(NOW()), '-12-31'),
            NOW()
            ) AS DAY_NEW_YEAR;

-- 9. Выведите дату, которая была 15 дней назад от текущей даты
SELECT DATE_ADD(NOW(), interval -15 DAY);

-- 10. Примените явное преобразование Выведите столбец id из таблицы customers в виде строки
SELECT CAST(customer_id AS CHAR);


/* Задание 4
Найдите дату, которая была 90 дней до текущей
даты. */
SELECT current_date()- INTERVAL 90 DAY;
SELECT DATE_ADD(NOW(), INTERVAL -90 DAY);

/* Задание 5
Использование скрытых преобразований.
Сложите строку, содержащую дату, с числом и
выведите результат.
Объедините числовое значение с текстом и
выведите результат в виде строки. */
SELECT '2025-11-05' + 1 AS result_implicit;
SELECT CAST(NOW() AS CHAR) + 1;
SELECT CONCAT('Осталось ',  5);

/* Задание 6
Извлеките год из даты получения заказа
order_date. */
SELECT YEAR (order_date) FROM orders;

/* Задание 7
Преобразуйте текстовое значение,
представляющее дату, в формат DATE.*/
SELECT STR_TO_DATE('20-11-2024', '%d-%m-%Y') AS STRING_TO_DATE;
SELECT CAST('2025-11-06' as DATE) as correct_date;