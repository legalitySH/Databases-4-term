
-- 1 --

use UNIVER;
go
INSERT INTO TEACHER VALUES ('ШМК','Шимко Алексей Александрович','М','ИТ')

--


-- 2 --

use UNIVER;
go
DELETE FROM TEACHER WHERE TEACHER = 'ШМК';

--

-- 3 --

USE UNIVER;
go
UPDATE TEACHER SET TEACHER_NAME = 'Лёха' WHERE TEACHER_NAME = 'Шимко Алексей Александрович';



-- 4 --
DROP TRIGGER TR_TEACHER_DEL;
DROP TRIGGER TR_TEACHER_INS;
DROP TRIGGER TR_TEACHER_UPD;
DROP TRIGGER TR_TEACHER;


-- 5 --


USE UNIVER;

CREATE TABLE product (
    id int primary key,
    product_name varchar(40),
    price numeric
);

GO

CREATE TRIGGER TR_TEST_CONSTRAINT ON product AFTER INSERT AS
BEGIN
    PRINT 'Триггер сработал (но, к сожалению, вы не увидите это сообщение)';
END;
GO

ALTER TABLE product ADD CONSTRAINT CHK_Price CHECK (price > 10);
GO

INSERT INTO product VALUES (1, 'Банан', 5);

GO

DROP TABLE product;
DROP TRIGGER TR_TEST_CONSTRAINT;



-- 6 --

USE UNIVER;
go
CREATE TRIGGER  TR_TEACHER_DEL_A ON TEACHER AFTER DELETE AS
    BEGIN
        PRINT 'Триггер A'
    end
go
CREATE TRIGGER  TR_TEACHER_DEL_B ON TEACHER AFTER DELETE AS
    BEGIN
        PRINT 'Триггер B'
    end
go
CREATE TRIGGER  TR_TEACHER_DEL_C ON TEACHER AFTER DELETE AS
    BEGIN
        PRINT 'Триггер C'
    end

go

select t.name, e.type_desc
         from sys.triggers  t join  sys.trigger_events e
        on t.object_id = e.object_id  where OBJECT_NAME(t.parent_id) = 'TEACHER' and e.type_desc = 'DELETE' ;


exec  SP_SETTRIGGERORDER @triggername = 'TR_TEACHER_DEL_B',
	                        @order = 'First', @stmttype = 'DELETE';

exec  SP_SETTRIGGERORDER @triggername = 'TR_TEACHER_DEL_A',
	                        @order = 'Last', @stmttype = 'DELETE';

DELETE FROM TEACHER WHERE TEACHER = 'ШМК';




-- 7 --

use UNIVER;
INSERT INTO TEACHER VALUES ('УМВ','Угляница Михаил Владимирович','М','ИТ');


-- 8 --

DELETE FROM FACULTY WHERE FACULTY = 'ИТ';


-- 9 --


use UNIVER;

CREATE TABLE  test(
    id int primary key,
    name varchar(20)
)

DROP TRIGGER TR_SAFETY ON DATABASE;