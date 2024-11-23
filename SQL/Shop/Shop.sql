/*Задание

Вы работаете с базой данных интернет-магазина, которая содержит следующие таблицы:

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

DROP TABLE [dbo].[Categories]
DROP TABLE [dbo].[Order_Items]
DROP TABLE [dbo].[Orders]
DROP TABLE [dbo].[Products]

DELETE [dbo].[Categories]
DELETE [dbo].[Order_Items]
DELETE [dbo].[Orders]
DELETE [dbo].[Products]
*/

SELECT * FROM [dbo].[Categories]
SELECT * FROM [dbo].[Order_Items]
SELECT * FROM [dbo].[Orders]
SELECT * FROM [dbo].[Products]