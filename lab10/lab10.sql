use master;


--1

--DROP TABLE #EXPLRE;

CREATE table  #EXPLRE
 (   TIND int,  
  TFIELD varchar(100)
      );

SET NOCOUNT ON;
DECLARE 
@i int = 0,
@s VARCHAR(100);
WHILE @i < 5000
    BEGIN
    SET @s = cast(@i as varchar(100));
    INSERT #EXPLRE(TIND, TFIELD) VALUES (@i, @s)
    SET @i = @i + 1;
END;

SELECT * FROM #EXPLRE WHERE TIND BETWEEN 2600 AND 4200 ORDER BY TIND;

 checkpoint;
 DBCC DROPCLEANBUFFERS; 


DROP INDEX #SEARCHINDEX ON #EXPLRE;
CREATE CLUSTERED INDEX #SEARCHINDEX ON #EXPLRE(TIND) ;

--2

CREATE table #EX
(    TKEY int, 
      CC int identity(1, 1),
      TF varchar(100)
);

--DROP TABLE #EX;



  set nocount on;           
  declare @i_2 int = 0;
  while   @i_2 < 20000
  begin
       INSERT #EX(TKEY, TF) values(floor(30000*RAND()), replicate('строка ', 10));
        set @i_2 = @i_2 + 1; 
  end;

  --Количество строк

	SELECT count(*)[Count of rows] from #EX;
	SELECT * FROM #EX;

	SELECT * FROM #EX WHERE TKEY > 1500 AND CC < 4500;
	SELECT * from  #EX order by  TKEY, CC
	DROP INDEX #EX_NONCLU ON #EX;
	CREATE INDEX #EX_NONCLU on #EX(TKEY, CC);

	SELECT * from  #EX where  TKEY = 771 and  CC > 3


	--3

	CREATE  index #EX_TKEY_X on #EX(TKEY) INCLUDE (CC);
	DROP INDEX #EX_TKEY_X ON #EX;

	SELECT CC from #EX where TKEY>15000 



	--4

	SELECT TKEY from  #EX where TKEY between 5000 and 19999; 
	SELECT TKEY from  #EX where TKEY>15000 and  TKEY < 20000  
	SELECT TKEY from  #EX where TKEY=17000

	CREATE  index #EX_WHERE on #EX(TKEY) where (TKEY>=15000 and 
 TKEY < 20000);  
	DROP index #EX_WHERE ON #EX;





	--5


	CREATE   index #EX_TKEY ON #EX(TKEY); 
	--DROP INDEX #EX_TKEY ON #EX;

	use tempdb;
	SELECT name [Индекс],
	avg_fragmentation_in_percent [Фрагментация (%)]
	FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'), 
	OBJECT_ID(N'#EX'), NULL, NULL, NULL) ss  JOIN sys.indexes ii 
	on ss.object_id = ii.object_id and ss.index_id = ii.index_id
	WHERE name is not null;



	 INSERT top(10000) #EX(TKEY, TF) select TKEY, TF from #EX;


	 ALTER index #EX_TKEY on #EX rebuild with (online = off);
	ALTER index #EX_TKEY on #EX reorganize;



--6 

--DROP index #EX_TKEY on #EX;

    CREATE index #EX_TKEY on #EX(TKEY) with (fillfactor = 65);
	    INSERT top(50)percent INTO #EX(TKEY, TF) 
                                              SELECT TKEY, TF  FROM #EX;


use tempdb;
SELECT name [Индекс], avg_fragmentation_in_percent [Фрагментация (%)]
FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'),    
OBJECT_ID(N'#EX'), NULL, NULL, NULL) ss  JOIN sys.indexes ii 
ON ss.object_id = ii.object_id and ss.index_id = ii.index_id  WHERE name is not null;




















