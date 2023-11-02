
/*DECLARANDO VARIAVEL */
-- Variavel - é um espaço que você reserva na memoria do seu computador 

DECLARE @USUARIO VARCHAR(30) -- declarando a variavel	
SET @USUARIO = 'MARIA' -- dando o valor 

select @USUARIO as nome 
--------------------------------------------------------
use ContosoRetailDW

DECLARE @PROD INT
SET @PROD = 782

select TOP 100 * 
	FROM FactOnlineSales
WHERE ProductKey = @PROD
---------------------------------------------------------
/*FUNÇÕES BASICAS DE TEXTO */

DECLARE @USER VARCHAR(30)
SET @USER = ' José José '

select 
	@USER,
	LEN(@USER),  -- para contar quantos caracteres limpando o espaço direito 
	RTRIM(@USER), -- limpa o espaco da direita
	LTRIM(@USER), -- limpa o espaço da esquerda
	TRIM(@USER), -- limpa o espaço da direita e esquerda 
	UPPER(@USER), -- deixar tudo maiusculo
	LOWER(@USER) -- deixa tudo minusculo

-------------------------------------------------------------------

/* CONCATENAR */

DECLARE @USER VARCHAR(30)
SET @USER = ' Maria Maria '

DECLARE @USER2 VARCHAR(30)
SET @USER2 = ' José José '

select 
	@USER + @USER2,
	CONCAT(@USER, @USER2),  -- usando a função
	CONCAT(@USER, '-', @USER2)
-------------------------------------------------------------------

/* Substituição de Texto*/

select 
		'sql para analise de dados',
	REPLACE('sql para analise de dados', 'analise', 'análise'), -- substituição
	REPLACE(TRIM('sql para analise de dados'), 'de dados', '')  -- remorção 
-------------------------------------------------------------------------

/*Extração de partes de uma string */

select 
		'SQL é mais legal que Power Bi',
	SUBSTRING('SQL é mais legal que Power Bi', 12, 5 ) AS SUB, -- sting, apartir, quantas casas
	RIGHT('SQL é mais legal que Power Bi', 8 ) AS 'RIGHT', -- ultimos da direita
	LEFT('SQL é mais legal que Power Bi', 3) AS 'LEFT',  -- primeiros da esquerda
	LEFT(RIGHT('SQL é mais legal que Power Bi', 8),5) AS 'LEFT RIGHT', -- a esquerda da direita 
	CHARINDEX('mais', 'SQL é mais legal que Power Bi') as 'CHARINDEX', -- ele vai retornar onde começa o mais 
	LEN('SQL é mais legal que Power Bi') as 'LEN', -- pegar a quantidade total da string
	RIGHT('SQL é mais legal que Power Bi', LEN('SQL é mais legal que Power Bi')-CHARINDEX('mais', 'SQL é mais legal que Power Bi')+1)
