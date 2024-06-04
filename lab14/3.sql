use UNIVER;
go

create function FFACPUL (@FACULTY varchar(20), @PULPIT varchar(20)) returns table
as return
	select f.FACULTY Факультет, p.PULPIT Кафедра
	from   FACULTY f left join PULPIT p
	on	   p.FACULTY = f.FACULTY
	where  f.FACULTY = isnull(@FACULTY, f.FACULTY)
	and	   p.PULPIT = isnull (@PULPIT, p.PULPIT)