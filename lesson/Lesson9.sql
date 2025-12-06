

-- CASE
--  WHEN условие1 THEN результат1
--  WHEN условие2 THEN результат2
--  ...
--  ELSE результатN
-- END

USE hr;
SELECT * FROM hr.employees;

-- if < 5000 -> + 100%
-- if 5000 <= salary < 10000 -> + 50%
-- if 10000 <= salary < 15000 -> + 20%
-- other + 0%
SELECT 
	employee_id, first_name, last_name, 
    salary as current_salary,
    CASE
		WHEN salary < 5000 THEN salary * 2
		WHEN salary < 10000 THEN salary * 1.5
		WHEN salary < 15000 THEN salary * 1.2
        ELSE salary
    END as new_salary
FROM employees;

SELECT 
	employee_id, first_name, last_name, 
    salary as current_salary,
    IF(
		salary < 5000, 
        salary * 2, 
        IF(
			salary < 10000, 
            salary * 1.5, 
            IF(
				salary < 15000, 
                salary * 1.2, 
                salary))),
    CASE
		WHEN salary < 5000 THEN salary * 2
		WHEN salary < 10000 THEN salary * 1.5
		WHEN salary < 15000 THEN salary * 1.2
        ELSE salary
    END as new_salary
FROM employees;

SELECT 
	employee_id, 
    CONCAT(first_name, " ", last_name), 
    CONCAT_WS(" ", employee_id, first_name, last_name), 
    salary as current_salary,
    CASE
		WHEN salary < 5000 THEN salary * 2
		WHEN salary < 10000 THEN salary * 1.5
		WHEN salary < 15000 THEN salary * 1.2
        ELSE salary
    END as new_salary
FROM employees;

SELECT 
	employee_id, first_name, last_name, 
	salary as full_salary,
    commission_pct,
	salary - salary * coalesce(commission_pct, 0) as salary_after_commission
FROM employees;

SELECT 
	employee_id, first_name, last_name, 
	salary as full_salary,
    commission_pct,
	coalesce(commission_pct, 0) as commission
FROM employees;


SELECT 
	employee_id, first_name, last_name, 
	salary as full_salary,
    commission_pct,
	salary * coalesce(1 - commission_pct, 1) as salary_after_commission
FROM employees;