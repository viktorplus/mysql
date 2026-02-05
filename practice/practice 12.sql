-- Практика 12

DELIMITER //
CREATE PROCEDURE name_ (
	IN variable INT 
)
BEGIN
	SELECT age
    FROM employees
    WHERE id = id_user;

END //

DELIMITER ;

CALL mane (3);

USE 101025_Dmytro_K;
DELIMITER //
CREATE PROCEDURE get_age_employee(
IN p_id INT,
OUT p_age INT)

BEGIN
SELECT age
INTO p_age
FROM employees
WHERE id = p_id;
END
//
DELIMITER ;

CALL get_age_employee(1, @age);
SELECT @age



CREATE TABLE employees 
(
id INT PRIMARY KEY AUTO_INCREMENT, 
name VARCHAR(100), 
age INT, 
salary INT, 
department_id INT 
);

INSERT INTO employees (name, age, salary, department_id) 
VALUES 
("Alice", 31, 5000, 2),
("Bob", 25, 7000, 1),
("Tom", 53, 2500, 2),
("Ann", 19, 4000, 3),
("Lisa", 33, 8000, 2)
;

-- 1. Выведите возраст сотрудника в зависимости от его Id.

SELECT age
FROM employees
WHERE age = 25;

DELIMITER //
CREATE PROCEDURE get_age_by_id(
	IN id_user INT 
)
BEGIN
	SELECT age
    FROM employees
    WHERE id = id_user;

END //

DELIMITER ;

CALL get_age_by_id(3);

---

USE 101025_Dmytro_K;
DELIMITER //
CREATE PROCEDURE get_age_employee(
IN p_id INT,
OUT p_age INT)

BEGIN
SELECT age
INTO p_age
FROM employees
WHERE id = p_id;
END
//
DELIMITER ;

CALL get_age_employee(1, @age);
SELECT @age

-- 2. Создайте хранимую процедуру get_employee_salary, которая принимает id сотрудника 
-- (IN-параметр) и возвращает его зарплату через OUT-параметр.

DELIMITER //

-- DROP PROCEDURE IF EXISTS get_employee_salary //
CREATE PROCEDURE get_employee_salary(
    IN p_user_id INT,
    OUT p_salary DECIMAL(10,2)
)
BEGIN
    SELECT e.salary
      INTO p_salary
    FROM employees e
    WHERE e.id = p_user_id;
END //

DELIMITER ;


CALL get_employee_salary(4, @salary);
SELECT @salary;


-- 3. Создайте хранимую процедуру increase_salary, которая принимает текущую зарплату сотрудника 
-- (INOUT-параметр) и увеличивает ее на 10%.

DELIMITER //

-- DROP PROCEDURE IF EXISTS increase_salary //
CREATE PROCEDURE increase_salary(INOUT p_salary DECIMAL(10,2))
BEGIN
  SET p_salary = ROUND(p_salary * 1.10, 2);
END //

DELIMITER ;

SET @s = 5000.00;
CALL increase_salary(@s);
SELECT @s;   -- 5500.00


-- 2 вариант

-- DROP PROCEDURE IF EXISTS increase_salary2 //
DELIMITER //

DROP PROCEDURE IF EXISTS increase_salary //
CREATE PROCEDURE increase_salary2 (INOUT p_salary DECIMAL(10,2))
BEGIN
    DECLARE v_old_salary DECIMAL(10,2);

    SET v_old_salary = p_salary;                 -- старая зарплата (для WHERE)
    SET p_salary = ROUND(p_salary * 1.10, 2);    -- новая зарплата (и OUT-результат)

    UPDATE employees
    SET salary = p_salary
    WHERE salary = v_old_salary;
END //

DELIMITER ;

SET SQL_SAFE_UPDATES = 0;  -- отключить SAVEMODE
SET @s = 5000.00;
CALL increase_salary(@s);
SELECT @s AS new_salary;

--- 

DELIMITER //

-- DROP PROCEDURE IF EXISTS increase_salary3 //
CREATE PROCEDURE increase_salary3(
    IN     p_employee_id INT,
    IN     p_percent     DECIMAL(5,2),
    INOUT  p_salary      DECIMAL(10,2)
)
BEGIN
    -- берём текущую зарплату из БД, если p_salary не задан (NULL)
    IF p_salary IS NULL THEN
        SELECT salary INTO p_salary
        FROM employees
        WHERE id = p_employee_id
        LIMIT 1;
    END IF;

    -- увеличиваем на заданный процент
    SET p_salary = ROUND(p_salary * (1 + p_percent / 100), 2);

    -- пишем в БД
    UPDATE employees
    SET salary = p_salary
    WHERE id = p_employee_id;
END //

DELIMITER ;

SET @s = NULL;                 -- чтобы взять текущую из БД
CALL increase_salary3(4, 15, @s);
SELECT @s AS new_salary;

--

DELIMITER //
CREATE PROCEDURE increase_salary2_1 (INOUT p_salary DECIMAL(10,2))
BEGIN
UPDATE employees
SET salary = ROUND(salary * 1.10, 2)
WHERE salary = p_salary;

SET p_salary = ROUND(p_salary * 1.10, 2); -- новая зарплата (и OUT-результат)

END //

delimiter ;

SET @s = 5000.00;
CALL increase_salary2_1(@s);
SELECT @s AS new_salary;

---

-- 1. Создайте таблицу employees2 с колонками id (INT), name (VARCHAR), monthly_salary (INT).
-- 2. Вставьте несколько записей в таблицу.
-- 3. Создайте хранимую процедуру, которая возвращает годовую зарплату (ежемесячная зарплата * 12) через OUT-параметр.
-- 4. Вызовите процедуру и проверьте результат, используя переменную для OUT-параметра.

DELIMITER //

DROP PROCEDURE IF EXISTS get_year_salary //
CREATE PROCEDURE get_year_salary(
    IN  p_employee_id INT,
    OUT p_annual_salary DECIMAL(12,2)
)
BEGIN
    SELECT ROUND(salary * 12, 2)
      INTO p_annual_salary
    FROM employees
    WHERE id = p_employee_id;
END //

DELIMITER ;

CALL get_year_salary(4, @annual);
SELECT @annual AS annual_salary;


