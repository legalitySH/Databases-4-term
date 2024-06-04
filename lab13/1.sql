use UNIVER;
go
CREATE PROCEDURE SUBJECT_LIST_PROCEDURE
AS
    BEGIN
        DECLARE @subjects int = (SELECT count(*) FROM SUBJECT);
        SELECT * FROM SUBJECT;
        return @subjects;
    END
