USE UNIVER;
GO

CREATE TRIGGER TR_SAFETY ON DATABASE
FOR CREATE_TABLE, DROP_TABLE
AS
BEGIN
    DECLARE @eventType NVARCHAR(128) = EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]', 'NVARCHAR(128)');
    DECLARE @objectName NVARCHAR(256) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]', 'NVARCHAR(256)');
    DECLARE @objectType NVARCHAR(256) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectType)[1]', 'NVARCHAR(256)');

    IF @objectType = 'TABLE'
    BEGIN
        PRINT 'Тип события: ' + @eventType;
        PRINT 'Имя объекта: ' + @objectName;
        PRINT 'Тип объекта: ' + @objectType;
        PRINT 'Операции с созданием и удалением таблиц запрещены в данной базе данных.';
        RAISERROR(N'Операции с созданием и удалением таблиц запрещены', 16, 1);
        ROLLBACK;
    END;
END;