use ContosoRetaiDW

-- subquery / sub consulta

SELECT 
	AVG(SQ.VENDAS)
FROM(
	Select 
			DATEPART (YEAR, S.DateKey) as Ano, 
			DATEPART (MONTH, S.DateKey) as Mes, 
			SUM(S. SalesAmount) as VENDAS   
		FROM FactSales S 
	Group by DATEPART (YEAR, S.DateKey), DATEPART (MONTH, S.DateKey)
) as SQ

-- CTE - COMMON TABLE EXPRESSION -- tabela virtual

WITH SALES_MONTH_AVG(Ano, Mes, VENDAS)  -- DELCARO O WITH, COLOCO O NOME "APELIDO" DA MINHA NOVA TABELA E PEGO OS CAMPOS QUE PRESCISO
as
(
	SELECT  
			DATEPART (YEAR, S.DateKey) as Ano, 
			DATEPART (MONTH, S.DateKey) as Mes, 
			SUM(S. SalesAmount) as VENDAS    
		FROM FactSales S 
	Group by DATEPART (YEAR, S.DateKey), DATEPART (MONTH, S.DateKey)	
)
SELECT 
	AVG (SALES_MONTH_AVG.VENDAS) MEDIA_MENSAL
FROM SALES_MONTH_AVG

----------------------------------------------------------------------------------------------------------------------
-- Common Table Expression

WITH ANALISE_PRODUTO(Ano, Mes, Id_produto, Nome_produto, QTDE )
as 
(
	Select 
			DATEPART (YEAR, S.DateKey) as Ano, 
			DATEPART (MONTH, S.DateKey) as Mes, 
			S. ProductKey as Id_produto,
			S. ProducName as Nome_produto,
			SUM(S. SalesQuantity) as QTDE   
		FROM FactSales S 
	inner join DimProduct P ON P.ProductKey = S.ProductKey
	Group by DATEPART (YEAR, S.DateKey), DATEPART (MONTH, S.DateKey), S. ProductKey,S. ProducName
)
SELECT 
	AVG(QTDE)
FROM ANALISE_PRODUTO

------------------------------------------------------------------------------------------------------------------------

--CTE - EXEMPLO

WITH ANALISE_PRODUTO(Ano, Mes, Id_produto, Nome_produto, QTDE )
as 
(
	Select 
			DATEPART (YEAR, S.DateKey) as Ano, 
			DATEPART (MONTH, S.DateKey) as Mes, 
			S. ProductKey as Id_produto,
			S. ProducName as Nome_produto,
			SUM(S. SalesQuantity) as QTDE   
		FROM FactSales S 
	inner join DimProduct P ON P.ProductKey = S.ProductKey
	Group by DATEPART (YEAR, S.DateKey), DATEPART (MONTH, S.DateKey), S. ProductKey,S. ProducName
)

-- Qual foi o produto que mais vendeu?
SELECT TOP 1
	*
FROM ANALISE_PRODUTO
ORDER BY QTDE DESC

-- Me der tudo que tem disponivel

SELECT TOP 1
	A.*,
	P.*
FROM ANALISE_PRODUTO as A 
inner join  DimProduct P ON P.ProductKey = A.id_produto
ORDER BY QTDE DESC
