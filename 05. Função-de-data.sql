
use ContosoRetailDW

-- SET DATEFORMAT -- � uma fun��o que passa o formato de data que queremos trabalhar 
/*
	MDY M�s, dia e ano (formato padr�o americano)
	DMY Dia, m�s e ano
	YMD Ano, m�s e dia 
	YDM Ano, dia e m�s
	MYD M�s, ano e dia 
	DYM Dia, ano e m�s 
*/

SET DATEFORMAT YMD

Select DISTINCT 
		S.DateKey
	from FactOnlineSales S
where S.DateKey BETWEEN '2007-12-01' and '2007-12-31'

------------------------------------------------------------------------------

-- GETDATE -- � uma fun��o para ter a hora atual  

Select GETDATE() as data_atual -- sabendo a data e hora atual

Select GETDATE()+10 as data_atual_10 -- + 10 dias da a data atual 

Select  YEAR(GETDATE ()) as ANO -- busaca o ano 
Select  MONTH(GETDATE ()) as M�S -- busaca o m�s
Select  DAY(GETDATE ()) as DIA -- busaca o dia

-- buscar as vendas do ano de 2007 no m�s de dezembro especificamente do dia 31
select 
		*
	from FactOnlineSales
where YEAR(Datekey) = 2007 AND 
	MONTH(Datekey) = 12 AND 
	DAY(DateKey) = 31

-------------------------------------------------------------------------------

-- DATEPART -- � uma fun��o para extrairmos parte de uma data  - retornando um numero inteiro

/*
	====================================================================================
		Valor			||  Parte Retonada					||		Abrivia��o 
	====================================================================================
		year			|| Ano 								||		yy, yyyy
		quarter		    || Trimestre (1/4 de ano)			||		qq, q
		month		    || M�s  							||		mm, m 
		dayofyear 		|| Dia do ano  						||		dy, y
		day  		    || Dia  							||		dd, d
		week 	     	|| Semana 							||		wk, ww
		weekday 		|| Dia da semana  					||		dw
		hour 		    || Hora 							||		hh
		minute 		    || Minuto 							||		mi, n 
		second		    || Segundo 							||		ss, s
	====================================================================================
*/

Select TOP 100
	S.DateKey,
	DATEPART(YEAR, S.DateKey) as Ano,
	DATEPART(MONTH, S.DateKey) as M�s,
	DATEPART(DAY, S.DateKey) as Dia,
	DATEPART(DAYOFYEAR, S.DateKey) as dia_do_ano,
	DATEPART(WEEKDAY, S.DateKey) as dia_da_semana
from FactOnlineSales S
order by S.DateKey desc

SELECT DATEPART(WEEKDAY, GETDATE()) as dia_da_semana -- pegando o dia da semana atual 

Select TOP 100 *
	FROM FactOnlineSales
WHERE 
	DATEPART(DAY, DateKey) =31 and 
	DATEPART(MONTH, DateKey) =12 and 
	DATEPART(YEAR, DateKey) =2009
		
-------------------------------------------------------------------------------------------------

-- DATENAME - � uma fun��o para pegar a parte da data- retornando em strig 

Select TOP 100
	S.DateKey,
	DATENAME(DAY, S.DateKey) as dia,
	DATENAME(WEEKDAY, S.DateKey) as dia_da_semana,
	DATEPART(WEEKDAY, S.DateKey) as dia_da_semana,
	DATENAME(MONTH, S.DateKey) as M�s
from FactOnlineSales S
where DATENAME(WEEKDAY, S.DateKey) = 'Sexta-feira'
order by S.DateKey desc

--------------------------------------------------------------------------------------------------

-- DATEADD - � uma fun��o onde voc� pode adicionar intervalos em uma data 
-- (intervalo, quantidade, data)
Select
	GETDATE() AS HOJE,
	DATEADD (DAY, 10, GETDATE()) AS DATA, -- dez dia da data atual
	DATEADD(MONTH, 1, GETDATE()) AS um_mes, -- a um me=�s
	DATEADD(MONTH, -12, GETDATE()) AS um_mes,
	DATEADD(YEAR, 1, GETDATE()) AS um_ano,
	DATEADD(HOUR, 1, GETDATE()) AS uma_hora
----------------------------------------------------------------------------------------------------

-- DATEDIFF - a diferencia de tempo entre duas datas
-- (intervalo, data_inicio, data_final)

Select DATEDIFF(DAY, '2023-07-10', GETDATE()) AS DIA 
Select DATEDIFF(MONTH, '2023-07-10', GETDATE()) AS M�S
Select DATEDIFF(YEAR, '2022-07-10', GETDATE()) AS Ano

Select DISTINCT TOP 10
	S.DateKey,
	GETDATE(),
	DATEDIFF(DAY, S.DateKey, GETDATE())
FROM FactOnlineSales S 
ORDER BY 1 DESC
---------------------------------------------------------------------------------------

-- EOMONTH - a fun��o para mostra o final do m�s 

-- END OF MONTH
select EOMONTH(GETDATE())

-- ADICIONANDO 01 M�S 
select 
	GETDATE() AS HOJE, 
	EOMONTH(GETDATE()) AS FINAL_ESSE_MES,
	EOMONTH(GETDATE(), 1) AS FINAL_ADICIONANDO_UM_MES,
	EOMONTH(GETDATE(), -1) AS SUBTRAINDO_UM_MES

---------------------------------------------------------------------------------------------------

-- FORMAT - para formatar a data em formato visual 

/*
	========================================================
		FORMATO			||  DESCRI��O					
	=========================================================
		d				|| Dia com 1 d�gitos 							
		dd			    || Dia com 2 d�gitos 		
		ddd				|| Abrevia��o do dia da semana 							
		dddd 			|| Nome do dia da semana			
		M			    || M�s com 1 d�gitos			
		MM 		     	|| M�s com 2 d�gitos		
		MMM		 		|| Abrevia��o do nome do m�s   					
		MMMM		    || Nome do m�s				
		yy			    || Ano com 2 d�gitos				
		yyyy		    || Ano com 4 d�gotos
		hh				|| Horas de 1 a 12
		HH				|| Horas de 0 a 23 	
		mm				|| Minuto 	
		ss				|| Segundo 	
		fff				|| mil�simo de segundo
	==========================================================
*/

Select 
	GETDATE(),
	FORMAT(GETDATE(), 'yyyy/MM/dd HH:mm:ss'),
	FORMAT(GETDATE(), 'yyyy-MM')
