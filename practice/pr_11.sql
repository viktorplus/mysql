-- use `101025__group`;
-- Создайте таблицу students с такими столбцами: id (INT), name (VARCHAR), age (INT), grade (DECIMAL).
-- Заполните таблицу несколькими строками.
-- Создайте индекс на столбец age, чтобы ускорить поиск по возрасту.
-- Напишите запрос, который выбирает всех студентов определенного возраста.
-- Просмотрите план выполнения запроса с помощью команды EXPLAIN.

CREATE SCHEMA IF NOT EXISTS `101025_ptm`;
USE `101025_ptm`;

CREATE TABLE students2 (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50) NOT NULL,
age INT NOT NULL CHECK (age > 0),
grade DECIMAL(5,2)  CHECK (grade > 0 AND grade <= 100)
);

-- CREATE TABLE students3 (
-- id INT AUTO_INCREMENT PRIMARY KEY,
-- name VARCHAR(50) NOT NULL,
-- age INT NOT NULL CHECK (age > 0),
-- grade DECIMAL(3,2)
-- );

-- ALTER TABLE students3 ADD CONSTRAINT check_grade_1 CHECK (grade > 0 AND grade <= 100);
-- ALTER TABLE students3 MODIFY COLUMN grade DECIMAL(4,2);


-- ALTER TABLE students3 drop CONSTRAINT check_grade_1;
-- ALTER TABLE students3 ADD CONSTRAINT check_grade_1 CHECK (grade > 0 AND grade <= 12);

CREATE INDEX idx_students_age ON students2 (age);

INSERT INTO students2 (name, age, grade)
VALUES
  ('Alice', 20, 88),
  ('Bob', 30, 100),
  ('Charlie', 19, 40),
  ('Diana', 30, 75),
  ('Edward', 18, 80);

SELECT *
FROM 101025_ptm_viktor2.students2;

EXPLAIN SELECT * FROM 101025_ptm_viktor2.students2 WHERE age = 30;