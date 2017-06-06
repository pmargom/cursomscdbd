-- CREAMOS UN PROCEDIMIENTO ALMACENADO
CREATE PROCEDURE GET_COCHE_POR_MARCA
AS
BEGIN
	SELECT Coches.*, Marcas.denominacion as denominacionMarca
	FROM Marcas
		INNER JOIN Coches on Marcas.id = Coches.idMarca
	--PRINT 'MI PRIMER PROCEDIMIENTO ALMACENADO'
END

-- PROCEDIMIENTO PARA EL EJERCICIO DEL VIERNES 02/06
CREATE PROCEDURE GET_COCHE_POR_MARCA_MATRICULA_PLAZAS
AS
BEGIN
	SELECT 
		 M.denominacion as Marca
		,C.matricula
		,C.nPlazas
	FROM Marcas M
		INNER JOIN Coches C ON M.id = C.idMarca
	GROUP BY 
		 M.denominacion
		,C.matricula
		,C.nPlazas
	ORDER BY nPlazas
END

CREATE PROCEDURE GET_COCHE_POR_MARCA_MATRICULA_PLAZAS_2
	  @marca nvarchar(50) = NULL
	, @nPlazas smallint = NULL
AS
BEGIN
	SELECT 
		 M.denominacion as Marca
		,C.matricula
		,C.nPlazas
	FROM Marcas M
		INNER JOIN Coches C ON M.id = C.idMarca
	WHERE 
		(M.denominacion LIKE '%' + @marca + '%' OR @marca is null)
	and	(C.nPlazas >= @nPlazas OR @nPlazas is null)
	ORDER BY nPlazas
END

CREATE PROCEDURE [dbo].[GET_COCHE_POR_MARCA_ID]
	@id bigint
AS
BEGIN
SELECT 
	  Marcas.denominacion as denominacionMarca
	, TiposCombustible.denominacion as denominacionTipoCombustible
	, Coches.idMarca
	, Coches.idTipoCombustible
	, Coches.id, Coches.matricula, Coches.color, Coches.nPlazas
	, Coches.fechaMatriculacion, Coches.cilindrada
FROM Marcas
	INNER JOIN Coches on Marcas.id = Coches.idMarca
	INNER JOIN TiposCombustible on Coches.idTipoCombustible = TiposCombustible.id
WHERE Coches.id = @id
GROUP BY 
	  Marcas.denominacion
	, TiposCombustible.denominacion
	, Coches.idMarca
	, Coches.idTipoCombustible
	, Coches.id, Coches.matricula, Coches.color, Coches.nPlazas
	, Coches.fechaMatriculacion, Coches.cilindrada
ORDER BY Marcas.denominacion

END

-- PROCEDIMIENTO PARA LISTAR LAS MARCAS
CREATE PROCEDURE GetMarcas
AS
BEGIN
	SELECT id, denominacion FROM Marcas
END