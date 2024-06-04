use UNIVER;
go
CREATE PROCEDURE PAUDITORIUM_INSERT @auditorium char(20), @auditorium_type char(10), @auditorium_capacity int = 0, @auditorium_name varchar(50)
    AS BEGIN
    begin try
        INSERT INTO AUDITORIUM VALUES (@auditorium, @auditorium_type, @auditorium_capacity, @auditorium_name);
        return 1;
    end try
    begin catch
        PRINT 'Номер ошибки: ' + cast(error_number() as varchar(6));
        print 'Сообщение: ' + error_message();
        print 'Имя процедуры:' + error_procedure();
        return -1;
    end catch
end