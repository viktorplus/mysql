-- use `101025__group`;
-- Создайте таблицу students с такими столбцами: id (INT), name (VARCHAR), age (INT), grade (DECIMAL).
-- Заполните таблицу несколькими строками.
-- Создайте индекс на столбец age, чтобы ускорить поиск по возрасту.
-- Напишите запрос, который выбирает всех студентов определенного возраста.
-- Просмотрите план выполнения запроса с помощью команды EXPLAIN.

CREATE SCHEMA IF NOT EXISTS `101025_ptm_viktor2`;
USE `101025_ptm_viktor2`;

CREATE TABLE students (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50) NOT NULL,
age INT NOT NULL CHECK (age > 0),
grade DECIMAL(5,2) CHECK (grade > 0 AND grade <= 100)
);

CREATE INDEX idx_age ON students (age);

INSERT INTO students (name, age, grade)
VALUES
('Alice', 20, 88),
  ('Bob', 30, 100),
  ('Charlie', 19, 40),
  ('Diana', 30, 75),
  ('Edward', 18, 80);

SELECT *
FROM 101025_ptm_viktor2.students
WHERE age = 30;

EXPLAIN SELECT * FROM 101025_ptm_viktor2.students WHERE age = 30;


-- ALTER TABLE students3 ADD CONSTRAINT check_grade_1 CHECK (grade > 0 AND grade <= 100);
-- ALTER TABLE students3 MODIFY COLUMN grade DECIMAL(4,2);


-- ALTER TABLE students3 drop CONSTRAINT check_grade_1;
-- ALTER TABLE students3 ADD CONSTRAINT check_grade_1 CHECK (grade > 0 AND grade <= 12);

-- 1. Изменение регистра
-- Создайте функцию для перевода текста в верхний регистр. Функция принимает строку и возвращает её в верхнем регистре, добавив восклицательный знак в конце.
-- Изменение регистра
-- Создайте функцию для перевода текста в верхний регистр. 
-- Функция принимает строку и возвращает её в верхнем регистре, 
-- добавив восклицательный знак в конце.

DELIMITER //
CREATE FUNCTION make_uppercase(user_text VARCHAR(100))
RETURNS VARCHAR(101)
DETERMINISTIC
BEGIN
RETURN CONCAT(UPPER(user_text), "!");
END //

DELIMITER ;

SELECT make_uppercase("new_text");

-- 2. Проверка четности
-- Функция для проверки, является ли число четным. Функция принимает целое число и возвращает 1, если оно четное, и 0, если нечетное.