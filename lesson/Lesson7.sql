/*Таблица: order_details
Задача: Выведите информацию о каждом заказе,
включая идентификатор заказа (order_id),
расчетную полную стоимость заказа после
применения скидки (net_price).
*/
SELECT order_id, unit_price, discount, quantity, round(unit_price * (1-discount) * quantity, 2) AS PRICE  FROM northwind.order_details;

SELECT 
product_name, 
unit_in_stock, 
CONCAT(
'Available: ',
CAST(unit_in_stock AS CHAR), 
' units, Price: $', 
CAST(list_price AS CHAR)) 
AS product_report 
FROM products;

SELECT 
product_name, 
unit_in_stock, 
CONCAT(
'Available: ',
unit_in_stock, 
' units, Price: $', 
list_price) 
AS product_report 
FROM products;

SELECT "123num" + 10;
SELECT "234" * "10";
SELECT NOW() AS
CurrentDateTime;

SELECT CURDATE() AS
CurrentDate;

SELECT CURTIME() AS
CurrentTime;

SELECT NOW(), DATE_FORMAT(NOW(), '%d-%m-%Y %H:%i') AS
FormattedDateTime;

SELECT DATEDIFF ('2024-08-30','2024-08-25') AS DaysDifference;

SELECT DATE_ADD(NOW(), INTERVAL 10 DAY) AS FutureDate;
SELECT DATE_ADD(NOW(), INTERVAL -10 DAY) AS FutureDate;
SELECT DATE_SUB(NOW(), INTERVAL 10 DAY) AS PastDate;

SELECT EXTRACT(day FROM NOW()) AS CurrentYear;

select cast("12.03.2025" as datetime);
select cast("2025-03-12" as datetime);

SELECT STR_TO_DATE('12.03.2025', '%d.%m.%Y');

/*Выведите дату получения заказа order_date из
таблицы orders
В формате ДДММГГГГ.*/
SELECT date_format(order_date, '%d.%m.%Y')
FROM orders;

/* Выведите дату и время отправки заказа
shipped_date из таблицы orders
В формате ДД/ММ/ГГГГ ЧЧММСС. */
SELECT DATE_FORMAT(shipped_date, '%d/%m/%Y %H:%i:%S') as дата
FROM northwind.orders;