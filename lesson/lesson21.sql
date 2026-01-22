SELECT * FROM 101025_ptm_viktor2.employees;

DELIMITER $$
CREATE PROCEDURE add_employee(
IN emp_name VARCHAR(100), 
IN emp_age INT
)
BEGIN
INSERT INTO employees (name, age) 
VALUES (emp_name, emp_age);
END $$

DELIMITER ;

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

CALL add_employee('John Doe', 30);

DELIMITER $$
CREATE PROCEDURE get_all_employees ()
BEGIN
SELECT id, name, age, department_id FROM employees;
END $$

DELIMITER ;

## Вызов простой процедуры
CALL get_all_employees ();


-- OUT ------------------------------------------------------------
DELIMITER $$

CREATE PROCEDURE get_employee_salary(
IN emp_id INT, 
OUT emp_salary INT
)
BEGIN
SELECT salary 
INTO emp_salary 
FROM employees 
WHERE id = emp_id;
END $$

DELIMITER ;

-- вызов
SET @salary = 0; -- Инициализируем переменную
CALL get_employee_salary(2, @salary); -- Вызываем процедуру и передаем OUT-параметр
SELECT @salary; -- Просматриваем возвращенное значение


-- ----
INSERT INTO employees (name, age, salary, department_id) 
VALUES 
("Jack", 42, @salary, 1)
;

-- ----

/* -------------------------
IN — входной параметр
- Передаётся ВНУТРЬ процедуры
- Используется для фильтрации, условий
- Изменения НЕ возвращаются
------------------------- */

DELIMITER //

CREATE PROCEDURE get_by_department(
IN p_dept_id INT -- входной параметр
)
BEGIN
SELECT *
FROM employees
WHERE department_id = p_dept_id;
END //

DELIMITER ;

/* Вызов */
CALL get_by_department(2);


/* -------------------------
OUT — выходной параметр
- Возвращает значение НАРУЖУ
- Входного значения НЕТ
- Требует пользовательскую переменную, например @var
------------------------- */

DELIMITER //

CREATE PROCEDURE count_employees(
OUT p_count INT -- выходной параметр
)
BEGIN
SELECT COUNT(*)
INTO p_count -- инициализируем временную переменную значением
FROM employees;
END//

DELIMITER ;

/* Вызов */
CALL count_employees(@cnt);
SELECT @cnt;