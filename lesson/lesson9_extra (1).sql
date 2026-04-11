-- OVER() используется с оконными функциями, такими как:

-- Агрегирующие функции: SUM(), AVG(), MIN(), MAX(), COUNT()

-- Компоненты оконной функции:
-- Оконная функция:
-- Само вычисление, например: SUM(), AVG(), MIN(), MAX(), COUNT()

-- Ключевое слово OVER():
-- Указывает, как применять функцию к окну строк. Внутри OVER() можно использовать:

-- PARTITION BY — разделяет строки на группы (окна).
-- ORDER BY — определяет порядок строк внутри окна и делает агрегацию накопительной.

-- ----------------------

-- Агрегатная функция без OVER()
-- Возвращает одну строку с суммой зарплат по всей таблице
SELECT SUM(salary)
FROM employees;

-- Оконная функция с OVER()
-- Сумма зарплат по всей таблице, значение повторяется в каждой строке
-- Количество строк не уменьшается
SELECT employee_id, first_name, last_name, department_id, salary,
       SUM(salary) OVER () AS total_salary
FROM employees;

SELECT employee_id, first_name, last_name, department_id, salary,
       SUM(salary) OVER () AS total_salary, salary / SUM(salary) OVER () * 100 AS part_salary
FROM employees;

-- Сумма зарплат по каждому департаменту
-- Для каждой строки показывается сумма её департамента
SELECT employee_id, first_name, last_name, department_id, salary,
       SUM(salary) OVER (PARTITION BY department_id) AS total_salary_department
FROM employees;

-- Сумма зарплат внутри комбинации department_id + job_id
-- Каждое уникальное сочетание образует отдельное окно
SELECT employee_id, first_name, last_name, department_id, job_id, salary,
       SUM(salary) OVER (PARTITION BY department_id, job_id) AS total_salary_department
FROM employees;

-- ORDER BY в основном запросе
-- Не влияет на расчёт оконной функции, только сортирует результат
SELECT employee_id, first_name, last_name, department_id, salary,
       SUM(salary) OVER (PARTITION BY department_id) AS total_salary_department
FROM employees
ORDER BY salary;

-- То же самое: сортировка результата по department_id и salary
-- Оконная функция считается до ORDER BY
SELECT employee_id, first_name, last_name, department_id, salary,
       SUM(salary) OVER (PARTITION BY department_id) AS total_salary_department
FROM employees
ORDER BY department_id, salary;

-- ORDER BY внутри OVER()
-- Накопительная сумма (running total) от начала таблицы до текущей строки
SELECT employee_id, first_name, last_name, department_id, salary, hire_date,
       COUNT(salary) OVER (PARTITION BY hire_date) AS employee_by_day,
       SUM(salary) OVER (ORDER BY hire_date) AS total_salary
FROM employees;

-- Накопительная сумма зарплат внутри каждого департамента
-- Для каждого department_id расчёт начинается заново
SELECT employee_id, first_name, last_name, department_id, salary, hire_date,
       SUM(salary) OVER (PARTITION BY department_id ORDER BY hire_date) AS cumulat_total_salary_department
FROM employees;

-- Накопительная сумма внутри департамента по номеру месяца найма
SELECT employee_id, first_name, last_name, department_id, salary, CONCAT(YEAR(hire_date), "-", MONTH(hire_date)),
       SUM(salary) OVER (PARTITION BY department_id ORDER BY YEAR(hire_date), MONTH(hire_date)) AS total_salary_department
FROM employees;
