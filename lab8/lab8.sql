use lab_5;

ALTER VIEW [ordersInfo]
AS
    SELECT
        Товар,
        Цена_продажи,
        Количество_заказанного_товара,
        Телефон_клиент
    FROM ЗАКАЗЫ


SELECT *
FROM ordersInfo;



ALTER VIEW [ordersInfo]
AS
    SELECT Товар , Цена_продажи
    FROM ЗАКАЗЫ


DROP VIEW [ordersInfo];


ALTER VIEW [Сравнение Цен]
AS
    SELECT
        ZK.Товар,
        TV.Цена,
        ZK.Цена_продажи 
    FROM ЗАКАЗЫ as ZK 
    INNER JOIN ТОВАРЫ AS TV ON ZK.Товар = TV.Название_товара;


SELECT *
FROM [Сравнение Цен];


CREATE VIEW [Дорогие товары]
(
    Название_товара,
    Цена,
    Количество_на_складе
)
AS
    SELECT Название_товара, Цена, Количество_на_складе
    FROM ТОВАРЫ
    WHERE Цена > 5



SELECT *
FROM [Дорогие товары];

INSERT [Дорогие товары]
VALUES('Греча', 5.2, 12);
INSERT [Дорогие товары]
VALUES('Мармеладки', 6.2, 12);


ALTER VIEW [Дорогие товары]
(
    Название_товара,
    Цена,
    Количество_на_складе
)
AS
    SELECT Название_товара, Цена, Количество_на_складе
    FROM ТОВАРЫ
    WHERE Цена > 5 WITH CHECK OPTION;
    go


INSERT [Дорогие товары]
VALUES('Хлеб', 2, 12);


ALTER VIEW [Дорогие товары топ]
(
    Название_товара,
    Цена,
    Количество_на_складе
)
AS
    SELECT TOP 3
        Название_товара,
        Цена,
        Количество_на_складе
    FROM ТОВАРЫ
    ORDER BY Цена DESC


SELECT *
FROM [Дорогие товары топ]


CREATE VIEW [Сравнение Цен]
WITH
    SCHEMABINDING
AS
    SELECT 
    ZK.Товар,
    TV.Цена[Исходная цена],
    ZK.Цена_продажи[Цена продажи]
    FROM dbo.ЗАКАЗЫ AS ZK JOIN dbo.ТОВАРЫ as TV ON ZK.Товар = TV.Название_товара

SELECT *
FROM [Сравнение Цен];

