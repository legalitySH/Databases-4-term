use UNIVER;

begin try
    begin tran
        INSERT INTO FACULTY VALUES ('ТЕСТ', 'ФИТ')
        DELETE FROM FACULTY WHERE FACULTY = 'ТЕСТ'
        INSERT INTO FACULTY VALUES ('ТЕСТ', 'ФИТ')
        UPDATE FACULTY SET FACULTY = 'ТЕСТ' WHERE FACULTY = 'ИТ'
    commit tran
end try
begin catch
        PRINT 'Произошла ошибка: ' + ERROR_MESSAGE()
        if @@trancount > 0 rollback tran;
end catch
