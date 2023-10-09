/*É quando pegamos uma consulta dentro de outra consulta - pegar uma consulta pra filtrar outra */

use ContosoRetailDW

/*SUBQUERES / SUBSELECT */
-- Qual é os preços médios de todos os produtos e que estejam abaixo da média? 

select 
		ProductKey,
		UnitPrice
	from DimProduct
where UnitPrice <= (select AVG(UnitPrice) from DimProduct) -- a subselect  
order by UnitPrice desc

/*Subqueres com in | not in*/

-- todas as vendas diacordo com a quantidade de produtos

select *              -- filtrando todas as vendas dos produtos
	from FactSales as s
where s.ProductKey in (   
	select 
			ProductKey
		from DimProduct
	where UnitPrice <= (select AVG(UnitPrice) from DimProduct) -- a subselect pra encontrar o preço
) -- para encontrar a lista dos produtos que estavam com o preço abaixo da média
order by UnitPrice desc

-- NOT IN 

-- me traga todas as vendas que não estão no criterio de vendas que são iguais ou menores que 356 dolares (a média)

select * 
	from FactSales as s
where s.ProductKey not in (   
	select 
			ProductKey
		from DimProduct
	where UnitPrice <= (select AVG(UnitPrice) from DimProduct) 
)
order by UnitPrice asc

/*Subselect com JOIN*/

-- quero os top 5 produtos que venderam e traga todas as vendas deles

-- Top 5 de maior venda 
select top 5
			s.ProductKey,
			SUM(s.SalesAmount) as sales
		from FactSales as s
	group by s.ProductKey
	order by sales desc

-- todos os produtos com maior vendas (TOP 5)

select
		s2.*
	from FactSales as s2
inner join (
	select top 5
			s.ProductKey,
			SUM(s.SalesAmount) as sales
		from FactSales as s
	group by s.ProductKey
	order by sales desc
) as TOP5 on TOP5.ProductKey = s2.ProductKey

-- validação 
select 
	DISTINCT (VAL.ProductKey)
	from (
		select
				s2.*
			from FactSales as s2
		inner join (
			select top 5
					s.ProductKey,
					SUM(s.SalesAmount) as sales
				from FactSales as s
			group by s.ProductKey
			order by sales desc
		) as TOP5 on TOP5.ProductKey = s2.ProductKey
) as VAL
