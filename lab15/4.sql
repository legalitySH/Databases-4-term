use UNIVER;
go
CREATE TRIGGER TR_TEACHER on TEACHER AFTER INSERT, DELETE , UPDATE
as
    declare @insert_count int = (SELECT COUNT(*) FROM inserted),
        @deleted_count int = (SELECT  COUNT(*) FROM deleted)

    DECLARE @teacher char(10), @teacher_name varchar(100), @gender char, @pulpit char(20), @comment varchar(300)

    -- INSERT --

    if @insert_count>0 and @deleted_count = 0
        begin
            print 'Операция вставки'

            SET @teacher = (SELECT TEACHER FROM inserted)
            SET @teacher_name = (SELECT  TEACHER_NAME FROM inserted)
            SET @gender = (SELECT GENDER FROM inserted)
            SET @pulpit = (SELECT PULPIT FROM inserted)

            SET @comment = @teacher + ' ' + @teacher_name + ' ' + @gender + ' ' + @pulpit;
            INSERT INTO TR_AUDIT VALUES ('INS', 'TR_TEACHER_INS', @comment)
            return;
        end
    -----

    -- DELETE --

    if @insert_count = 0 and @deleted_count > 0
        begin
            print 'Операция удаления'

            SET @teacher = (SELECT TEACHER FROM deleted)
            SET @teacher_name = (SELECT  TEACHER_NAME FROM deleted)
            SET @gender = (SELECT GENDER FROM deleted)
            SET @pulpit = (SELECT PULPIT FROM deleted)

            SET @comment = @teacher + ' ' + @teacher_name + ' ' + @gender + ' ' + @pulpit;
            INSERT INTO TR_AUDIT VALUES ('DEL', 'TR_TEACHER_DEL', @comment)
            return;
        end

    -- UPDATE --
        if @insert_count > 0 and @deleted_count > 0
            begin
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
                return;
            end