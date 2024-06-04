use UNIVER;
go
CREATE PROCEDURE SUBJECT_REPORT
    @pullpit_code CHAR(20)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM PULPIT WHERE PULPIT = @pullpit_code)
    BEGIN
        RAISERROR('Ошибка в параметрах', 16, 1);
        RETURN -1;
    END

    DECLARE bd CURSOR FOR SELECT PULPIT FROM dbo.SUBJECT WHERE PULPIT = @pullpit_code
    OPEN bd
    declare @pulpit varchar(max);
    FETCH bd INTO @pulpit;


    DECLARE @subjects VARCHAR(MAX);

    SELECT @subjects = STRING_AGG(RTRIM(SUBJECT), ',')
    FROM SUBJECT
    WHERE PULPIT = @pullpit_code;

    CLOSE bd;

    PRINT 'Отчет по дисциплинам кафедры ' + @pullpit_code;
    PRINT @subjects;

    RETURN (SELECT COUNT(*) FROM SUBJECT WHERE PULPIT = @pullpit_code);
END;