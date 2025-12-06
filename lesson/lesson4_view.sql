SELECT * FROM 101025__group.Employees;

CREATE VIEW employees_view AS
SELECT * FROM Employees;

CREATE VIEW employees_name_view AS
SELECT FirstName, LastName FROM Employees;

CREATE VIEW employees_tax_view AS
SELECT EmployeeID, FirstName, LastName, Salary, Salary * 0.4 as Tax, Salary * 1.4 as Total FROM Employees;

INSERT INTO Employees (FirstName, LastName, BirthDate, Salary, Email)
VALUES ('Edward', 'Black', '1987-09-30', 61000.00, 'edward.black@example.com');

INSERT INTO Employees (FirstName, LastName, BirthDate, Salary, Email)
VALUES ('Bob', 'Black', '1997-09-30', 61000.00, 'bob.black@example.com');

SELECT FirstName, LastName, Salary, Tax, Total FROM employees_tax_view;