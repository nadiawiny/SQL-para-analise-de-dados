
use ContosoRetailDW

/*Selecionando todas as colunas de uma tabela*/

select * from FactSales

select * from DimEmployee

/*Selecinonado colunas especificas*/

select  StoreKey,
		StoreManager, 
		StoreType, 
		StoreName
from DimStore

/*Colunas com Alias - apelidando colunas- 'as'*/

select  StoreKey as 'id',
		StoreManager as 'gerentes', 
		StoreType as 'tipo de loja', 
		StoreName as 'nome das lojas'
from DimStore

/*Ordenando Colunas -- ORDER BY >> desc ou asc*/

Select *
from DimStore order by StoreName desc -- decrecente 

Select *
from DimStore order by StoreKey asc -- acendente > crescente 

/*Ordenar dados com multiplas colunas*/

select Gender,
	   MaritalStatus,
	   TotalChildren,
	   NumberChildrenAtHome
from DimCustomer
order by Gender desc, MaritalStatus desc, TotalChildren desc, NumberChildrenAtHome desc

/*Ordenando por posição e alias*/

select EmailAddress,
	   Gender,
	   MaritalStatus,
	   TotalChildren,
	   NumberChildrenAtHome,
	   NumberCarsOwned as 'quantidade carros'
from DimCustomer
order by 2 desc, 3 desc, 4 desc, 5 desc, 'quantidade carros' -- ou ['quantidade carros']

/*Selecionando por TOP linhas -- quantidade de linhas*/

	select TOP 1000
		   EmailAddress,
		   Gender,
		   MaritalStatus,
		   TotalChildren,
		   NumberChildrenAtHome,
		   NumberCarsOwned as 'quantidade carros'
	from DimCustomer
	order by 2 desc, 3 desc, 4 desc, 5 desc, 'quantidade carros'

/* Selecionando TOP WITH TIES -- trazer quem ta impatando */

select TOP 100 with ties 
	   EmailAddress,
	   Gender,
	   MaritalStatus,
	   TotalChildren,
	   NumberChildrenAtHome,
	   NumberCarsOwned as 'quantidade carros'
from DimCustomer
order by 2 desc, 3 desc, 4 desc, 5 desc, 'quantidade carros'

/* Selecionando WHERE - condição para filtrar algo*/

select TOP 10 with ties 
	   EmailAddress,
	   Gender,
	   MaritalStatus,
	   TotalChildren,
	   NumberChildrenAtHome,
	   NumberCarsOwned as 'quantidade carros'
from DimCustomer 
where NumberChildrenAtHome = 0
order by 2 desc, 3 desc, 4 desc, 5 desc, 'quantidade carros'

---------------------------------------------------------

select TOP 10 with ties 
	   EmailAddress,
	   Gender,
	   MaritalStatus,
	   TotalChildren,
	   NumberChildrenAtHome,
	   NumberCarsOwned as 'quantidade carros',
	   Education
from DimCustomer 
where Education = 'High School'
order by 2 desc, 3 desc, 4 desc, 5 desc, 'quantidade carros'

/*Operadores Logicos - AND - > | < | >= | <= - NOT - OR °° Processo de analise exploratória  */

select TOP 100 with ties 
	   EmailAddress,
	   Gender,
	   MaritalStatus,
	   TotalChildren,
	   NumberChildrenAtHome,
	   NumberCarsOwned as 'quantidade carros',
	   Education
from DimCustomer 
where Education = 'High School' -- educação ser High School
	and  NumberChildrenAtHome >= 4 -- ter 4 ou mais filhos em casa
	and not MaritalStatus = 'M' -- não pode ser casado
	and (TotalChildren = 3 or TotalChildren = 4) -- total de filhos tem que ser 3 ou 4
order by 2 desc, 3 desc, 4 desc, 5 desc, 'quantidade carros'

/* Operador IN*/
select 
	   EmailAddress,
	   Gender,
	   MaritalStatus,
	   TotalChildren,
	   NumberChildrenAtHome,
	   NumberCarsOwned as 'quantidade carros',
	   Education
from DimCustomer 
where Education IN ('Bachelors', 'Bachelors' )
	and  NumberChildrenAtHome >= 4 
	and not MaritalStatus = 'M' -- não pode ser casado
	and TotalChildren IN (3, 4)

/* IS NULL -- valores nulos/vazios*/
select 
	   EmailAddress,
	   Gender,
	   MaritalStatus,
	   TotalChildren,
	   NumberChildrenAtHome,
	   NumberCarsOwned as 'quantidade carros',
	   Education
from DimCustomer 
where 
	 MaritalStatus IS NULL  --Quem não preenchel MaritalStatus não preenchel os demais campos por isso tudo é NULL


/*BETWEEN*/
select 
	   EmailAddress,
	   Gender,
	   MaritalStatus,
	   TotalChildren,
	   NumberChildrenAtHome,
	   NumberCarsOwned as 'quantidade carros',
	   Education,
	   BirthDate
from DimCustomer 
where 
	 MaritalStatus IS NOT NULL
	-- and TotalChildren >= 2 and TotalChildren <= 4
	-- AND TotalChildren BETWEEN 2 AND 4 
	and BirthDate BETWEEN '1950-01-01' and '1960-01-01'
order by BirthDate desc

/*NOT - */

select 
	   EmailAddress,
	   Gender,
	   MaritalStatus,
	   TotalChildren,
	   NumberChildrenAtHome,
	   NumberCarsOwned as 'quantidade carros',
	   Education,
	   BirthDate
from DimCustomer 
where 
	 MaritalStatus IS NOT NULL -- não estão com estados civil nulo
	AND NOT TotalChildren BETWEEN 2 AND 4 -- noão tenham entre 2 e 4 filho
	AND NOT BirthDate BETWEEN '1950-01-01' and '1960-01-02'  -- não nasceram nos anos 50
	AND NumberChildrenAtHome NOT IN(0, 1, 5) -- não pode ter 0, 1, 5 filhos em casa
order by NumberChildrenAtHome asc

/*Concatenando - CONCAT (NOME, ' ', SOBRENOME' ') ou  NOME + ' ' + SOBRENOME ou   */

select 
		-- CONCAT (FirstName, ' ', LastName, ' ', MiddleName) as "nome_completo"
		 FirstName + ' '+ LastName as 'nome_completo'
	from DimEmployee

/*Like */
 
select 
		 FirstName + ' '+ LastName as 'nome_completo'
	from DimEmployee
where FirstName + ' '+ LastName like 'Aaron Painter'

-----------------------------------------------------
 -- todos que começam com Aaraon
 select 
		 FirstName + ' '+ LastName as 'nome_completo'
	from DimEmployee
where FirstName + ' '+ LastName like 'Aaron%'

 -- todos que tem paul no nome
 select 
		 FirstName + ' '+ LastName as 'nome_completo'
	from DimEmployee
where FirstName + ' '+ LastName like '%paul%'

 -- todos que termina com allen
 select 
		 FirstName + ' '+ LastName as 'nome_completo'
	from DimEmployee
where FirstName + ' '+ LastName like '%allen'
------------------------------------------------------
 select 
		 FirstName + ' '+ LastName as 'nome_completo'
	from DimEmployee
where FirstName + ' '+ LastName like 'a%' -- pegou todos que começam com a 

