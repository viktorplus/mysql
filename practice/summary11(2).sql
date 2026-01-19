-- 2. Проверка четности Функция для проверки, является ли число четным. 
-- Функция принимает целое число и возвращает 1, если оно четное, и 0, если нечетное.
use 101025_ptm_viktor2;
DELIMITER //
CREATE FUNCTION `101025_ptm_viktor2`.is_even (num INT)
RETURNS BOOL
DETERMINISTIC
BEGIN
RETURN num % 2 = 0;
END //
DELIMITER ;

SELECT age, is_even (age) FROM students;


-- 1. Перевод сантиметров в дюймы
-- Создайте функцию для перевода сантиметров в дюймы. 
-- Используйте формулу:
-- 1 сантиметр = 0.393701 дюйма

DELIMITER //
CREATE FUNCTION cm_to_dm (num INT)
RETURNS DECIMAL (10,2)
DETERMINISTIC
BEGIN
RETURN num * 0.393701;
END //
DELIMITER ;

SELECT age, cm_to_dm (age) FROM students;

-- 2. Расчет объема шара
-- Создайте функцию для расчета объема шара, если известен радиус.
-- Можно воспользоваться следующей формулой:
-- Где
-- V— объем шара,
-- r — радиус шара,
-- ​π≈3.14159

DELIMITER //
CREATE FUNCTION cm_to_inches (cm NUMERIC(10,2))
RETURNS NUMERIC (10,2)
DETERMINISTIC
BEGIN
RETURN cm * 0.393701;
END //
DELIMITER ;

-- 3. Перевод градусов в радианы
-- Создайте функцию для перевода градусов в радианы.
-- Для перевода градусов в радианы используется следующая формула:
-- радианы = градусы × π/180, где ​π≈3.14159

DELIMITER //
CREATE FUNCTION grad_to_radian (grad INT)
RETURNS DECIMAL (10,2)
DETERMINISTIC
BEGIN
RETURN grad * pi()/180;
END //
DELIMITER ;

SELECT age, grad_to_radian (age) FROM students;


