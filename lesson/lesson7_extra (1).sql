USE hr;

-- where one
SELECT AVG(salary)
FROM employees;

SELECT first_name, last_name, salary as av_s
FROM employees
WHERE salary > 10000;

SELECT first_name, last_name, salary as av_s
FROM hr.employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);

-- ERROR: WHERE работает до агрегации
SELECT first_name, last_name, salary as av_s
FROM employees
WHERE salary > AVG(salary);

-- Агрегация без группы оставляет одну запись: HAVING нечего фильтровать - осталась одна ячейка
SELECT first_name, last_name, salary as av_s, AVG(salary)
FROM employees
HAVING salary > AVG(salary);

-- ------------------------------------------------
-- many
SELECT max(salary), department_id
FROM employees
GROUP BY department_id;

SELECT first_name, last_name, salary, department_id
FROM employees e
WHERE salary in (
    SELECT MAX(salary)
    FROM employees
	GROUP BY department_id
);

-- внутренний зависит от внешнего

SELECT avg(salary), department_id
FROM employees
GROUP BY department_id;

SELECT AVG(salary)
FROM employees
WHERE department_id = 80;

SELECT first_name, last_name, salary, department_id
FROM employees AS e
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE department_id = e.department_id
);

-- ERROR: много колонок
SELECT first_name, last_name, salary, department_id
FROM employees e
WHERE salary > (
	SELECT avg(salary), department_id
	FROM employees
	GROUP BY department_id
);

-- ------------------------------------------------
-- from
-- Сотрудники и средняя зарплата по всем
SELECT AVG(salary) AS avg_salary
FROM employees;

SELECT e.first_name, e.last_name, e.salary, t.avg_salary
FROM employees AS e
JOIN (
    SELECT AVG(salary) AS avg_salary
    FROM employees
) AS t
where e.salary > t.avg_salary;

-- Сотрудники и зарплата выше средней в их департаменте
SELECT department_id, AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id;
    
SELECT e.first_name, e.last_name, e.salary, e.department_id, d.avg_salary
FROM employees AS e
LEFT JOIN (
    SELECT department_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
) AS d
ON e.department_id = d.department_id
where e.salary > d.avg_salary;


-- -----------------------------------------
WITH
cte1 AS (
    SELECT ...
    FROM table1
    WHERE ...
),
cte2 AS (
    SELECT ...
    FROM table2
    WHERE ...
),
cte3 AS (
    SELECT ...
    FROM table3
    WHERE ...
)
SELECT ...
FROM cte1
JOIN cte2 ON ...
JOIN cte3 ON ...
WHERE ...;

-- -----------------------------------------
SELECT department_id, AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id;

WITH dept_avg AS (
    SELECT department_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
)
SELECT first_name, last_name, salary, d.department_id
FROM employees e
JOIN dept_avg d 
ON e.department_id = d.department_id
WHERE e.salary > d.avg_salary;

-- не работает
-- select * from dept_avg;

