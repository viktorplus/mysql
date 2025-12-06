-- Выведите в одну общую выборку из таблиц customers и employees имена и фамилии клиентов и сотрудников.
SELECT * FROM northwind.customers;
SELECT * FROM northwind.employees;

-- not the same columns count 
SELECT * FROM northwind.customers
union all
SELECT * FROM northwind.employees;

SELECT first_name, last_name, email_address FROM northwind.customers
union all
SELECT first_name, last_name, email_address FROM northwind.employees;

SELECT job_title FROM northwind.customers
union all
SELECT job_title FROM northwind.employees;

SELECT job_title FROM northwind.customers
union
SELECT job_title FROM northwind.employees;

SELECT id, job_title, email_address as extra_info, 'customers' as `type` FROM northwind.customers
union all
SELECT id, job_title, business_phone, 'employees' FROM northwind.employees;

SELECT job_title, 'customers' as `type` FROM northwind.customers
union
SELECT job_title, 'employees' FROM northwind.employees;

-- нет смысла
SELECT id, job_title, "text" FROM northwind.employees;
--------------------
-- Выведите все строки из объединенных таблиц employees и employee_privileges с помощью INNER/RIGHT и LEFT JOIN. Объясните полученные результаты.

-- --------------- inner
SELECT * 
FROM employees
inner join employee_privileges
on employees.id = employee_privileges.employee_id;

SELECT * 
FROM employees as emp
inner join employee_privileges as emp_pr
on emp.id = emp_pr.employee_id;

SELECT employees.id, company, last_name, first_name, job_title, privilege_id -- , employee_id,  
FROM employees
inner join employee_privileges
on employees.id = employee_privileges.employee_id;

-- --------------- left
SELECT employees.id, company, last_name, first_name, job_title, employee_id, privilege_id 
FROM employees 
left join employee_privileges
on employees.id = employee_privileges.employee_id;
-- WHERE employee_id IS NULL;

-- --------------- right
SELECT employees.id, company, last_name, first_name, job_title, employee_id, privilege_id 
FROM employees
right join employee_privileges
on employees.id = employee_privileges.employee_id;

-- ------------------- hr 

SELECT * FROM hr.employees;
SELECT * FROM hr.departments;

-- inner
SELECT * 
FROM hr.employees
join departments
on employees.department_id = departments.department_id;

-- left
SELECT * 
FROM hr.employees
left join departments
on employees.department_id = departments.department_id;

-- right
SELECT * 
FROM hr.employees
right join departments
on employees.department_id = departments.department_id;


SELECT employee_id, first_name, last_name, email, phone_NUMERIC, job_id, salary, commission_pct, employees.manager_id as emp_man, 
employees.department_id, hire_date, 
departments.department_id, department_name, departments.manager_id as dep_man, location_id 
FROM hr.employees
right join departments
on employees.department_id = departments.department_id;

-- cross
SELECT * 
FROM hr.employees
cross join departments;

SELECT * 
FROM hr.employees, departments;

-- full
SELECT * 
FROM hr.employees
left join departments
on employees.department_id = departments.department_id
UNION ALL
SELECT * 
FROM hr.employees
right join departments
on employees.department_id = departments.department_id
WHERE employees.department_id IS NULL;