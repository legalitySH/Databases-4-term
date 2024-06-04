use UNIVER
go
create function COUNT_PULPITS (@FACULTY varchar(20)) returns int
as begin
	declare @COUNT int = (select count(PULPIT) from PULPIT where FACULTY = isnull(@FACULTY, FACULTY))
	return @COUNT
end
go
create function COUNT_GROUPS (@FACULTY varchar(20)) returns int
as begin
	declare @COUNT int = (select count(IDGROUP) from GROUPS where FACULTY = isnull(@FACULTY, FACULTY))
	return @COUNT
end
go
create function COUNT_PROFESSIONS (@FACULTY varchar(20)) returns int
as begin
	declare @COUNT int =  (select count(PROFESSION) from PROFESSION where FACULTY = isnull(@FACULTY, FACULTY))
	return @COUNT
end
