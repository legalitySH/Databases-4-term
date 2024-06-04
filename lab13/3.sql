use UNIVER;
go
CREATE PROCEDURE FILL_TABLE_PROCEDURE @p varchar(20) = NULL
    as begin
    declare @subject_count int = (SELECT COUNT(*) FROM SUBJECT);
    SELECT * FROM SUBJECT WHERE PULPIT = @p;
    return @subject_count;
end