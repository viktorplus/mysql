/*
SET SQL_SAFE_UPDATES =0;

1. Создать таблицу Employees со следующими столбцами:
● EmployeeID
● FirstName
● LastName
● BirthDate
● HireDate
● Salary
● Email
2. Указать ограничения
● EmployeeID - первичный ключ, увеличивается автоматически на 1 при добавлении записи
● FirstName и LastName - строка длиной в 50 символов Не может быть пустой
● BirthDate - дата
● HireDate - дата по умолчанию указывается текущая дата
● Salary - число с количеством цифр 2 после запятой Общее число знаков, включая запятую, 10 Должна быть
больше 0
● Email - строка длиной в 100 символов Должна быть уникальной
*/

CREATE DATABASE IF NOT EXISTS 101025_viktor;
USE 101025_viktor;
CREATE TABLE IF NOT EXISTS Employees(
	id INT PRIMARY KEY AUTO_INCREMENT, 
	FirstName VARCHAR(50) NOT NULL,
	LastName VARCHAR(50) NOT NULL,
	BirthDate DATE,
	HireDate DATE DEFAULT (current_date),
	Salary DECIMAL(10, 2) CHECK (Salary > 0),
	Email VARCHAR(100) UNIQUE
);

/*3. Обновить схему, чтобы убедиться, что таблица появилась в базе данных.
4. Найти базу данных и раскрыть вкладку Tables.
5. Заполнить пустую таблицу значениями. При заполнении стоит учитывать, какие ограничения стоят на том
или ином столбце - если Вы попытаетесь вставить значение, не соответствующее ограничению, то SQL
покажет ошибку.*/

SELECT * FROM Employees;
INSERT INTO Employees(FirstName, LastName, BirthDate, Salary, Email)
VALUES("Viktor", "Khomenko", "1978-04-08", 50000, "viktorplus3@mail.com");

INSERT INTO Employees
	(FirstName, LastName, BirthDate, Salary, Email)
VALUES
	("Viktor", "Khomenko", "1978-04-08", 50000, "viktorplus1@mail.com"),
	("Viktor2", "Khomenko2", "1978-04-08", 50000, "viktorplus2@mail.com");

INSERT INTO Employees (FirstName, LastName, BirthDate, Salary, Email)
VALUES ('Alice', 'Green', '1985-05-15', 55000.00, 'alice.green@example.com'),
('Bob', 'Smith', '1990-08-22', 60000.00, 'bob.smith@example.com'),
('Charlie', 'Johnson', '1988-02-10', 52000.00, 'charlie.johnson@example.com'),
('Diana', 'Williams', '1992-11-01', 58000.00, 'diana.williams@example.com'),
('Edward', 'Brown', '1987-09-30', 61000.00, 'edward.brown@example.com');

DELETE FROM 101025_viktor.Employees
WHERE id = 6;

SET SQL_SAFE_UPDATES =0;
DELETE FROM 101025_viktor.Employees;

TRUNCATE TABLE 101025_viktor.Employees;
DELETE FROM `101025_viktor`.`Employees`;


UPDATE Employees
	SET Salary = 65000
WHERE id  = 1;

