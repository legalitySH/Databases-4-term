
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
USE UNIVER;

BEGIN TRAN;

SELECT @@spid,* FROM FACULTY WHERE FACULTY = 'ТЕСТ4'

COMMIT;