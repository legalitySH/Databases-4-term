
-- 1--
use UNIVER;
go
declare @subject_count int = 0;
EXEC @subject_count = SUBJECT_LIST_PROCEDURE;
PRINT 'Количество предметов:' + cast(@subject_count as varchar(10));


--
DROP PROCEDURE SUBJECT_LIST_PROCEDURE;
--


-- 2 --
use UNIVER;
go
declare @subject_count int = 0 , @p varchar(20) , @r int = 0
exec @subject_count = SUBJECT_LIST_PROCEDURE @p = 'ИСиТ', @c = @r output;

PRINT 'Количество предметов: ' + cast(@subject_count as varchar(10));
PRINT 'Количество найденных предметов: ' + cast(@r as varchar(10));


--
DROP PROCEDURE SUBJECT_LIST_PROCEDURE;
--


-- 3 --
use UNIVER;
go

IF OBJECT_ID('tempdb..#SUBJECT_TEMP', 'U') IS NOT NULL
    DROP TABLE #SUBJECT_TEMP;

CREATE TABLE #SUBJECT_TEMP(
    SUBJECT varchar(10) PRIMARY KEY,
    SUBJECT_NAME varchar(100),
    PULPIT VARCHAR(20)
);

INSERT #SUBJECT_TEMP exec FILL_TABLE_PROCEDURE 'ИСИТ';

SELECT * FROM #SUBJECT_TEMP;

-- 4 --

use UNIVER;
go

    declare @error_code int;

    exec @error_code = PAUDITORIUM_INSERT '311-2' , 'ЛК',  100,'311-2'

    IF @error_code = 1
        BEGIN
            PRINT 'Успешная вставка';
        end
    ELSE
        BEGIN
            PRINT 'Не удалось вставить строку'
        end

-- 5 --
use UNIVER;
go
declare @pulpit_count int = 0;
exec @pulpit_count =  SUBJECT_REPORT 'ИсИТ';
PRINT 'Количество предметов: ' + cast(@pulpit_count as varchar);


-- 6 --

USE UNIVER;
go
declare @insert_result int = 0;
exec @insert_result = PAUDITORIUM_INSERTX '1' , 'СЗ',  100,'1', 'Спортзал'
PRINT 'Результат: ' + cast(@insert_result as varchar);
