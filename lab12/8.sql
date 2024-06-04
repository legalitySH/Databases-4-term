USE UNIVER;

SET NOCOUNT ON;

BEGIN TRY
    BEGIN TRAN OuterTransaction;

    INSERT INTO FACULTY VALUES ('ТЕСТ3', 'ФИТ');
    PRINT 'Уровень вложенности:' + cast(@@trancount as varchar(5));
    PRINT 'Добавлен новый факультет';

    BEGIN TRAN InnerTransaction;
    PRINT 'Уровень вложенности:' + cast(@@trancount as varchar(5));
    if @@trancount>0 rollback;

    UPDATE FACULTY SET FACULTY_NAME = 'ФИТЫ' WHERE FACULTY = 'ТЕСТ3';
    PRINT 'Добавленный факультет изменен';


    DELETE FROM FACULTY WHERE FACULTY = 'ФИТЫ';
    PRINT 'Попытка удалить факультет ИТ';

    COMMIT TRAN InnerTransaction

    COMMIT TRAN OuterTransaction;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
    BEGIN
        PRINT 'Произошла ошибка: ' + ERROR_MESSAGE();
        ROLLBACK TRAN OuterTransaction;
    END;
END CATCH;