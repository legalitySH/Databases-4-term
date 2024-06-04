USE UNIVER;

SET nocount ON;

DECLARE @save_point varchar(32);

BEGIN TRY
    BEGIN TRAN
        SET @save_point = 'SavePoint1';
        SAVE TRAN @save_point;

        INSERT INTO FACULTY VALUES ('ТЕСТ3', 'ФИТ');
        PRINT 'Добавлен новый факультет';

        UPDATE FACULTY SET FACULTY_NAME = 'ФИТЫ' WHERE FACULTY = 'ТЕСТ3';
        PRINT 'Добавленный факультет изменен';

        SET @save_point = 'SavePoint2';
        SAVE TRAN @save_point;

        DELETE FROM FACULTY WHERE FACULTY = 'ИТ';
        PRINT N'Попытка удалить факультет ИТ';

        COMMIT TRAN;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            PRINT 'Контрольная точка: ' + @save_point;
            PRINT 'Произошла ошибка: ' + ERROR_MESSAGE();
            ROLLBACK TRAN @save_point;
            COMMIT TRAN;
        END;
    END CATCH;
