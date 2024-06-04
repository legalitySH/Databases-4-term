-- 1 --

USE lab_5;

DECLARE 
    @current_product VARCHAR(20),
    @total_product_list VARCHAR(300);


DECLARE ordered_products CURSOR FOR
    SELECT Товар
FROM ЗАКАЗЫ;

SET @total_product_list = '';

OPEN ordered_products;

FETCH NEXT FROM ordered_products INTO @current_product;
WHILE @@FETCH_STATUS = 0
BEGIN
    SET @total_product_list = @total_product_list + ', ' + RTRIM(@current_product);
    FETCH NEXT FROM ordered_products INTO @current_product;
END;

CLOSE ordered_products;
DEALLOCATE ordered_products;

PRINT 'Ordered products: ' + STUFF(@total_product_list, 1, 2, ''); 
go
--



-- 2--

use lab_5;

DECLARE Products_local CURSOR LOCAL FOR
    SELECT Название_товара, Цена
FROM ТОВАРЫ;

DECLARE
@iterable_product VARCHAR(20),
@product_cost REAL;

OPEN Products_local;

FETCH Products_local into @iterable_product, @product_cost;
PRINT '1. ' + @iterable_product + ' - ' + CAST(@product_cost as VARCHAR(10));
go
DECLARE
@iterable_product VARCHAR(20),
@product_cost REAL;

FETCH Products_local into @iterable_product, @product_cost;
PRINT '2. ' + @iterable_product + ' - ' + CAST(@product_cost as VARCHAR(10));
go


DECLARE Products_global CURSOR GLOBAL FOR
    SELECT Название_товара, Цена
FROM ТОВАРЫ;

DECLARE
@iterable_product VARCHAR(20),
@product_cost REAL;

OPEN Products_global;

FETCH Products_global into @iterable_product, @product_cost;
PRINT '1. ' + @iterable_product + ' - ' + CAST(@product_cost as VARCHAR(10));
go
DECLARE
@iterable_product VARCHAR(20),
@product_cost REAL;

FETCH Products_global into @iterable_product, @product_cost;
PRINT '2. ' + @iterable_product + ' - ' + CAST(@product_cost as VARCHAR(10));
CLOSE Products_global;
DEALLOCATE Products_global;
go


--



-- 3 --

-- static --
USE lab_5;
DECLARE 
    @product_name VARCHAR(20),
    @product_cost REAL,
    @product_count INT;

DECLARE Orders_local CURSOR LOCAL STATIC SCROLL FOR
    SELECT Товар, Цена_продажи, Количество_заказанного_товара
FROM ЗАКАЗЫ
WHERE Товар IN (N'Молоко', N'Кефир');

OPEN Orders_local;

INSERT ЗАКАЗЫ
    (Товар, Количество_заказанного_товара, Цена_продажи)
VALUES
    (N'Молоко', 10, 13.23);

PRINT 'Cursor rows: ' + CAST(@@CURSOR_ROWS as VARCHAR(5));

UPDATE ЗАКАЗЫ SET Количество_заказанного_товара = 10 WHERE Товар IN ('Молоко', 'Кефир');
INSERT ЗАКАЗЫ
    (Товар, Количество_заказанного_товара, Цена_продажи)
VALUES
    (N'Кефир', 10, 13.23);



FETCH  LAST from  Orders_local into @product_name, @product_cost, @product_count;

PRINT 'Last row: ' + @product_name;

PRINT 'Cursor rows(after adding in table row): ' + CAST(@@CURSOR_ROWS as VARCHAR(5));
FETCH Orders_local INTO @product_name, @product_cost, @product_count;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Cursor rows: ' + CAST(@@CURSOR_ROWS as VARCHAR(5));
    PRINT @product_name + ' ' + CAST(@product_cost AS VARCHAR(10)) + ' ' + CAST(@product_count AS VARCHAR(10));
    FETCH Orders_local INTO @product_name, @product_cost, @product_count;
END;
CLOSE Orders_local;
DEALLOCATE Orders_local;

go


-- dynamic --


INSERT ЗАКАЗЫ
    (Товар, Количество_заказанного_товара, Цена_продажи)
VALUES
    (N'Кефир', 10, 13.23);

USE lab_5;

DECLARE Orders_dynamic cursor local dynamic SCROLL                               
    for SELECT row_number() over (order by Товар) N,
    Товар
