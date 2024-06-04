USE UNIVER;
go
CREATE TRIGGER TR_FACULTY_INSTEAD_OF ON FACULTY INSTEAD OF DELETE as
    begin
        raiserror('Удаление запрещено',10,1);
    end