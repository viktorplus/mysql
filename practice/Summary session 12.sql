-- Создайте хранимую процедуру, которая принимает значение бонуса для сотрудника, 
-- увеличивает его на указанный процент и возвращает новое значение через INOUT-параметр.

-- Слелайте новую процедуру, которая вернет то же значение если план не выполнен 
-- и измененное значение - если план перевыполнен
-- Также передается сумма продаж, а план продаж указан в процедуре как 1000

delimiter //
create procedure increase_employee_bonus(inout bonus decimal(10,2), in percent int)
begin
 set bonus = bonus + (percent / 100) * bonus;
end //
delimiter ;

set @bonus = 900;
call increase_employee_bonus(@bunus, 15);
select @bonus;

-- Слелайте новую процедуру, которая вернет то же значение если план не выполнен 
-- и измененное значение - если план перевыполнен
-- Также передается сумма продаж, а план продаж указан в процедуре как 1000

delimiter //
create procedure increase_employee_bonus_by_sales (inout bonus decimal(10,2), IN sales DECIMAL(20,2), in percent int)
begin
	IF sales > 10000
		THEN SET bonus = bonus + (percent / 100) * bonus;
	END IF;
end //
delimiter ;

set @bonus = 1000;
call increase_employee_bonus_by_sales(@bonus, 20000, 15);
select @bonus;

set @bonus1 = 1000;
call increase_employee_bonus_by_sales(@bonus1, 20000, 15);
select @bonus1;

-- Создайте хранимую процедуру, которая принимает в качестве входного параметра IN employee_id и
-- возвращает в качестве выходного параметра 1 или 0. Если зарплата сотрудника выше средней зарплэты по
-- всем департаментам - 1, в противном случае - 0.

DELIMITER //
CREATE PROCEDURE average_salary (
IN employee_id INT, 
OUT out_average TINYINT
)
BEGIN
	DECLARE average FLOAT;
    DECLARE salary_by_id FLOAT;
    
	SELECT AVG(salary)
    INTO average
	FROM employees;
    
    SELECT salary
    INTO salary_by_id
    FROM employees
	WHERE id = employee_id;
    
    IF salary_by_id > average
    THEN 
		SET out_average = 1;
	ELSE
		SET out_average = 0;
	END IF;

END //

DELIMITER ;

CALL average_salary(3, @outsal);
SELECT @outsal;

