--Windows funcion (função de janela)

-- ROW_NUMBER -- NUMEROS DE LINHAS
use Chinook

SELECT TrackId, 
		name, 
		albumId,
		MediaTypeId,
		GenreId,
		Composer,
		Milliseconds,
		Bytes, 
		ROW_NUMBER() OVER(ORDER BY Milliseconds asc) AS 'ROW_NUMBER'  -- over() -- 
	FROM Track
------------------------------------------------------------------------------
-- PARTITION BY - particionar - dividir

SELECT TrackId, 
		name, 
		Composer,
		Milliseconds,
		Bytes, 
		ROW_NUMBER() OVER(ORDER BY Milliseconds asc) AS 'ROW_NUMBER', 
		ROW_NUMBER() OVER(PARTITION BY Composer ORDER BY Milliseconds asc) AS 'ROW_NUMBER_PARTITION_BY'
	FROM Track
	where Composer IS NOT NULL
----------------------------------------------------------------------------------
-- RANK e  DENSE_RANK

SELECT TrackId, 
		name, 
		albumId,
		Composer,
		Milliseconds, 
		UnitPrice,
		ROW_NUMBER() OVER(ORDER BY UnitPrice asc) AS 'ROW_NUMBER',
		RANK() OVER(ORDER BY UnitPrice asc) AS 'RANK',
		DENSE_RANK() OVER(ORDER BY UnitPrice asc) AS 'DENCE_RANK'
	FROM Track
------------------------------------------------------------------------------------
-- NTILE - GRUPOS

SELECT TrackId, 
		name, 
		albumId,
		Composer,
		Milliseconds, 
		UnitPrice,
		ROW_NUMBER() OVER(ORDER BY UnitPrice asc) AS 'ROW_NUMBER',
		RANK() OVER(ORDER BY UnitPrice asc) AS 'RANK',
		DENSE_RANK() OVER(ORDER BY UnitPrice asc) AS 'DENCE_RANK',
		NTILE(12) OVER(ORDER BY UnitPrice asc) AS 'NTILE' -- ordenou pelo preco e viu a quantidade de linhas na tabela e criou 12 grupos
	FROM Track
	
----
SELECT TrackId, 
		name, 
		albumId,
		Composer,
		Milliseconds, 
		GenreId,
		UnitPrice,
		ROW_NUMBER() OVER(ORDER BY UnitPrice asc) AS 'ROW_NUMBER',
		RANK() OVER(ORDER BY UnitPrice asc) AS 'RANK',
		DENSE_RANK() OVER(ORDER BY UnitPrice asc) AS 'DENCE_RANK',
		NTILE(12) OVER(PARTITION BY GenreId ORDER BY UnitPrice asc) AS 'NTILE' 
	FROM Track
---------------------------------------------------------------------------------------------
-- Função de agregação 01

use BikeStores

select 
	P.CategoryID,
	COUNT(*) as TotalProdutos 
from Production.Product P
group by P.CategoryID;


select 
	P.CategoryID,
	P.BrandId,
	COUNT(*) as TotalProdutos 
from Production.Product P
group by P.BrandId, P.CategoryID;

--------------------------------------------------
With Total_por_categoria  as 
(
	select 
	P.CategoryID,
	COUNT(*) as TotalProdutos 
from Production.Product P
group by P.CategoryID
)

select 
	P.CategoryID,
	P.BrandId,
	COUNT(*) as TotalProdutos,
	Tc.TotalProdutos,
	COUNT(*)*100.0/Tc.TotalProdutos as 'Percent'
from Production.Product P
inner join Total_por_categoria TC on TC.CategoryID = P.CategoryID
group by P.CategoryID, P.BrandId, Tc.TotalProdutos;

----------------------------------------------------------------------
With Total_por_categoria  as 
(
	select 
	P.CategoryID,
	COUNT(*) as TotalProdutos 
from Production.Product P
group by P.CategoryID
)
select 
	P.CategoryID,
	P.BrandId,
	COUNT(*) as TotalProdutos,
	Tc.TotalProdutos as TotalCategoria,
	COUNT(*)*100.0/Tc.TotalProdutos as 'Percent'
from Production.Product P
inner join Total_por_categoria TC on TC.CategoryID = P.CategoryID
group by P.CategoryID, P.BrandId, Tc.TotalProdutos;

--------
-- Usando Window funcion para agregar -- 02

with Total_produtos_categoria as
(
select 
	P.CategoryID,
	P.BrandId,
	COUNT(*) as TotalProdutos 
from Production.Product P
group by P.BrandId, P.CategoryID
)
select 
	*,
	SUM(TotalProdutos) over(Partition by CategoryID) as TotalBikesCategoria,
	TotalProdutos *100.0/SUM(TotalProdutos) over(Partition by CategoryID) as 'Percent'
