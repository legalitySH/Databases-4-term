use master;
create database lab_4;
use lab_4;

-- INNER JOIN запрос --

SELECT
       Название_товара,
       Цена,
       Количество_заказанного_товара
FROM ТОВАРЫ JOIN ЗАКАЗЫ ON ТОВАРЫ.Название_товара = ЗАКАЗЫ.Товар;

-- Запрос с ограничением выборки на сочетание букв --

SELECT Название_товара,
       Артикул_товара,
       Цена,
       Количество_заказанного_товара
FROM ТОВАРЫ JOIN ЗАКАЗЫ on ТОВАРЫ.Название_товара = ЗАКАЗЫ.Товар AND ЗАКАЗЫ.Товар LIKE '%оло%';

-- Этот же запрос другим способом --

SELECT Название_товара,
       Артикул_товара,
       Цена,
       Количество_заказанного_товара
FROM ТОВАРЫ,ЗАКАЗЫ WHERE Название_товара = Товар AND ЗАКАЗЫ.Товар LIKE '%оло%';

-- Псевдонимы --

SELECT T1.Название_товара,
       T2.Количество_заказанного_товара,
       T1.Цена
FROM ТОВАРЫ AS T1 JOIN ЗАКАЗЫ AS T2 ON T1.Название_товара = T2.Товар;

--Запрос с CASE --

SELECT ТОВАРЫ.Название_товара, ЗАКАЗЫ.Дата_продажи,
    CASE
        WHEN (ТОВАРЫ.Количество_на_складе BETWEEN 1 AND 100) THEN 'Меньше 100 единиц'
        WHEN (ТОВАРЫ.Количество_на_складе BETWEEN 100 AND 200) THEN 'Больше 100, но меньше 200'
        WHEN (ТОВАРЫ.Количество_на_складе BETWEEN 200 AND 500) THEN 'Больше 200, но меньше 500'
        ELSE 'Количество достаточное, больше 500'
    END AS Пределы_количества
FROM ТОВАРЫ
INNER JOIN ЗАКАЗЫ ON ТОВАРЫ.Название_товара = ЗАКАЗЫ.Товар
ORDER BY ЗАКАЗЫ.Товар;


-- Левое внешнее соеденение + тестирование функции ISNULL --

SELECT Название_товара,
       ISNULL(Количество_заказанного_товара,'0') AS [Количество заказанного товара],
       Количество_на_складе,
       ISNULL(Номер_заказа, 'not order') AS [Номер заказа]
FROM ТОВАРЫ as left_table
LEFT JOIN ЗАКАЗЫ AS right_table ON left_table.Название_товара = right_table.Товар;

-- Правое внешнее соеденение --

SELECT Название_товара,Количество_заказанного_товара,Количество_на_складе,Номер_заказа
FROM ТОВАРЫ as left_table
RIGHT JOIN ЗАКАЗЫ AS right_table on left_table.Название_товара = right_table.Товар;


-- Полное внешнее соеденение --

SELECT Название_товара,
       Количество_заказанного_товара,
       Телефон_клиент
FROM ЗАКАЗЫ FULL JOIN ТОВАРЫ ON ЗАКАЗЫ.Товар = Название_товара;

-- Запрос на получение количество значений, которые не смогли соедениться --

SELECT COUNT(*) FROM ТОВАРЫ FULL OUTER JOIN ЗАКАЗЫ ON ЗАКАЗЫ.Товар = ТОВАРЫ.Название_товара WHERE Номер_заказа is NULL;

-- Перекрёстное соеденение --

SELECT Название_товара,
       Цена,
       Количество_заказанного_товара
FROM ЗАКАЗЫ CROSS JOIN ТОВАРЫ WHERE Товар = Название_товара;






