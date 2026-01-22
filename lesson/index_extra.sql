SHOW INDEX FROM world.city;
SHOW INDEX FROM world.city2;


-- 0. Скопировать структуру (без ограничений, но с данными)
create table city2 as
SELECT * FROM world.city;

-- 1. Скопировать структуру (без данных)
CREATE TABLE city2 LIKE world.city;

-- 2. Вставить данные
INSERT INTO city2 SELECT * FROM world.city;

-- 3. Создать новый индекс
CREATE INDEX idx_population ON city2(Population);
CREATE INDEX idx_name_population ON city2 (name, Population);

-- 4. Удалить индекс
ALTER TABLE city2 DROP INDEX idx_population;
ALTER TABLE city2 DROP PRIMARY KEY;

SHOW INDEXES FROM city2;

-- ---------------------------------------------------
SELECT Population FROM world.city
WHERE Population = 100231;

SELECT Population FROM world.city2
WHERE Population = 100231;

EXPLAIN SELECT * FROM city
WHERE Population = 100231;

EXPLAIN SELECT * FROM city2 
WHERE Population = 100231;

EXPLAIN SELECT * FROM city2 
WHERE name = "Sharja";
-- В результате будет видно, какой тип доступа используется:
-- ALL — полный просмотр таблицы (индекс не используется)
-- range, ref, const — используется индекс

-- --------------------------------------------

### Когда индекс стоит использовать?

-- Частые `SELECT` по определённому столбцу.
-- Фильтрация по диапазону (`BETWEEN`, `>`, `<`).
-- `JOIN`-ы по внешнему ключу.
-- Частые `ORDER BY` / `GROUP BY` по колонке.


-- id            : порядок выполнения SELECT (больше = раньше)
-- select_type   : тип запроса (SIMPLE, PRIMARY, SUBQUERY, DERIVED, UNION)
-- table         : таблица или её алиас
-- partitions    : используемые партиции (NULL — нет партиций)
-- type          : тип доступа к данным (const, ref, range, ALL и т.д.)
-- possible_keys : индексы, которые могли бы подойти
-- key           : индекс, который реально используется
-- key_len       : сколько байт индекса используется
-- ref           : с чем сравнивается индекс (const, колонка, NULL)
-- rows          : сколько строк MySQL планирует прочитать
-- filtered      : % прочитанных строк, прошедших WHERE
-- Extra         : доп. операции (Using index, Using where, Using filesort и т.п.)


-- --------------------------------------------------
USE 101025__group;
DELIMITER //

CREATE FUNCTION get_discount(price DECIMAL(10,2), discount_percent INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
	RETURN price - (price * discount_percent / 100);
END //

CREATE FUNCTION get_minute()
RETURNS INT
NOT DETERMINISTIC
BEGIN
    RETURN minute(now());
END //

DELIMITER ;

SELECT get_discount(1000, 15), get_minute();  -- результат: 850.00
SELECT *, get_discount(salary, 15) from hr.employees;


