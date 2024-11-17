/*
����: �������� �������� ���������, ������� ����������� ���������� ������� �� ������ � ������� ��� ������� ������ ����� ����������.

��������:
��������� ������:

���������� ����� ���������� ������� ������ �� ������.
��������� ��������� � ������� ProductInventorySummary, ��� ����� ��������� ProductID � TotalQuantity (����� ���������� ������� ������ �� ������).
��� ��������� ������ ������������ ���� WHILE.
������������ �������:
Production.ProductInventory: �������� ������ � ������� ������� �� ������, ������� ProductID � Quantity.
������:
��� ������� ������ ����� ��������� ����� ���������� � ������ ���� ������� � ������� ProductInventory.
������� ������� ��� �������� �����������.
�����, ��������� ����, ��������� ������� � ������ ������� ��� ������� ������.
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
    -- �������� ������������ ProductID
    SELECT @MaxProductID = MAX(ProductID) FROM Production.ProductInventory
	-- ������� ������� ����� �������� �����������
    TRUNCATE TABLE ProductInventorySummary; 
	-- ���� WHILE ��� ��������� ������
    WHILE @CurrentProductID <= @MaxProductID
    BEGIN
        -- �������� ����� ���������� ��� �������� ProductID
        SELECT @TotalQuantity = SUM(Quantity)
        FROM Production.ProductInventory
        WHERE ProductID = @CurrentProductID;		     
        -- ��������� ���������� � �������
        INSERT INTO ProductInventorySummary (ProductID, TotalQuantity)
        VALUES (@CurrentProductID, @TotalQuantity);
		-- ������� NULL ������ (����� ������ CurrentProductID ��� � ������� )
		DELETE ProductInventorySummary
		WHERE TotalQuantity IS NULL
        -- ������� � ���������� ProductID
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