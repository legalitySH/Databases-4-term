use lab_5;

ALTER VIEW [ordersInfo]
AS
    SELECT
        �����,
        ����_�������,
        ����������_�����������_������,
        �������_������
    FROM ������


SELECT *
FROM ordersInfo;



ALTER VIEW [ordersInfo]
AS
    SELECT ����� , ����_�������
    FROM ������


DROP VIEW [ordersInfo];


ALTER VIEW [��������� ���]
AS
    SELECT
        ZK.�����,
        TV.����,
        ZK.����_������� 
    FROM ������ as ZK 
    INNER JOIN ������ AS TV ON ZK.����� = TV.��������_������;


SELECT *
FROM [��������� ���];


CREATE VIEW [������� ������]
(
    ��������_������,
    ����,
    ����������_��_������
)
AS
    SELECT ��������_������, ����, ����������_��_������
    FROM ������
    WHERE ���� > 5



SELECT *
FROM [������� ������];

INSERT [������� ������]
VALUES('�����', 5.2, 12);
INSERT [������� ������]
VALUES('����������', 6.2, 12);


ALTER VIEW [������� ������]
(
    ��������_������,
    ����,
    ����������_��_������
)
AS
    SELECT ��������_������, ����, ����������_��_������
    FROM ������
    WHERE ���� > 5 WITH CHECK OPTION;
    go


INSERT [������� ������]
VALUES('����', 2, 12);


ALTER VIEW [������� ������ ���]
(
    ��������_������,
    ����,
    ����������_��_������
)
AS
    SELECT TOP 3
        ��������_������,
        ����,
        ����������_��_������
    FROM ������
    ORDER BY ���� DESC


SELECT *
FROM [������� ������ ���]


CREATE VIEW [��������� ���]
WITH
    SCHEMABINDING
AS
    SELECT 
    ZK.�����,
    TV.����[�������� ����],
    ZK.����_�������[���� �������]
    FROM dbo.������ AS ZK JOIN dbo.������ as TV ON ZK.����� = TV.��������_������

SELECT *
FROM [��������� ���];

