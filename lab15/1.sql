USE UNIVER;
go
CREATE TRIGGER TR_TEACHER_INS ON TEACHER AFTER INSERT
    as DECLARE @teacher char(10), @teacher_name varchar(100), @gender char, @pulpit char(20), @comment varchar(300)
    print 'Операция вставки'

    SET @teacher = (SELECT TEACHER FROM inserted)
    SET @teacher_name = (SELECT  TEACHER_NAME FROM inserted)
    SET @gender = (SELECT GENDER FROM inserted)
    SET @pulpit = (SELECT PULPIT FROM inserted)

    SET @comment = @teacher + ' ' + @teacher_name + ' ' + @gender + ' ' + @pulpit;
    INSERT INTO TR_AUDIT VALUES ('INS', 'TR_TEACHER_INS', @comment)

return;
