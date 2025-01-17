USE UNIVER;
go
create function FACULTY_REPORT(@c int) returns @fr table
([Факультет] varchar(50), [Кол-во кафедр] int, [Кол-во групп] int, [Кол-во студентов] int, [Количество специальностей] int)
as begin
	declare @f varchar(30);
	declare cc CURSOR static for
	select FACULTY from FACULTY
	where  dbo.COUNT_STUDENTS(FACULTY, default) > @c;

	open cc;
		fetch cc into @f;
	    while @@fetch_status = 0
			begin
	            insert @fr values(@f,  dbo.COUNT_PULPITS(@f),
	            dbo.COUNT_GROUPS(@f),   dbo.COUNT_STUDENTS(@f, default),
	            dbo.COUNT_PROFESSIONS(@f));
	            fetch cc into @f;
	       end;
	return;
end;