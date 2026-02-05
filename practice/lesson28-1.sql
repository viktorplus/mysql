
-- NTH_VALUE() — возвращает n-е значение в окне (например, второе)
SELECT employee_id, department_id, hire_date, salary,
NTH_VALUE(salary, 2) OVER (PARTITION BY department_id ORDER BY hire_date
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS second_salary
FROM employees;

-- 1. Присвоить ранг продукту без пропусков значений в ранге от больше себестоимости к меньшей. Вывести ТОП 10 продуктов product_name.
SELECT product_name, standard_cost, 
       DENSE_RANK() over (ORDER BY standard_cost DESC) as prod_cost_rank
FROM northwind.products
LIMIT 10;

-- вложенный запрос
SELECT * FROM
(SELECT product_name, standard_cost, 
       DENSE_RANK() over (ORDER BY standard_cost DESC) as prod_cost_rank
FROM northwind.products) as rank_table
where prod_cost_rank <= 20;


# 2. Пронумеровать строки в таблице в зависимости от названия товара от A до Z.

SELECT product_name,
	row_number() over (order by product_name asc) AS prod_number
    from products;

# 3. Разделить все продукты на 4 равных группы в зависимости от list_price. 

SELECT product_name, list_price,
	ntile(4) over (order by list_price) AS price_groups
from products;

# 4. Из таблицы purchase_orders для каждого поставщика supplier_id выведите дату создания заказа, а также дату создания предыдущего заказа. Посчитайте разницу между этим датами.

select
	creation_date,
    supplier_id,
    lag(creation_date) over(
    partition by supplier_id
    order by creation_date) as last_date,
    datediff(creation_date,lag(creation_date) over(
    partition by supplier_id
    order by creation_date)) as diff_date
    
from purchase_orders;


    
-- Измените предыдущий запрос таким образом, чтобы узнать среднее время между двумя заказами.

SELECT 
    supplier_id,
    AVG(days_diff) AS avg_days_between_orders
FROM (
    SELECT 
        supplier_id,
        DATEDIFF(creation_date, LAG(creation_date) OVER (PARTITION BY supplier_id ORDER BY creation_date)) AS days_diff
    FROM 
        purchase_orders
) AS subquery
GROUP BY 
    supplier_id;


-- Напишите аналогичный второму задания запрос, но с использованием функции LEAD. Сравните результаты.

-- Нaйдите самую раннюю дату submitted_date для каждого менеджера created_by. Решите данное задание использую оконные функции MIN и FIRST VALUE. Сравните результаты.

-- Из таблицы purchase_orders для каждого поставщика supplier_id выведите дату создания заказа,
--  а также дату создания предыдущего заказа. Посчитайте разницу между этим датами.
select
id, creation_date,
supplier_id,
lag(creation_date) over(
partition by supplier_id
order by creation_date) as last_date,
datediff(creation_date,lag(creation_date) over(
partition by supplier_id
order by creation_date)) as diff_date

from purchase_orders;

-- Нaйдите самую раннюю дату submitted_date для каждого менеджера created_by. 
-- Решите данное задание использую оконные функции MIN и FIRST VALUE. Сравните результаты.

select created_by, submitted_date,
  min(submitted_date) over (partition by created_by) as earliest_date1,
  first_value(submitted_date) over (partition by created_by order by submitted_date) as earliest_date2
from purchase_orders;


-- Таблица purchase_order_details
-- 1. Для каждого product_id выведите дату его получения date_received, 
-- предыдущую и последующую даты получения этого продукта. 
-- Оставьте только строки где date_received не является пропуском.




-- 2. Найдите время отправки заказа date_received и время отправки предыдущего заказа. Для начала оставьте только уникальные пары purchase_order_id, date_received и отфильтруйте строки, там где date_received не указано. Запишите результат в CTE и дальше работайте с ним.

-- 3. Выведите максимальное количество quantity и минимальный unit_cost для каждого inventory_id с помощью функции FIRTS VALUE.

-- 4. Выведите одно значения – насколько в среднем отличается unit_cost для каждой строки от максимального unit_cost.

-- 5. Выберите ТОП 5 продуктов с максимальным quantity, используя DENSE RANK.

-- 6. Пронумеруйте строки в соответствии с убывание inventory_id. Выведите только 13 строчку.