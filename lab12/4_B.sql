-- B ---
USE UNIVER;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

BEGIN TRAN;

INSERT FACULTY VALUES('ТЕСТ4','ТЕСТ4');
UPDATE FACULTY SET FACULTY_NAME = 'ТЕСТ4_CHANGED' WHERE FACULTY = 'ТЕСТ4';

SELECT *,@@spid as proccess_id FROM FACULTY;

ROLLBACK;