FROM ЗАКАЗЫ
where Товар IN ('Молоко', 'Кефир');


DECLARE
@number int,
@product varchar(20)

OPEN Orders_dynamic;


FETCH Orders_dynamic into @number,@product;

PRINT 'Next row: ' + cast(@number as varchar(3)) + ' ' + RTRIM(@product);

FETCH  LAST from  Orders_dynamic into @number, @product; 

INSERT ЗАКАЗЫ
    (Товар, Количество_заказанного_товара, Цена_продажи)
VALUES
    (N'Молоко', 10, 13.25);


PRINT 'Last row: ' + cast(@number as varchar(3)) + ' ' + RTRIM(@product);

PRINT 'Cursor rows: ' + CAST(@@CURSOR_ROWS as VARCHAR(5));

WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT 'Cursor rows: ' + CAST(@@CURSOR_ROWS as VARCHAR(5));
        FETCH Orders_dynamic into @number , @product;
    END;


CLOSE Orders_dynamic;


-- 4 --

go
use lab_5;

DECLARE Scroll_cursor CURSOR LOCAL STATIC FOR
SELECT Телефон_клиент FROM ЗАКАЗЫ;

DECLARE @number as varchar(20);

OPEN Scroll_cursor;

FETCH LAST FROM Scroll_cursor into @number;

PRINT 'Last: ' + @number;

FETCH FIRST FROM Scroll_cursor into @number;

PRINT 'First: ' + @number;

FETCH ABSOLUTE 3 FROM Scroll_cursor into @number;

PRINT 'Third from start: ' + @number;

FETCH ABSOLUTE -3 FROM Scroll_cursor into @number;

PRINT 'Third from end: ' + @number;

CLOSE Scroll_cursor;

-- 5 --

use lab_5;
go
DECLARE 
@product_name VARCHAR(20),
@product_count INT,
@product_cost REAL;

DECLARE Task_5 CURSOR LOCAL DYNAMIC FOR
    SELECT Товар, Количество_заказанного_товара,Цена_продажи FROM ЗАКАЗЫ;

    OPEN Task_5;
FETCH  Task_5 into @product_name, @product_count, @product_cost;

DELETE ЗАКАЗЫ WHERE CURRENT OF Task_5;

FETCH  Task_5 into @product_name, @product_count, @product_cost;

UPDATE ЗАКАЗЫ SET Количество_заказанного_товара = Количество_заказанного_товара + 1
    WHERE CURRENT OF Task_5;

    CLOSE Task_5;




SELECT * FROM ЗАКАЗЫ;


--6.1--

SELECT * FROM STUDENT;
SELECT * FROM PROGRESS;

use UNIVER;
INSERT INTO PROGRESS (SUBJECT, IDSTUDENT, PDATE, NOTE) values ('БД',   1064,  '06.05.2013', 3);
declare ProgStud CURSOR LOCAL DYNAMIC FOR
	SELECT p.IDSTUDENT, s.NAME, p.NOTE FROM PROGRESS p
	JOIN STUDENT s ON s.IDSTUDENT = p.IDSTUDENT
	WHERE p.NOTE < 4
		FOR UPDATE
declare @id varchar(5), @nm varchar(50), @nt int


OPEN ProgStud
FETCH ProgStud INTO @id, @nm, @nt
print @id + ': ' + @nm + ' (оценка ' + cast(@nt as varchar) + ')'
DELETE PROGRESS WHERE CURRENT OF ProgStud
CLOSE ProgStud


-- 6.2 --

use UNIVER;

SELECT * FROM PROGRESS;

declare Prog CURSOR LOCAL DYNAMIC FOR
	SELECT p.IDSTUDENT, s.NAME, p.NOTE FROM PROGRESS p
	JOIN STUDENT s ON s.IDSTUDENT = p.IDSTUDENT
	WHERE p.IDSTUDENT = 1017
		FOR UPDATE
declare @id varchar(5), @nm varchar(50), @nt int

OPEN Prog
FETCH Prog INTO @id, @nm, @nt
UPDATE PROGRESS SET NOTE = NOTE + 1 WHERE CURRENT OF Prog
print @id + ': ' + @nm + ' (Оценка студента ' + cast(@nt as varchar) + ' увеличена до)'
CLOSE Prog