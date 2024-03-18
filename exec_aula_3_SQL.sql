CREATE DATABASE exec_aula_3_SQL
USE exec_aula_3_SQL

CREATE TABLE produto (
codigo		INT				NOT NULL,
nome		VARCHAR(100)	NOT NULL,
valor		DECIMAL(7,2)	NOT NULL
PRIMARY KEY (codigo)
)
GO
CREATE TABLE entrada (
codigo_Transacao	INT				NOT NULL,
codigo_Produto		INT				NOT NULL,
quantidade			INT				NOT NULL,
valor_Total			DECIMAL(7,2)	NOT NULL
PRIMARY KEY (codigo_Transacao)
FOREIGN KEY (codigo_Produto) REFERENCES produto(codigo)
)
GO
CREATE TABLE saida (
codigo_Transacao	INT				NOT NULL,
codigo_Produto		INT				NOT NULL,
quantidade			INT				NOT NULL,
valor_Total			DECIMAL(7,2)	NOT NULL
PRIMARY KEY (codigo_Transacao)
FOREIGN KEY (codigo_Produto) REFERENCES produto(codigo)
)

INSERT INTO produto VALUES (1,'graveto',3)


DROP PROCEDURE sp_insereentrsaida
CREATE PROCEDURE sp_insereentrsaida (@codigo_Grupo CHAR(1), @codigo_Produto CHAR(1), @codigo_Transacao INT, @quantidade INT, @valor_Total Decimal(7,2), @erro VARCHAR(100) OUTPUT)
AS
	DECLARE	@querry	varchar(300),
			@tabela varchar(40)
			

IF (@codigo_Grupo != 's' AND @codigo_Grupo != 'e')
	BEGIN
		SET @erro = 'Codigo invalido'
		RAISERROR(@erro,16,1)
	END
ELSE
	BEGIN
		IF (@codigo_Grupo = 's')
			BEGIN
				SET @tabela = 'saida'
			END
		ELSE
			BEGIN
				SET @tabela = 'entrada'
			END
		SET @querry = 'INSERT INTO ' + @tabela + ' VALUES ('+CAST(@codigo_Transacao AS varchar(100))+','+CAST(@codigo_Produto AS varchar(100))+','+
		CAST(@quantidade AS varchar(100))+','+CAST(@valor_Total AS varchar(100))+')'
		EXEC (@querry)
		SET @erro = 'Inserido'
	END


DECLARE @eu1 VARCHAR(100)
EXEC sp_insereentrsaida 's',1,1,2,34.5, @eu1 OUTPUT
PRINT @eu1

DECLARE @eu2 VARCHAR(100)
EXEC sp_insereentrsaida 'e',1,1,2,3.5, @eu2 OUTPUT
PRINT @eu2

DECLARE @eu3 VARCHAR(100)
EXEC sp_insereentrsaida 'q',1,1,2,34.5, @eu3 OUTPUT
PRINT @eu3

SELECT * FROM produto
SELECT * FROM entrada
SELECT * FROM saida

