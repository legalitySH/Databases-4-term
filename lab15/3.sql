use UNIVER;
go
CREATE TRIGGER TR_TEACHER_UPD ON TEACHER after UPDATE
    as DECLARE @teacher char(10), @teacher_name varchar(100), @gender char, @pulpit char(20), @comment varchar(300)
    print 'Операция обновления'

    SET @teacher = (SELECT TEACHER FROM deleted)
    SET @teacher_name = (SELECT  TEACHER_NAME FROM deleted)
    SET @gender = (SELECT GENDER FROM deleted)
    SET @pulpit = (SELECT PULPIT FROM deleted)

    SET @comment = @teacher + ' ' + @teacher_name + ' ' + @gender + ' ' + @pulpit;

    SET @teacher = (SELECT TEACHER FROM inserted)
    SET @teacher_name = (SELECT  TEACHER_NAME FROM inserted)
    SET @gender = (SELECT GENDER FROM inserted)
    SET @pulpit = (SELECT PULPIT FROM inserted)

    SET @comment = @comment +  ' --> ' + @teacher + ' ' + @teacher_name + ' ' + @gender + ' ' + @pulpit;



    INSERT INTO TR_AUDIT VALUES ('UPD', 'TR_TEACHER_UPD', @comment)

return;