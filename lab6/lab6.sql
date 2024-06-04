use lab_5;

-- Внутреннее соеденение таблиц , GROUP BY , агрегатные функции --

select Название_товара,
       max(Цена_продажи) as [Максимальная цена],
       count(*) as  [Количество заказов],
       avg(Цена_продажи) as [Средняя_цена_продажи],
       min(Цена_продажи) as [Минимальная_цена_продажи]
from ЗАКАЗЫ join ТОВАРЫ on ЗАКАЗЫ.Товар = ТОВАРЫ.Название_товара and ТОВАРЫ.Количество_на_складе > 5 group by Название_товара

-- Пределы изменения цен и соответствующее количество товаров при продаже --

select *
from (
    select case
                 when Цена_продажи between 1 and 50 then 'цена<50'
                 when Цена_продажи between 50 and 100 then 'цена от 50 до 100'
                 else 'цена больше 100'
                 end  as Пределы_цен,
             count(*) as Количество
      from ЗАКАЗЫ
      group by case
                   when Цена_продажи between 1 and 50 then 'цена<50'
                   when Цена_продажи between 50 and 100 then 'цена от 50 до 100'
                   else 'цена больше 100'
                   end
     ) as T
order by case Пределы_цен
             when 'цена<50' then 3
             when 'цена от 50 до 100' then 2
             when 'цена больше 100' then 1
             else 0
             end


-- Функция CAST --

select Название_товара,
       Телефон_клиент,
       Цена,
       round(avg(cast(Цена_продажи as float)),2)
from ТОВАРЫ
    join ЗАКАЗЫ on Товар = Название_товара
    join КЛИЕНТЫ on Телефон = Телефон_клиент
where Цена_продажи > 50
group by Название_товара, Телефон_клиент, Цена

-- Тот же запрос, но с определёнными товарами --

select Название_товара,
       Телефон_клиент,
       Цена,
       round(avg(cast(Цена_продажи as float)),2)
from ТОВАРЫ
    join ЗАКАЗЫ on Товар = Название_товара
    join КЛИЕНТЫ on Телефон = Телефон_клиент
where Цена_продажи > 50 and (Название_товара like('Сосиски') or Название_товара like('Чай'))
group by Название_товара, Телефон_клиент, Цена

-- Общее количество --

select Товар,
       Цена_продажи,
       sum(Количество_заказанного_товара) as Количество
from ЗАКАЗЫ join ТОВАРЫ on Название_товара = Товар
where Товар IN ('Колбаса','Молоко')
group by Товар,Цена_продажи



-- HAVING --

select p1.Товар,
       p1.Цена_продажи,
       (select count(*) from ЗАКАЗЫ p2 WHERE p2.Товар = p1.Товар and p2.Цена_продажи = p1.Цена_продажи) as Количество
from ЗАКАЗЫ p1
group by p1.Товар, p1.Цена_продажи
having Цена_продажи < 50 or Цена_продажи > 100

---/\_/\--
--( 0.0 )--
---|