-- Databases 2025: Домашнее задание 12
-- База данных с доступом на запись:
-- 1 Вывести id департамента , в котором работает сотрудник, в зависимости от Id сотрудника

use 101025_ptm_viktor2;
SELECT department_id
FROM employees
WHERE id = 1;

-- 2 Создайте хранимую процедуру get_employee_age, которая принимает id сотрудника (IN-параметр) и возвращает его возраст через OUT-параметр.

DELIMITER $$

CREATE PROCEDURE get_employee_age(
    IN  p_employee_id INT,
    OUT p_age INT
)
BEGIN
    SELECT age
      INTO p_age
    FROM employees
    WHERE id = p_employee_id;
END$$

DELIMITER ;


SET @age := NULL;
CALL get_employee_age(1, @age);
SELECT @age AS employee_age;

-- 3 Создайте хранимую процедуру decrease_salary, которая принимает зарплату сотрудника (INOUT-параметр) и уменьшает ее на 10%.

DELIMITER $$

CREATE PROCEDURE decrease_salary(
    INOUT p_salary DECIMAL(10,2)
)
BEGIN
    SET p_salary = ROUND(p_salary * 0.90, 2);
END$$

DELIMITER ;

SET @s := 5000.00;
CALL decrease_salary(@s);
SELECT @s AS new_salary;
