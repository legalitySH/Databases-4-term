use UNIVER;
go
create function COUNT_STUDENTS (@faculty varchar(20)) returns int
as begin
	declare @COUNT int = (select count(*)
						  from STUDENT s
						  join GROUPS g on s.IDGROUP = g.IDGROUP
						  join FACULTY f on f.FACULTY = g.FACULTY
						  where g.FACULTY = @faculty)
	return @COUNT
end