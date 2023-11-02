
/*DECLARANDO VARIAVEL */
-- Variavel - � um espa�o que voc� reserva na memoria do seu computador 

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
/*FUN��ES BASICAS DE TEXTO */

DECLARE @USER VARCHAR(30)
SET @USER = ' Jos� Jos� '

select 
	@USER,
	LEN(@USER),  -- para contar quantos caracteres limpando o espa�o direito 
	RTRIM(@USER), -- limpa o espaco da direita
	LTRIM(@USER), -- limpa o espa�o da esquerda
	TRIM(@USER), -- limpa o espa�o da direita e esquerda 
	UPPER(@USER), -- deixar tudo maiusculo
	LOWER(@USER) -- deixa tudo minusculo

-------------------------------------------------------------------

/* CONCATENAR */

DECLARE @USER VARCHAR(30)
SET @USER = ' Maria Maria '

DECLARE @USER2 VARCHAR(30)
SET @USER2 = ' Jos� Jos� '

select 
	@USER + @USER2,
	CONCAT(@USER, @USER2),  -- usando a fun��o
	CONCAT(@USER, '-', @USER2)
-------------------------------------------------------------------

/* Substitui��o de Texto*/

select 
		'sql para analise de dados',
	REPLACE('sql para analise de dados', 'analise', 'an�lise'), -- substitui��o
	REPLACE(TRIM('sql para analise de dados'), 'de dados', '')  -- remor��o 
-------------------------------------------------------------------------

/*Extra��o de partes de uma string */

select 
		'SQL � mais legal que Power Bi',
	SUBSTRING('SQL � mais legal que Power Bi', 12, 5 ) AS SUB, -- sting, apartir, quantas casas
	RIGHT('SQL � mais legal que Power Bi', 8 ) AS 'RIGHT', -- ultimos da direita
	LEFT('SQL � mais legal que Power Bi', 3) AS 'LEFT',  -- primeiros da esquerda
	LEFT(RIGHT('SQL � mais legal que Power Bi', 8),5) AS 'LEFT RIGHT', -- a esquerda da direita 
	CHARINDEX('mais', 'SQL � mais legal que Power Bi') as 'CHARINDEX', -- ele vai retornar onde come�a o mais 
	LEN('SQL � mais legal que Power Bi') as 'LEN', -- pegar a quantidade total da string
	RIGHT('SQL � mais legal que Power Bi', LEN('SQL � mais legal que Power Bi')-CHARINDEX('mais', 'SQL � mais legal que Power Bi')+1)
