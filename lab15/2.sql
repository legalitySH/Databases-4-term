use UNIVER;
go
CREATE TRIGGER TR_TEACHER_DEL on TEACHER after DELETE
    as DECLARE @teacher char(10), @teacher_name varchar(100), @gender char, @pulpit char(20), @comment varchar(300)
    print 'Операция удаления'

    SET @teacher = (SELECT TEACHER FROM deleted)
    SET @teacher_name = (SELECT  TEACHER_NAME FROM deleted)
    SET @gender = (SELECT GENDER FROM deleted)
    SET @pulpit = (SELECT PULPIT FROM deleted)

    SET @comment = @teacher + ' ' + @teacher_name + ' ' + @gender + ' ' + @pulpit;
    INSERT INTO TR_AUDIT VALUES ('DEL', 'TR_TEACHER_DEL', @comment)

return;