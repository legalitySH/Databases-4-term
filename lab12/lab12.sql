

-- 1 --

go

SET NOCOUNT ON

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'DBO.X'))
    DROP TABLE X

DECLARE @c INT, @flag CHAR = 'r'

SET IMPLICIT_TRANSACTIONS ON

CREATE TABLE X (K INT)
INSERT X VALUES (1),(2),(3)

SET @c = (SELECT COUNT(*) FROM X)
PRINT 'Количество строк в таблице X: ' + CAST(@c AS VARCHAR(2))

IF @flag = 'c'
    COMMIT
ELSE
    ROLLBACK

-- Выключаем режим неявной транзакции
SET IMPLICIT_TRANSACTIONS OFF

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'DBO.X'))
    PRINT 'Таблица X есть'
ELSE
    PRINT 'Таблицы X нет'
        