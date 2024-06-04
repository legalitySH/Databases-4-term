USE UNIVER;
go
CREATE TABLE TR_AUDIT
(
    ID int identity,
    STMT varchar(20) CHECK (STMT IN ('INS', 'DEL', 'UPD')),
    TRNAME varchar(50),
    CC varchar(300)
)
