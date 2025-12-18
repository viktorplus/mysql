-- 1. Работа с базой данных hr Таблица employees
-- ● Найти всех сотрудников, работающих в департаменте с id 90.
-- ● Найти всех сотрудников, зарабатывающих больше 5000.
-- ● Найти всех сотрудников, чья фамилия начинается на букву L.

USE hr;
SELECT 
CONCAT(first_name, ' ', last_name) as emp_name
FROM
hr.employees
WHERE department_id = 90 
or salary > 5000 
or last_name like 'L%';

-- Сформировать поле SALARY_GROUP которое принимает 
-- значение 1, если зп сотрудника больше 10000 
-- значение 0, если зп сотрудника меньше или равна 10000


SELECT first_name, last_name, salary,
case
when salary >10000 then 1
else 0
end 
AS salary_group FROM employees;

-- Сформировать поле SALARY_GROUP которое принимает 
-- значение 1, если зп сотрудника больше средней 
-- значение 0, если зп сотрудника меньше или равна средней, иначе null

SELECT 
	salary,
	CASE 
		WHEN salary > avg_sal THEN 1
		WHEN salary <= avg_sal THEN 0
		ELSE NULL
	END AS salary_group
FROM hr.employees
JOIN (SElECT AVG(salary) AS avg_sal
FROM hr.employees) AS new_table;

-- 2 способ
SELECT 
	salary,
	CASE 
		WHEN salary > (SElECT AVG(salary)
			FROM hr.employees) THEN 1
		WHEN salary <= (SElECT AVG(salary)
			FROM hr.employees) THEN 0
		ELSE NULL
	END AS salary_group;
    
    
-- Найти среднюю зарплату тех сотрудников, которые зарабатывают меньше 10000.



-- * Найти всех сотрубников из департамента с самым большим количеством сотрудников
SELECT *
FROM employees
WHERE department_id = (SELECT department_id
FROM employees
GROUP BY department_id
ORDER BY COUNT(*) DESC
LIMIT 1);



-- Работа с базой данных Airlines.
-- Вывести среднюю стоимость билета в каждом классе обслуживания (service_class).
USE airport;
SELECT service_class, round(avg(price), 2)
FROM tickets
GROUP BY 1;

-- Работа с базой данных world
-- Выведите список стран с официальными языками.
USE world;
select Name, Language
from country
left join countrylanguage 
on CountryCode = Code
where isOfficial = "T";
