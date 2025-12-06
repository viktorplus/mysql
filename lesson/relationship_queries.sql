create schema 101025__group_relationships;
use 101025__group_relationships;

-- One-to-One
CREATE TABLE IF NOT EXISTS Person (
    id INT PRIMARY KEY,
    Name VARCHAR(35)
);

CREATE TABLE IF NOT EXISTS Passport (
    id INT PRIMARY KEY,
    Passport_number VARCHAR(75) UNIQUE,
    Person_id INT UNIQUE,
    FOREIGN KEY (Person_id) REFERENCES Person(id)
);

-- One-to-Many
CREATE TABLE IF NOT EXISTS User (
    id INT PRIMARY KEY,
    Name VARCHAR(25)
);

CREATE TABLE IF NOT EXISTS `Order` (
    id INT PRIMARY KEY,
    Created_at DATE,
    User_id INT,
    FOREIGN KEY (User_id) REFERENCES User(id)
);

-- Many-to-Many
CREATE TABLE IF NOT EXISTS Student (
    id INT PRIMARY KEY,
    Name VARCHAR(35)
);

CREATE TABLE IF NOT EXISTS Course (
    id INT PRIMARY KEY,
    Name VARCHAR(75)
);

CREATE TABLE IF NOT EXISTS StudentCourse (
    Student_id INT,
    Course_id INT,
    FOREIGN KEY (Student_id) REFERENCES Student(id),
    FOREIGN KEY (Course_id) REFERENCES Course(id),
    PRIMARY KEY (Student_id, Course_id)
);