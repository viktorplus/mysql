-- OVER() используется с оконными функциями, такими как:

-- Агрегирующие функции: SUM(), AVG(), MIN(), MAX(), COUNT()
-- Ранжирующие функции: ROW_NUMBER(), RANK(), DENSE_RANK(), NTILE
-- Функции смещения и выбора: LEAD(), LAG(), FIRST_VALUE(), LAST_VALUE(), NTH_VALUE()

-- Компоненты оконной функции:
-- Оконная функция:
-- Само вычисление, например: SUM(), AVG(), ROW_NUMBER(), RANK()

-- Ключевое слово OVER():
-- Указывает, как применять функцию к окну строк. Внутри OVER() можно использовать:

-- PARTITION BY — разделяет строки на группы (окна).
-- ORDER BY — определяет порядок строк внутри окна.

-- ----------------------

-- Нумерация строк ROW_NUMBER()
-- Возвращает порядковый номер каждой строки
SELECT employee_id, department_id, salary,
       ROW_NUMBER() OVER () AS row_num
FROM employees;

-- Возвращает порядковый номер каждой строки в порядке уменьшения зарплаты
SELECT employee_id, department_id, salary,
       ROW_NUMBER() OVER (ORDER BY salary desc) AS row_num
FROM employees;

-- count
SELECT employee_id, department_id, salary,
       COUNT(*) OVER (ORDER BY salary desc) AS cum_counter
FROM employees;

-- Возвращает порядковый номер каждой строки в пределах группы в порядке уменьшения зарплаты
SELECT employee_id, department_id, salary,
       ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary desc) AS row_num
FROM employees;

-- Ранжирование строк RANK()
-- Присваивает ранг строкам. Если несколько строк имеют одинаковое значение, они получают одинаковый ранг, а следующий ранг пропускаетс
-- например распределить призовые места
SELECT employee_id, department_id, salary,
       RANK() OVER (ORDER BY salary DESC) AS sal_rank
       , ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num
FROM employees;

-- Без ORDER BY не имеет смысла
-- SELECT employee_id, department_id, salary,
--        RANK() OVER () AS sal_rank
-- FROM employees;

SELECT employee_id, department_id, job_id,
       RANK() OVER (ORDER BY job_id DESC) AS dep_rank
--       , ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY job_id desc) AS row_num
FROM employees;

SELECT employee_id, department_id, salary,
       RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS sal_by_dep_rank
--       , ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) AS row_num
FROM employees;

-- Ранжирование строк DENSE_RANK()
-- Присваивает ранг строкам. Если несколько строк имеют одинаковое значение, они получают одинаковый ранг, а следующий ранг получает следующий номер
-- Без ORDER BY не имеет смысла
SELECT employee_id, department_id, salary,
       DENSE_RANK() OVER (ORDER BY salary DESC) AS dep_sal_dens_rank
FROM employees;

SELECT employee_id, department_id, job_id,
       DENSE_RANK() OVER (PARTITION BY department_id ORDER BY job_id DESC) AS dep_dens_rank
FROM employees;

-- Нумерация групп NTILE()
-- Разбивает строки на равные группы и присваивает им номера. 
SELECT employee_id, department_id, job_id,
       NTILE(3) OVER () AS ntile_num
       , ROW_NUMBER() OVER () AS row_num
FROM employees;

SELECT employee_id, department_id, job_id,
       NTILE(3) OVER (ORDER BY job_id DESC) AS ntile_num
       , ROW_NUMBER() OVER (ORDER BY job_id DESC) AS row_num
FROM employees;

SELECT employee_id, department_id, job_id,
       NTILE(3) OVER (PARTITION BY department_id ORDER BY job_id DESC) AS ntile_num
       , ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY job_id DESC) AS row_num
FROM employees;

-- ---------------------------------------------------------------------------------------------------

-- Функции смещения и выбора:

-- LEAD() — возвращает значение из следующей строки в рамках окна
SELECT employee_id, department_id, job_id, hire_date, salary,
       LEAD(salary) OVER (ORDER BY hire_date) AS next_salary
FROM employees;

SELECT employee_id, department_id, job_id, hire_date, salary,
       LEAD(salary) OVER (PARTITION BY department_id, job_id ORDER BY hire_date) AS next_salary
FROM employees;

-- Функции смещения и выбора:

-- LEAD() — возвращает значение из следующей строки в рамках окна
SELECT employee_id, department_id, job_id, hire_date, salary,
       LEAD(salary) OVER (ORDER BY hire_date) AS next_salary
FROM employees;

-- LEAD() — возвращает значение из следующей строки в рамках окна
SELECT employee_id, department_id, job_id, hire_date, salary,
       LEAD(salary) OVER (ORDER BY hire_date) AS next_salary,
       salary - LEAD(salary) OVER (ORDER BY hire_date) AS next_salary
FROM employees;

SELECT employee_id, department_id, job_id, hire_date, salary,
       LEAD(salary) OVER (PARTITION BY department_id, job_id ORDER BY hire_date) AS next_salary,
       salary - LEAD(salary) OVER (PARTITION BY department_id, job_id ORDER BY hire_date) AS dinamic_salary
FROM employees;


SELECT employee_id, department_id, job_id, hire_date, salary,
       LEAD(salary) OVER (PARTITION BY department_id, job_id ORDER BY hire_date) AS next_salary
FROM employees;

-- LAG() — возвращает значение из предыдущей строки в рамках окна
SELECT employee_id, department_id, job_id, hire_date, salary,
       LAG(salary) OVER (PARTITION BY department_id, job_id ORDER BY hire_date) AS prev_salary,
       salary - LAG(salary) OVER (PARTITION BY department_id, job_id ORDER BY hire_date) AS dinamic_salary
FROM employees;

-- LAG() — возвращает значение из предыдущей строки в рамках окна
SELECT employee_id, department_id, job_id, hire_date, salary,
       LAG(salary) OVER (PARTITION BY department_id, job_id ORDER BY hire_date) AS prev_salary
FROM employees;

-- LAG() — возвращает значение из предыдущей строки в рамках окна
-- syntax LAG(column, offset, default)
SELECT employee_id, department_id, job_id, hire_date, salary,
       LAG(salary, 2, 0) OVER (PARTITION BY department_id, job_id ORDER BY hire_date) AS prev_salary
FROM employees;


-- FIRST_VALUE() — возвращает первое значение в окне
SELECT employee_id, department_id, hire_date, salary,
       FIRST_VALUE(salary) OVER (ORDER BY hire_date) AS first_salary
FROM employees;

SELECT employee_id, department_id, hire_date, salary,
       FIRST_VALUE(salary) OVER (PARTITION BY department_id ORDER BY hire_date) AS first_salary
FROM employees;

-- LAST_VALUE() — возвращает последнее значение в окне
-- не корректно
-- стандартный frame: RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
SELECT employee_id, department_id, hire_date, salary,
       LAST_VALUE(salary) OVER (PARTITION BY department_id ORDER BY hire_date) AS last_salary
FROM employees;

-- корректно
-- использовать frame: RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
SELECT employee_id, department_id, hire_date, salary,
       LAST_VALUE(salary) OVER (PARTITION BY department_id ORDER BY hire_date
                                ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_salary
FROM employees;

-- NTH_VALUE() — возвращает n-е значение в окне (например, второе)
SELECT employee_id, department_id, hire_date, salary,
       NTH_VALUE(salary, 2) OVER (PARTITION BY department_id ORDER BY hire_date
                                  ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS second_salary
FROM employees;
