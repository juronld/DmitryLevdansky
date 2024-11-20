/*Создайте базу данных для управления библиотекой, используя MS SQL и Python. Реализуйте скрипты/скрипт на Python, которые:
Подключаются к MS SQL Server.
Создают базу данных Library.
В базе данных создают таблицы с констрейнтами:
Вставляют тестовые данные в таблицы (нужно создать тестовые наборы данных из минимум трех строк)*/

--создание БД
--CREATE DATABASE Library_db;

USE Library_db

CREATE TABLE Books (
	BookID INT PRIMARY KEY,
	Title VARCHAR(255) NOT NULL,
	Author VARCHAR(255) NOT NULL,
	PublishedYear INT, CHECK (PublishedYear > 1800)
)

CREATE TABLE Borrowers (
	BorrowerID INT PRIMARY KEY,
	Name VARCHAR(255) NOT NULL,
	Email VARCHAR(255) UNIQUE
)

CREATE TABLE Loans (
	LoanID INT PRIMARY KEY,
	BookID INT NOT NULL,
	BorrowerID INT NOT NULL,
	LoanDate DATE NOT NULL,
	ReturnDate DATE,
	CONSTRAINT FK_BookID FOREIGN KEY (BookID) REFERENCES Books(BookID) -- Ограничение FOREIGN KEY
	ON DELETE CASCADE, -- Автоматическое удаление связанных записей
	CONSTRAINT FK_BorrowerID FOREIGN KEY (BorrowerID) REFERENCES Borrowers(BorrowerID) -- Ограничение FOREIGN KEY
	ON DELETE CASCADE, -- Автоматическое удаление связанных записей
)

--DROP TABLE Loans
--DELETE Books
SELECT * FROM Books
SELECT * FROM Borrowers
SELECT * FROM Loans