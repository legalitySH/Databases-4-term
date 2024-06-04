use master;
go
CREATE database lab_3 on primary
    (
    name = N'lab_3_mdf',
    filename = N'D:\SecondCourse\БД\lab3\lab_3_mdf.mdf',
    size = 10240KB,
    maxsize = UNLIMITED,
    filegrowth =1024KB
    ),
    (
        name = N'lab_3_ndf',
        filename = N'D:\SecondCourse\БД\lab3\lab_3_ndf.ndf',
        size = 10240KB,
        maxsize = 1GB,
        filegrowth = 25%

    ),
    filegroup FG1
    (
        name = N'lab_3_fgl_1',
        filename = N'D:\SecondCourse\БД\lab3\lab_3_fgq-1.ndf',
        size = 10240KB,
        maxsize = 1GB,
        filegrowth = 25%
    ),
    (
        name = N'lab_3_fgl_2',
        filename = N'D:\SecondCourse\БД\lab3\lab_3_fgq-2.ndf',
        size = 10240KB,
        maxsize = 1GB,
        filegrowth = 25%
    )
log on
(
    name = N'lab_3_log',
    filename = N'D:\SecondCourse\БД\lab3\lab_3_log.ldf',
    size = 10240KB,
    maxsize = 2048GB,
    filegrowth  = 10%
    )
go



use lab_3;

CREATE TABLE КЛИЕНТЫ
(
    [Телефон]          nvarchar(50) primary key,
    [Фамилия_клиента]  nvarchar(50),
    [Имя_клиента]      nvarchar(50),
    [Отчество_клиента] nvarchar(50),
    [Адрес]            nvarchar(50),
    [Email]            nvarchar(50)
) on FG1;


CREATE TABLE ТОВАРЫ
(
    [Артикул_товара] nvarchar(50) primary key ,
    [Название_товара] nvarchar(50) unique,
    [Количество_на_складе] int,
    [Цена] float,
    [Единица_измерения] nvarchar(50)
) ON FG1;

CREATE TABLE ЗАКАЗЫ
(
    [Номер_заказа] nvarchar(50) primary key ,
    [Признак_скидки] tinyint,
    [Количество_заказанного_товара] int,
    [Название_товара] nvarchar(50) foreign key references ТОВАРЫ(Название_товара),
    [Дата_продажи] date
) ON FG1;


ALTER TABLE ЗАКАЗЫ ADD Процент_скидки tinyint;
ALTER TABLE ЗАКАЗЫ DROP COLUMN Процент_скидки;





INSERT INTO ТОВАРЫ(Артикул_товара, Название_товара, Количество_на_складе, Цена, Единица_измерения) VALUES ('1234534564' , 'Макароны' , 232 , 3.423 , 'пачка(500гр)')
INSERT INTO ТОВАРЫ(Артикул_товара, Название_товара, Количество_на_складе, Цена, Единица_измерения) VALUES ('3213215' , 'Кефир' , 232 , 3.423 , 'пакет(1л)')
INSERT INTO КЛИЕНТЫ(Телефон, Фамилия_клиента, Имя_клиента, Отчество_клиента, Адрес, Email) VALUES ('+375291234567' , 'Ляшонок' , 'Матвей' , 'Михайлович' , 'улица трыста дом трактарыста', 'lyashik@mail.nemail');
INSERT INTO ЗАКАЗЫ(Номер_заказа, Признак_скидки, Количество_заказанного_товара, Название_товара, Дата_продажи) VALUES ('1',1,32,'Макароны','2024-02-26');

SELECT * FROM ЗАКАЗЫ;

SELECT Телефон, Имя_клиента FROM КЛИЕНТЫ;

SELECT count(*) FROM ТОВАРЫ;

SELECT Количество_заказанного_товара Количество FROM ЗАКАЗЫ WHERE Название_товара = 'Макароны';

UPDATE ТОВАРЫ set Количество_на_складе = Количество_на_складе - 1;
SELECT * FROM ТОВАРЫ

UPDATE ТОВАРЫ set Цена = Цена + 10 WHERE Название_товара = 'Макароны';

DELETE FROM ТОВАРЫ WHERE Название_товара = 'Кефир';



