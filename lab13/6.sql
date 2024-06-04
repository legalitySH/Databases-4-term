use UNIVER;
go
CREATE PROCEDURE PAUDITORIUM_INSERTX @auditorium char(20),
                                     @auditorium_type char(10),
                                     @auditorium_capacity int = 0,
                                     @auditorium_name varchar(50),
                                     @auditorium_typename varchar(50)
    as begin
    begin try
        declare @inserting_result int = 1
        set transaction isolation level SERIALIZABLE
        begin tran
            INSERT INTO AUDITORIUM_TYPE VALUES (@auditorium_type, @auditorium_typename);
            exec @inserting_result = PAUDITORIUM_INSERT @auditorium = @auditorium,
                                     @auditorium_type = @auditorium_type,
                                     @auditorium_capacity = @auditorium_capacity,
                                     @auditorium_name = @auditorium_name
        commit tran
        return @inserting_result;
    end try
    begin catch
    print 'номер ошибки  : ' + cast(error_number() as varchar(6));
    print 'сообщение     : ' + error_message();
    print 'уровень       : ' + cast(error_severity()  as varchar(6));
    print 'метка         : ' + cast(error_state()   as varchar(8));
    print 'номер строки  : ' + cast(error_line()  as varchar(8));
    if error_procedure() is not  null
                     print 'имя процедуры : ' + error_procedure();
     if @@trancount > 0 rollback tran ;
     return -1;
    end catch;

end