
-- 1 --

use UNIVER;
go
declare @students_count int = dbo.COUNT_STUDENTS('ИТ', '1-48 01 02');
print 'Количество студентов: ' + cast(@students_count as varchar);

--
DROP FUNCTION dbo.COUNT_STUDENTS;
--



-- 2 --
use UNIVER;
go
select PULPIT Кафедра, dbo.FSUBJECTS(PULPIT) Дисциплина
from   PULPIT


-- 3 --

USE UNIVER;
go

select * from FFACPUL(null, null)
select * from FFACPUL('ИЭФ', null)
select * from FFACPUL(null, 'ЛМиЛЗ')
select * from FFACPUL('ТТЛП', 'ЛМиЛЗ')



-- 4 --
USE UNIVER;
go


print 'Общее количество преподавателей: ' + cast(dbo.FCTEACHER(null) as varchar)
print 'Преподаватели кафедры  ИСиТ:  ' + cast(dbo.FCTEACHER('ИСиТ') as varchar)
select PULPIT Кафедра, dbo.FCTEACHER(PULPIT) [Количество преподавателей]
from   PULPIT

-- 6 --
USE UNIVER;
go

select * from FACULTY_REPORT(10)
