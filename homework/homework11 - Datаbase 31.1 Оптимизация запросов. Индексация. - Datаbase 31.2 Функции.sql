/* Databases 2025: Домашнее задание 11

Лекции: 
Datаbase 31.2: Функции

Создать кастомные функции
Расчет площади круга
Создайте функцию для расчета площади круга, если известен его радиус.
Используйте формулу 
Где:
S — площадь круга,
r — радиус круга,
​π≈3.14159, используйте функцию PI(), которая возвращает это число
*/

DELIMITER //
CREATE FUNCTION area_circle (radius DECIMAL (10, 2)) 
RETURNS DECIMAL (10,2)
DETERMINISTIC
BEGIN
	RETURN PI() * POW(radius, 2);
END //
DELIMITER ;

SELECT 101025_ptm_viktor2.area_circle (3);

/*
2. Функция для расчета гипотенузы треугольника
Создайте функцию для расчета гипотенузы прямоугольного треугольника, если известны длины его катетов.
Используйте формулу 
Где:
c — длина гипотенузы прямоугольного треугольника,
a, b — длины его катетов
*/

DELIMITER //

CREATE FUNCTION hypotenuse (a DECIMAL(10,2), b DECIMAL (10,2))
RETURNS DECIMAL (10,2)
DETERMINISTIC
BEGIN
    RETURN SQRT(POW(a, 2) + POW(b, 2));
END //
DELIMITER ;

SELECT hypotenuse(3,4);
 

