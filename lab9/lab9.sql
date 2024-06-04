-- 1 --
declare
 @i int = 1,
 @b varchar(4) = 'БГТУ',
 @c datetime,
 @tm time,
 @ch char,
 @si smallint,
 @ti tinyint,
 @n NUMERIC(12,5);

SET @c = GETDATE();
SET @tm = SYSDATETIME();
SET @ch = 'c';

use lab_5;
SELECT @si = 4 , @ch = 'd';


SELECT @i i, @b b, @c c

PRINT 'tm = ' + CONVERT(VARCHAR,@tm);
PRINT 'si = ' + CONVERT(VARCHAR,@si);

DECLARE @h TABLE(
    num int IDENTITY(1,1),
    fill varchar(30) DEFAULT 'XXX'
 );

 INSERT @h default values;

 SELECT * FROM @h;

 -- 2 --

DECLARE
@ordersCount INT = (SELECT COUNT(*) FROM ЗАКАЗЫ);

IF @ordersCount > 5
BEGIN
    DECLARE @averageCost INT = (SELECT AVG(Цена_продажи) FROM ЗАКАЗЫ)
    PRINT 'Средняя цена продажи: ' + CONVERT(varchar, @averageCost)
    DECLARE @lessThenAverage INT = (SELECT COUNT(*) FROM ЗАКАЗЫ WHERE Цена_продажи < @averageCost)
    PRINT 'Количество заказов, цена продажи которых - меньше среднего: ' + CONVERT(VARCHAR, @lessThenAverage)
END;
ELSE
    PRINT 'Количество заказов: ' + CONVERT(varchar,@ordersCount)


-- 3 --

PRINT 'Число обработанных строк: ' + CONVERT(varchar, @@ROWCOUNT);
PRINT 'Версия: ' + @@VERSION; 
PRINT 'Cистемный идентификатор процесса: ' + CONVERT(varchar,@@SPID);
PRINT 'Код последней ошибки: ' + CONVERT(varchar, @@ERROR);
PRINT 'Имя сервера: ' + CONVERT(varchar, @@SERVERNAME);
PRINT 'Уровень вложенности транзакций: ' + CONVERT(varchar, @@TRANCOUNT);
PRINT 'Проверка результата считывания строк: ' + CONVERT(varchar, @@FETCH_STATUS);
PRINT 'Уровень вложенности текущей процедуры: ' + CONVERT(varchar, @@NESTLEVEL);


 print 'Округление          : '+ cast(round(12345.12345, 2) as varchar(12)); 
 print 'Нижнее целое        : '+ cast(floor(24.5) as varchar(12));
 print 'Возведение в степень: '+ cast(power(12.0, 2) as varchar(12)); 
 print 'Логарифм            : '+ cast(log(144.0) as varchar(12));
 print 'Корень квадратный   : '+ cast(sqrt(144.0) as varchar(12));
 print 'Экпонента           : '+ cast(exp(4.96981) as varchar(12));
 print 'Абсолютное значение : '+ cast(abs(-5) as varchar(12));
 print 'Cинус               : '+ cast(sin(pi()) as varchar(12));
 print 'Подстрока              : '+  substring('1234567890', 3,2);   
 print 'Удалить пробелы справа : '+  rtrim('12345     ') +'X';
 print 'Удалить пробелы слева  : '+  'X'+ ltrim('     67890');
 print 'Нижний регистр         : '+  lower ('ВЕРХНИЙ РЕГИСТР');
 print 'Верхний регистр        : '+  upper ('нижний регистр');
 print 'Заменить               : '+  replace('1234512345', '5', 'X');
 print 'Строка пробелов        : '+  'X'+ space(5) +'X';
 print 'Повторить строку       : '+  replicate('12', 5);
 print 'Найти по шаблону       : '+  cast (patindex ('%Y_Y%', '123456YxY7890') as varchar(5));
 DECLARE @time time(7) = SYSDATETIME(), @dt datetime = getdate();
 print 'Текущее время       : '+  convert (varchar(12), @time);
 print 'Текущая дата        : '+  convert (varchar(12), @dt, 103);
 print '+1 день               : '+ convert(varchar(12), dateadd(d, 1, @dt), 103);

 -- 4 --


