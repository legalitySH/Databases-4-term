USE UNIVER;
go
create function FCTEACHER (@PULPIT varchar(20)) returns int
as begin
	declare @COUNT int = (select count(*)
						  from   TEACHER t
						  where  t.PULPIT = isnull(@PULPIT, t.PULPIT))
	return @COUNT
end

