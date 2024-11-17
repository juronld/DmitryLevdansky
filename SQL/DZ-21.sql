/*
Цель: Написать хранимую процедуру, которая анализирует количество товаров на складе и выводит для каждого товара общее количество.

Описание:
Процедура должна:

Подсчитать общее количество каждого товара на складе.
Результат сохранить в таблице ProductInventorySummary, где будут храниться ProductID и TotalQuantity (общее количество данного товара на складе).
Для обработки данных использовать цикл WHILE.
Используемые таблицы:
Production.ProductInventory: Содержит данные о наличии товаров на складе, включая ProductID и Quantity.
Логика:
Для каждого товара нужно вычислить общее количество с учетом всех записей в таблице ProductInventory.
Создаем таблицу для хранения результатов.
Затем, используя цикл, обновляем таблицу с общими данными для каждого товара.
*/
DROP TABLE ProductInventorySummary
CREATE TABLE ProductInventorySummary (
    ProductID INT PRIMARY KEY,
    TotalQuantity INT
);

ALTER PROCEDURE CalculateProductInventory	
AS
BEGIN
    DECLARE @MaxProductID INT;
    DECLARE @CurrentProductID INT;
    DECLARE @TotalQuantity INT;
    -- Получаем максимальный ProductID
    SELECT @MaxProductID = MAX(ProductID) FROM Production.ProductInventory
	-- Очищаем таблицу перед вставкой результатов
    TRUNCATE TABLE ProductInventorySummary; 
	-- Цикл WHILE для обработки данных
    WHILE @CurrentProductID <= @MaxProductID
    BEGIN
        -- Получаем общее количество для текущего ProductID
        SELECT @TotalQuantity = SUM(Quantity)
        FROM Production.ProductInventory
        WHERE ProductID = @CurrentProductID;		     
        -- Вставляем результаты в таблицу
        INSERT INTO ProductInventorySummary (ProductID, TotalQuantity)
        VALUES (@CurrentProductID, @TotalQuantity);
		-- Удаляем NULL записи (когда такого CurrentProductID нет в таблице )
		DELETE ProductInventorySummary
		WHERE TotalQuantity IS NULL
        -- Переход к следующему ProductID
        SET @CurrentProductID = @CurrentProductID + 1;
    END;
END;

/*
SELECT  pp.ProductID
	,  SUM(pp.Quantity) as TotalQuantity
FROM Production.ProductInventory pp
GROUP BY pp.ProductID
*/

EXEC CalculateProductInventory

SELECT * FROM ProductInventorySummary