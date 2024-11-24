/*Задание
Вы работаете с базой данных интернет-магазина, которая содержит следующие таблицы:

CREATE TABLE Categories ( -- категории
	ID INT PRIMARY KEY, -- уникальный идентификатор категории
	Name VARCHAR (50) NOT NULL -- название категории
);

CREATE TABLE Products ( -- товары
	ID INT PRIMARY KEY, -- уникальный идентификатор товара;
	Name VARCHAR(50), -- название товара;
	Category_ID INT NOT NULL, -- идентификатор категории товара;
	Price DECIMAL NOT NULL -- цена товара.
	CONSTRAINT FK_Category_ID FOREIGN KEY (Category_ID) REFERENCES Categories(ID) ON DELETE CASCADE,
);

CREATE TABLE Orders ( -- заказы
	ID INT PRIMARY KEY, -- уникальный идентификатор заказа
	Customer_ID INT NOT NULL, -- идентификатор клиента
	Order_Date DATE NOT NULL -- дата заказа
);

CREATE TABLE Order_Items ( --товары в заказах
	Order_ID INT NOT NULL, -- идентификатор заказа
	Product_ID INT NOT NULL, -- идентификатор товара
	Quantity INT NOT NULL -- количество единиц товара в заказе
	CONSTRAINT FK_Product_ID FOREIGN KEY (Product_ID) REFERENCES  Products(ID) ON DELETE CASCADE,
	CONSTRAINT FK_Order_ID FOREIGN KEY (Order_ID) REFERENCES  Orders(ID) ON DELETE CASCADE,
);

DROP TABLE [dbo].[Order_Items]
DROP TABLE [dbo].[Products]
DROP TABLE [dbo].[Categories]
DROP TABLE [dbo].[Orders]

DELETE [dbo].[Categories]
DELETE [dbo].[Order_Items]
DELETE [dbo].[Orders]
DELETE [dbo].[Products]
*/

/*
Исходная задача:
Напишите SQL-запрос, который для каждой категории товаров показывает:

Название категории.
Общую сумму продаж (количество × цена).
Количество проданных товаров.
Среднюю цену проданных товаров.
Отсортируйте результат по убыванию общей суммы продаж.

Задание:
Напишите исходный запрос для решения задачи.
Проверьте его производительность, используя данные объемом не менее 100 000 записей в таблицах order_items и products.
Оптимизируйте запрос:
Используйте индексы.
Проверьте план выполнения (EXPLAIN).
Перепишите запрос так, чтобы он выполнялся быстрее.
*/
/*
DROP INDEX IX_Product_ID ON Order_Items 
DROP INDEX IX_Quantity ON Order_Items 
DROP INDEX IX_ID ON Categories 
DROP INDEX IX_ID ON Products 
DROP INDEX IX_Category_ID ON Products 
*/

CREATE NONCLUSTERED INDEX IX_Product_ID ON Order_Items (Product_ID)
CREATE NONCLUSTERED INDEX IX_Quantity ON Order_Items (Quantity)  --1 помог ускорить
CREATE NONCLUSTERED INDEX IX_ID ON Categories (ID)
CREATE NONCLUSTERED INDEX IX_Name ON Categories (Name) -- 2 помог ускорить
CREATE NONCLUSTERED INDEX IX_Price ON Products (Price) -- 3 помог ускорить
CREATE NONCLUSTERED INDEX IX_ID ON Products (ID)
CREATE NONCLUSTERED INDEX IX_Category_ID ON Products (Category_ID)

SELECT * FROM [dbo].[Categories]
SELECT * FROM [dbo].[Order_Items]
SELECT * FROM [dbo].[Orders]
SELECT * FROM [dbo].[Products]

SET STATISTICS TIME ON;

SELECT cg.Name
	 , SUM (pd.Price * oi.Quantity) as TotalSum
	 , COUNT(oi.Quantity) as TotalCount
	 , AVG(pd.Price) as AvgPrice
FROM Categories cg
JOIN Products pd ON pd.Category_ID=cg.ID
JOIN Order_Items oi ON oi.Product_ID=pd.ID
GROUP BY cg.ID,cg.Name
ORDER BY TotalCount desc

SET STATISTICS TIME OFF;