use UNIVER;
go
ALTER PROCEDURE SUBJECT_LIST_PROCEDURE @p varchar(20) = NULL, @c int output
    as begin
    declare @subject_count int = (SELECT COUNT(*) FROM SUBJECT);
    PRINT 'Переданные параметры: @p = ' + @p + ' @c = ' + cast(@c as varchar(10));
    SELECT * FROM SUBJECT WHERE PULPIT = @p;
    SET @c = @@rowcount;
    return @subject_count;
end