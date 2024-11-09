--Напишите скрипт, который с помощью цикла и переменной выводит таблицу умножения для заданного числа.

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
SET @SumCount = 1000.00;

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
DECLARE @Year INT;

-- Создаем временную таблицу для хранения результатов
CREATE TABLE TopProducts (
    Year INT,
    ProductID INT,
    TotalQuantity INT
);

-- Цикл по годам
DECLARE @StartYear INT = 2000; -- Задайте начальный год
DECLARE @EndYear INT = 2023;   -- Задайте конечный год

WHILE @StartYear <= @EndYear
BEGIN
    SET @Year = @StartYear;
	-- Подзапрос для нахождения самого продаваемого товара за текущий год
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

-- Вывод результатов
SELECT 
    Year,
    ProductID,
    TotalQuantity
FROM 
    TopProducts
ORDER BY 
    Year;

-- Удаляем временную таблицу
DROP TABLE TopProducts;


