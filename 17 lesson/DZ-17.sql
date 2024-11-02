/*
--CREATE TABLE Student (student_id INT PRIMARY KEY, name_student VARCHAR(50),course_id INT, FOREIGN KEY (course_id) REFERENCES Courses (course_id))
/*INSERT INTO Student
VALUES (1, 'Alice', 101),
	   (2, 'Bob', 102),
	   (3, 'Charlie', 101),
	   (4, 'Dave', 103)*/

SELECT * FROM Student	
--CREATE TABLE Courses (course_id INT PRIMARY KEY, course_name VARCHAR(50), teacher VARCHAR(50))
/*INSERT INTO Courses
VALUES (101, 'Math', 'Mr.Brown'),
	   (102, 'Phusics', 'Dr.Green'),
	   (103, 'Chemistry', 'Ms.White')*/
	   
SELECT * FROM Courses


SELECT s.student_id, s.name_student, s.course_id, c.course_name, c.teacher
FROM Student s
JOIN Courses c ON s.course_id=c.course_id
*/

--�������� ������, ����� �������� ����� ����������� � �������� ���������, ������� ��� ���������� (Purchasing.ProductVendor, Purchasing.Vendor, Production.Product)

SELECT distinct pv.Name,pp.Name
FROM [Production].[Product] pp
JOIN [Purchasing].[ProductVendor] ppv ON ppv.ProductID=pp.ProductID
JOIN [Purchasing].[Vendor] pv ON pv.BusinessEntityID=ppv.BusinessEntityID

--�������� ������, ������� ������� ����� ���������� �� ��������, �� ������� � ����������, �� ������� ��� �������� (Sales.SalesPerson, Person.Person, Sales.SalesTerritory)

SELECT per.FirstName,per.LastName,sal.Name
FROM Sales.SalesPerson ss
JOIN Person.Person per ON ss.BusinessEntityID=per.BusinessEntityID
JOIN Sales.SalesTerritory sal ON ss.TerritoryID=sal.TerritoryID
ORDER BY per.FirstName

--�������� ������, ������� ������� ID ������, ���� ������, � ����� ����� ��������, ������� ����� � �������� ������. (Sales.SalesOrderHeader, Person.BusinessEntityAddress, Person.Address)
SELECT salo.SalesOrderID, salo.ShipDate, pa.AddressLine1, pa.City, pa.PostalCode
FROM Sales.SalesOrderHeader salo
JOIN Person.BusinessEntityAddress pba ON salo.ShipToAddressID=pba.AddressID
JOIN Person.Address pa ON pa.AddressID=pba.AddressID

--�������� ������, ����� �������� ID ��������, ��� �������� � �������� ���������, � ������� �� ���������. (Production.Product, Production.ProductSubcategory, Production.ProductCategory)

SELECT p1.ProductID, p1.Name as '������������ ��������', pc.Name as '������������ ���������', pps.Name as '������������ ������������'
FROM Production.Product p1
JOIN Production.ProductSubcategory pps ON p1.ProductSubcategoryID=pps.ProductSubcategoryID
JOIN Production.ProductCategory pc ON pc.ProductCategoryID=pps.ProductCategoryID

--�������� ������, ������� ������� ������ ����������� � ��������� �� �����, ������� � �������� ������, � ������� ��� ��������. (HumanResources.Employee, Person.Person, HumanResources.EmployeeDepartmentHistory, HumanResources.Department)

SELECT per1.FirstName,per1.LastName, hd.Name
FROM Person.Person per1
JOIN HumanResources.Employee he ON per1.BusinessEntityID=he.BusinessEntityID
JOIN HumanResources.EmployeeDepartmentHistory hed ON hed.BusinessEntityID=he.BusinessEntityID
JOIN HumanResources.Department hd ON hed.DepartmentID=hd.DepartmentID
ORDER BY per1.FirstName

--�������� ������, ����� ������� ������ �����������, ������������ ���������, ������� ����������� � ���������� �������. ���������� ��� � ������� ����������, ID ������, ��� �������, ���������� � ����� �������� (������� ����� � �������� ������). 
--�������� � ���������� ���� �����������, ���������� �� ����, ���� �� � ��� ������ ��� ��� (����������� LEFT JOIN) (Sales.SalesPerson, Person.Person, Sales.SalesOrderHeader,Sales.Customer, Person.Person, Sales.SalesTerritory,Person.BusinessEntityAddress, Person.Address)


--�������� ������, ����� ����� ��� ��������, ������� ��, � ������� ��� ������������������ �����������. �������� ID ��������, �������� ��������, �������� ��������� � ��� ���������� (���� �� ����). 
--����������� LEFT JOIN ��� ����������� ��������� ���� ��������� � ���������. (Production.Product, Production.ProductSubcategory, Production.ProductCategory, Purchasing.ProductVendor, Purchasing.Vendor)
