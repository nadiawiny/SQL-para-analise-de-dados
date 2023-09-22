/*Agrupando Dados*/
 use ContosoRetailDW

-- Funções de agregação - MAX, MIN, AVG, COUNT, SUM 

-- SOMANDO - SUM
select 
		SUM(SalesAmount) as quantidade_total
	from FactSales

-- MÉDIA - AVG 
select 
		AVG(SalesAmount) as Média
	from FactSales

-- Contagem - COUNT 
select 
		COUNT(SalesAmount) as contagem
	from FactSales

-- Máxio - MAX
select 
		MAX(SalesAmount) as Valor_máxino
	from FactSales

-- Minimo - MIN
select 
		MIN(SalesAmount) as Valor_minimo
	from FactSales

/*GROUP BY */

-- quanto cada canal de vendas, vende ou já vendeu 

select 
		s.channelKey, 
		s.PromotionKey,
		SUM (s.SalesAmount) as soma,
		AVG (s.SalesAmount) as média,
		MIN (s.SalesAmount) as minimo,
		MAX (s.SalesAmount) as maximo,
		COUNT (s.SalesAmount) as contagem
	from FactSales as s
group by s.channelKey, s.PromotionKey
order by s.channelKey, s.PromotionKey

/*GROUP BY com WHERE*/

select 
		s.channelKey, 
		s.PromotionKey,
		SUM (s.SalesAmount) as soma,
		AVG (s.SalesAmount) as média,
		MIN (s.SalesAmount) as minimo,
		MAX (s.SalesAmount) as maximo,
		COUNT (s.SalesAmount) as contagem
	from FactSales as s
		where 
			s.channelKey in (1, 2) and 
			s.PromotionKey between 1 and 5
group by s.channelKey, s.PromotionKey
order by s.channelKey, s.PromotionKey

/* GROUP BY com JOIN*/

select 
		s.channelKey, 
		c.ChannelName,
		s.PromotionKey,
		p.PromotionName,
		SUM (s.SalesAmount) as soma,
		AVG (s.SalesAmount) as média,
		MIN (s.SalesAmount) as minimo,
		MAX (s.SalesAmount) as maximo,
		COUNT (s.SalesAmount) as contagem
	from FactSales as s
join DimChannel as c on c.channelKey = s.channelKey
join DimPromotion as p on p.PromotionKey = s.PromotionKey
		where 
			s.channelKey in (1, 2) and 
			s.PromotionKey between 1 and 5
group by s.channelKey, c.ChannelName, s.PromotionKey, p.PromotionName
order by s.channelKey, s.PromotionKey

/*HAVING - filtra os nossos dados agrupados*/

select 
		s.ProductKey,
		SUM (s.SalesQuantity) as qtd_total
from FactSales as s
where s.Datekey >= '2009'
group by s.ProductKey
having SUM (s.SalesQuantity) between 1500 and 1600
order by qtd_total desc

/*WITH ROLLUP - total para cada grupo*/

select 
		g.RegionCountryName,
		st.StoreName,
		SUM (s.SalesQuantity) as qtd_total
from FactSales as s
join DimStore as st on st.storekey = s.storekey
join DimGeography as g on g.GeographyKey = st.GeographyKey
group by g.RegionCountryName, st.StoreName
with rollup        -- faz a soma da quantidade de cada grupo
