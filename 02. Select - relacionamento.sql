/*Relacionamentos entre tabelas */

use ContosoRetailDW
-- inner join

select * from DimChannel

-- me traga no nome sales, data, nome  channel relacionando com o canal de vendas 
select top 100 
		fs.SalesKey as id_vendas, 
		fs.DateKey as data,
		fs.channelKey as canal,
		ch.ChannelName as nome_canal_vendas
	from FactSales as fs
inner join DimChannel as ch
on ch.ChannelKey = fs.channelKey

----------------------------------------------------------
-- left joinn | pegar a table da esquerda "principal - parametro"

-- quantos produtos distintos eu tenho na minha tabela vendas e quantos eu tenho na minha tabela de produtos?

--> distinct() // eliminar repetições em consulta | count() // conta quantos dados tem na coluna

select 
		COUNT(DISTINCT(pd.ProductKey)) as quantidade_produtos
	--	COUNT(DISTINCT(fs.ProductKey)) as quantidade_vendas
	from DimProduct as pd
left join FactSales as fs
on pd.ProductKey = fs.ProductKey
---------------------------------------
select distinct
		pd.ProductKey,
		pd.ProductName,
		fs.ProductKey as 'fs.Productkey'
	from DimProduct as pd
left join FactSales as fs
on pd.ProductKey = fs.ProductKey
order by 3

-------------------------------------------------------------
-- Right  join - da tabela da direita como referencia

select distinct
		pd.ProductKey,
		pd.ProductName,
		fs.ProductKey as "fs.Productkey"
	from DimProduct as pd
right join FactSales as fs
on pd.ProductKey = fs.ProductKey
order by 3

-----------------------------------------------------------

-- Cross join - todos contra todos

select distinct
		pd.ProductKey,
		fs.ProductKey as "fs.Productkey"
	from DimProduct as pd
cross join FactSales as fs

----------------------------------------------------------

-- Full join - trazer tudo tanto da direita quanto da esquerda

select distinct
		pd.ProductKey,
		pd.ProductName,
		fs.ProductKey as "fs.Productkey"
	from DimProduct as pd
full join FactSales as fs
on pd.ProductKey = fs.ProductKey
order by 3
--------------------------------------------------------------
-- Multiplos joins na mesma consulta 
-- as vendas por categoria de produtos | por ptodutos| sub categora| categoria | 

select	top 100
		fs.SalesKey,
		fs.SalesAmount,
		pd.ProductKey,
		pd.Productname,
		pd.ProductSubcategoryKey,
		ps.ProductSubcategoryName,
		pc.ProductCategoryName
	from FactSales as fs
join DimProduct as pd on pd.ProductKey = fs.ProductKey
join DimProductSubcategory as ps on ps.ProductSubcategoryKey = pd.ProductSubcategoryKey
join DimProductCategory as pc on pc.ProductCategoryKey = ps.ProductCategoryKey

--------------------------------------------------------------------------------------
-- saber o continent ou cidade que esta relacionado com o produto
select	top 100
		fs.SalesKey,
		fs.SalesAmount,
		st.StoreName,
		g.ContinentName
	from FactSales as fs
join DimStore as st on st.StoreKey = fs.StoreKey
join DimGeography as g on g.GeographyKey = st.GeographyKey
--------------------------------------------------------------------
-- Join com where 
-- que morem na europa 

select	top 100
		fs.SalesKey,
		fs.SalesAmount,
		st.StoreName,
		g.ContinentName
	from FactSales as fs
join DimStore as st on st.StoreKey = fs.StoreKey
join DimGeography as g on g.GeographyKey = st.GeographyKey
where g.ContinentName = 'europe'
order by st.StoreName



