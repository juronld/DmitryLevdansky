--Напишите скрипт, который с помощью цикла и переменной выводит таблицу умножения для заданного числа.
CREATE TABLE MyResult (
						MyNumber INT,
						MyCounter INT,
						Result INT
					   );

DECLARE @ourNumber INT;
DECLARE @Counter INT;
DECLARE @Result INT;
SET @ourNumber=9;
SET @Counter=1;

DELETE MyResult
WHILE @Counter <= 20
BEGIN
	SET @Result= @Counter * @ourNumber;
	INSERT INTO MyResult (MyNumber, MyCounter, Result)
	VALUES (@ourNumber, @Counter, @Result)
	SET @Counter=@Counter+1
END

SELECT * FROM MyResult;

--DROP TABLE MyResult;


--Таблицы: HumanResources.Employee
--Описание задачи: С помощью переменной найдите всех сотрудников, которые работают в компании дольше заданного количества лет.

DECLARE @CountYear INT;
DECLARE @ResultYear DATE;
SET @CountYear = 15;

SET @ResultYear = DATEADD(YEAR, -@CountYear, GETDATE());
--SELECT @ResultYear
SELECT * FROM HumanResources.Employee he
WHERE he.HireDate < @ResultYear


--Таблицы: Sales.Customer, Sales.SalesOrderHeader
--Описание задачи: Напишите запрос с переменной и подзапросом, чтобы найти всех клиентов, которые потратили в сумме больше заданной суммы на все свои заказы.

DECLARE @SumCount DECIMAL(18,2);
SET @SumCount = 3000.00;

SELECT sc.CustomerID,sc.AccountNumber, res.SumPerson
FROM Sales.Customer sc
JOIN (
	  SELECT soh.CustomerID,SUM(soh.TotalDue) as SumPerson
	  FROM Sales.SalesOrderHeader soh
	  GROUP BY soh.CustomerID
	 ) res ON res.CustomerID=sc.CustomerID
WHERE res.SumPerson > @SumCount

--Таблицы: 
--Sales.SalesOrderDetail
--Sales.SalesOrderHeader
--Production.Product
--Описание задачи: Напишите запрос, который с использованием переменной и подзапроса определяет самый продаваемый товар (по количеству проданных единиц) для каждого года.
CREATE TABLE Result (ProductName NVARCHAR(MAX)
       , TotalAmount INT
       , OrderYear INT)

--DECLARE @Year INT
--SELECT @Year = 2012
DECLARE @Counter INT
SELECT @Counter = YEAR(MIN(OrderDate))
FROM Sales.SalesOrderHeader

WHILE @Counter <= (SELECT YEAR(MAX(OrderDate)) FROM Sales.SalesOrderHeader)
BEGIN
INSERT INTO Result 
SELECT TOP 1  R.Name
   , R. TotalAmount
   , @Counter
FROM (
SELECT SUM(sod.OrderQty) AS TotalAmount
  , pp.Name
FROM Sales.SalesOrderDetail sod 
JOIN Sales.SalesOrderHeader soh ON soh.SalesOrderID = sod.SalesOrderID
JOIN Production.Product pp ON pp.ProductID = sod.ProductID
WHERE YEAR(soh.OrderDate) = @Counter
GROUP BY pp.Name ) R
ORDER BY R.TotalAmount DESC

SELECT @Counter = @Counter + 1
END
--DELETE Result
SELECT * FROM Result
