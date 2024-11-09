--�������� ������, ������� � ������� ����� � ���������� ������� ������� ��������� ��� ��������� �����.

DECLARE @ourNumber INT;
DECLARE @Counter INT;
DECLARE @Result INT;
SET @ourNumber=9;
SET @Counter=1;

CREATE TABLE MyResult (
						MyNumber INT,
						MyCounter INT,
						Result INT
					   );

WHILE @Counter <= 20
BEGIN
	SET @Result= @Counter * @ourNumber;
	INSERT INTO MyResult (MyNumber, MyCounter, Result)
	VALUES (@ourNumber, @Counter, @Result)
	SET @Counter=@Counter+1
END

SELECT * FROM MyResult;

DROP TABLE MyResult;


--�������: HumanResources.Employee
--�������� ������: � ������� ���������� ������� ���� �����������, ������� �������� � �������� ������ ��������� ���������� ���.

DECLARE @CountYear INT;
DECLARE @ResultYear DATE;
SET @CountYear = 15;

SET @ResultYear = DATEADD(YEAR, -@CountYear, GETDATE());
--SELECT @ResultYear
SELECT * FROM HumanResources.Employee he
WHERE he.HireDate < @ResultYear


--�������: Sales.Customer, Sales.SalesOrderHeader
--�������� ������: �������� ������ � ���������� � �����������, ����� ����� ���� ��������, ������� ��������� � ����� ������ �������� ����� �� ��� ���� ������.

DECLARE @SumCount DECIMAL(18,2);
SET @SumCount = 1000.00;

SELECT sc.CustomerID,sc.AccountNumber, res.SumPerson
FROM Sales.Customer sc
JOIN (
	  SELECT soh.CustomerID,SUM(soh.TotalDue) as SumPerson
	  FROM Sales.SalesOrderHeader soh
	  GROUP BY soh.CustomerID
	 ) res ON res.CustomerID=sc.CustomerID
WHERE res.SumPerson > @SumCount

--�������: 
--Sales.SalesOrderDetail
--Sales.SalesOrderHeader
--Production.Product
--�������� ������: �������� ������, ������� � �������������� ���������� � ���������� ���������� ����� ����������� ����� (�� ���������� ��������� ������) ��� ������� ����.
DECLARE @Year INT;

-- ������� ��������� ������� ��� �������� �����������
CREATE TABLE TopProducts (
    Year INT,
    ProductID INT,
    TotalQuantity INT
);

-- ���� �� �����
DECLARE @StartYear INT = 2000; -- ������� ��������� ���
DECLARE @EndYear INT = 2023;   -- ������� �������� ���

WHILE @StartYear <= @EndYear
BEGIN
    SET @Year = @StartYear;
	-- ��������� ��� ���������� ������ ������������ ������ �� ������� ���
    INSERT INTO TopProducts (Year, ProductID, TotalQuantity)
    SELECT TOP 1 
		   YEAR(soh.OrderDate) AS Year
		 , sod.ProductID
		 , SUM(sod.OrderQty) AS TotalQuantity
    FROM Sales.SalesOrderHeader AS soh
    JOIN Sales.SalesOrderDetail AS sod ON soh.SalesOrderID = sod.SalesOrderID
    WHERE YEAR(soh.OrderDate) = @Year
    GROUP BY sod.ProductID,soh.OrderDate
    ORDER BY  TotalQuantity DESC;
    SET @StartYear = @StartYear + 1;
END

-- ����� �����������
SELECT 
    Year,
    ProductID,
    TotalQuantity
FROM 
    TopProducts
ORDER BY 
    Year;

-- ������� ��������� �������
DROP TABLE TopProducts;