from Total_produtos_categoria;

---------------------------------------------------------
-- 03 

use BikeStores

select 
	P.CategoryID,
	P.BrandID,
	P.ProductID,
	P.Name,
	COUNT(*) over() as Produtos,
	COUNT(*) over(PARTITION BY P.BrandID) as Produtos_Brand,
	SUM(P.listPrice)OVER() as Soma_precos,
	SUM(P.listPrice)OVER(PARTITION BY P.BrandID) as Precos_Brand,
	AVG(P.listPrice)OVER() as Precos_Avg,
	MAX(P.listPrice)OVER() as Precos_Maxima,
	MIN(P.listPrice)OVER() as Precos_Minima

from Production.Product P
where P.CategoryID = 1 
Order by BrandID;

--------------------------------------------------------------------
-- Acumulando Valores 

Use ContosoRetailDW;

With TOTAL_VENDAS(ANO, MES, VENDAS) AS 
(
	select 
		DATEPART(YEAR, S.DateKey) as ANO, 
		DATEPART(MONTH, S.DateKey) as MES
	FROM FactOnlineSales S
	GROUP BY DATEPART(YEAR, S.DateKey), DATEPART(MONTH, S.Datekey)
)
select 
	ANO, MES, 
	FORMAT(VENDAS, 'C0') as 'VENDAS',
	FORMAT(SUM(VENDAS) OVER(PARTITION BY ANO ORDER BY MES), 'C0') as VENDAS_YTD,
	FORMAT(SUM(VENDAS) OVER(PARTITION BY ANO), 'C0') as VENDAS_TOTAL_ANO

FROM TOTAL_VENDAS
order by ANO, MES;

-----------------------------------------------------------------------------
-- Função de Afregação com FRAME -- uma janela de dadoas

With TOTAL_VENDAS(ANO, MES, VENDAS) AS 
(
	select 
		DATEPART(YEAR, S.DateKey) as ANO, 
		DATEPART(MONTH, S.DateKey) as MES
	FROM FactOnlineSales S
	GROUP BY DATEPART(YEAR, S.DateKey), DATEPART(MONTH, S.Datekey)
)
select 
	ANO, MES, 
	FORMAT(VENDAS, 'C0') as 'VENDAS',
	FORMAT(SUM(VENDAS) OVER(PARTITION BY ANO ORDER BY ANO, MES ASC  --- particione por ano, ordene por ano e mes 
						 ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), 'C0') as VENDAS_YTD,  -- vai trazer tudo antreior nessa linha atual
	FORMAT(AVG(VENDAS) OVER(PARTITION BY ANO ORDER BY ANO, MES ASC  
						 ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), 'C0') as VENDAS_AVG,
	FORMAT(AVG(VENDAS) OVER(PARTITION BY ANO ORDER BY ANO, MES ASC  
						 ROWS BETWEEN 3 PRECEDING AND 1 PRECEDING), 'C0') as VENDAS_AVG_3M
	FROM TOTAL_VENDAS
order by ANO, MES;

----------------------------------------------------------------------------------------------------------------
--- Funções OFF SET LAG e LEAD

With TOTAL_VENDAS(ANO, MES, VENDAS) AS 
(
	select 
		DATEPART(YEAR, S.DateKey) as ANO, 
		DATEPART(MONTH, S.DateKey) as MES
	FROM FactOnlineSales S
	GROUP BY DATEPART(YEAR, S.DateKey), DATEPART(MONTH, S.Datekey)
)
select 
	ANO, MES,
	FORMAT(VENDAS, 'C0') as 'VENDAS',
	FORMAT(LAG(VENDAS, 1, 0)over(order by ANO, MES ASC),  'C0') as Mes_anterior, -- LAG - trazer o mes/periodo anterior
	FORMAT(LEAD(VENDAS, 1, 0)over(order by ANO, MES ASC),  'C0') as Mes_posterir -- LEAD - trazer o mes/periodo posterios

FROM TOTAL_VENDAS
order by ANO, MES;

---------------------
use BikeStores

select 
	c.CustomerID,
	c.LastName,
	c.FirstName,
	o.OrderId,
	LAG(o.OrderID, 1, o.OrderID)OVER(PARTITION BY c.CustomerID ORDER BY o.orderId) as Ultima_order
from Sales.Customer c 
inner join Sales.[Order] o on c.CustomerID = o.CustomerID
order by c.CustomerID