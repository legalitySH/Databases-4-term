USE UNIVER;
go
CREATE TRIGGER TR_TEACHER_TRANC ON TEACHER AFTER INSERT, DELETE , UPDATE as
    begin
        declare @teacher int = (SELECT count(*) FROM TEACHER WHERE TEACHER_NAME = 'Угляница Михаил Владимирович');
        if(@teacher > 0)
            begin
                raiserror('Михаил Угляница не может быть преподавателем', 10,1);
                rollback;
            end
        return;
    end