-- 1 --
 DECLARE 
 @t int = 5,
 @x int = 3,
 @z float;


IF @t > @x SET @z = power(sin(@t),2)
ELSE IF @t < @x SET @z = 4 * (@t + @x)
ELSE SET @z = 1 - EXP(@x-2);

PRINT 'z = ' + CONVERT(varchar, @z);

-- 2 --

DECLARE @fullName varchar(100) = 'Шимко Алексей Александрович';

DECLARE @shortName varchar(50);

SELECT @shortName = 
    LEFT(@fullName, CHARINDEX(' ', @fullName)) + ' ' +
    SUBSTRING(@fullName, CHARINDEX(' ', @fullName) + 1, 1) + '.' +
    SUBSTRING(@fullName, CHARINDEX(' ', @fullName, CHARINDEX(' ', @fullName) + 1) + 1, 1) + '.'
PRINT 'Полное ФИО: ' + @fullName;
PRINT 'Сокращенное ФИО: ' + @shortName;


-- 3 --


use lab_9;

DECLARE @currentDate DATE = GETDATE();

SELECT 
    Имя,
    Фамилия,
    Дата_рождения,
    DATEDIFF(YEAR, Дата_рождения, @currentDate) - 
    CASE
        WHEN DATEADD(YEAR, DATEDIFF(YEAR, Дата_рождения, @currentDate), Дата_рождения) > @currentDate 
        THEN 1
        ELSE 0
    END AS Возраст
FROM 
    Студенты
WHERE 
    MONTH(Дата_рождения) = MONTH(DATEADD(MONTH, 1, @currentDate))
    AND DAY(Дата_рождения) >= DAY(@currentDate);


-- 4 --

DECLARE @group int =   1;

SELECT DISTINCT DATENAME(WEEKDAY, Экзамены.Дата_экзамена) AS День_недели
FROM Студенты
JOIN Экзамены ON Студенты.id = Экзамены.id_студента
WHERE Студенты.Группа = @group AND Название_экзамена = 'Базы данных';




-- 6 --

use lab_5;

SELECT CASE 
        WHEN Цена BETWEEN 0 AND 1 THEN 'Дешево'
        WHEN Цена BETWEEN 1.5 AND 3 THEN 'Нормально'
        WHEN Цена BETWEEN 3 AND 7 THEN 'Дорого'
        ELSE 'Очень дорого'
    END AS Цена,
    COUNT(*) AS [Количество]
FROM dbo.ТОВАРЫ 
GROUP BY CASE
        WHEN Цена BETWEEN 0 AND 1 THEN 'Дешево'
        WHEN Цена BETWEEN 1.5 AND 3 THEN 'Нормально'
        WHEN Цена BETWEEN 3 AND 7 THEN 'Дорого'
        ELSE 'Очень дорого'
    END



-- 7 --

CREATE TABLE #EXPLRE 
(
    id int,
    field varchar(50)
);


SET NOCOUNT on;

DECLARE
@iterator int = 0;

WHILE @iterator < 10
    BEGIN
    INSERT #EXPLRE(id,field) VALUES(@iterator, REPLICATE('d',@iterator));
    SET @iterator = @iterator + 1;
    END;
SELECT * FROM #EXPLRE;

-- 8 --

DECLARE
@var int = 4;

PRINT @var;
PRINT @var + 1;
RETURN
PRINT @var +1;

-- 9 --

use lab_5;

CREATE TABLE #PEOPLES(FirstName NVARCHAR NOT NULL, Age INT NOT NULL);

BEGIN TRY 
    INSERT INTO #PEOPLES VALUES(NULL,NULL);
END TRY
BEGIN CATCH
PRINT 'Error ' + CONVERT(VARCHAR, ERROR_NUMBER()) + ':' + ERROR_MESSAGE()
END CATCH

