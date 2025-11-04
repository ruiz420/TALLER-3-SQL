USE DivisionPolitica

--Eliminamos la columna MONEDA

ALTER TABLE Pais
DROP COLUMN Moneda;

-- CREAMOS LA TABLA MONEDA 

CREATE TABLE Moneda( 
    Id INT IDENTITY(1,1) NOT NULL, 
    CONSTRAINT pkMoneda_Id PRIMARY KEY (Id),
    Moneda NVARCHAR(50) NOT NULL,
    Sigla NVARCHAR(10) NOT NULL,
    Imagen NVARCHAR(200) NULL
)

--AGREGAR LOS NUEVOS CAMPOS EN TABLA PAIS
ALTER TABLE Pais
ADD IdMoneda INT NULL,
    Mapa NVARCHAR(200) NULL,
    Bandera NVARCHAR(200) NULL;

-- RELACIONR CON LA TABLA MONEDA (CLAVE FORANEA)
ALTER TABLE Pais
ADD CONSTRAINT Pk_Pais_IdMoneda FOREIGN KEY (IdMoneda) REFERENCES Moneda(Id);

-- VERIFICAMOS QUE QUEDO CREADA LA TABLA 
SELECT *
FROM Moneda

UPDATE Pais
SET IdMoneda = 1
WHERE Nombre = 'URUGUAY';


-- CREAMOS EL REGISTRO MONEDA, SIGLA, IMAGEN 
INSERT INTO Moneda (Moneda, Sigla, Imagen)
VALUES ('Peso uruguayo', 'uyu', 'url\\uyu.png');

-- insertamos url de las imagenes 
UPDATE Pais
SET 
    Mapa = 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9a/Uruguay%2C_administrative_divisions_-_de_-_colored.svg/960px-Uruguay%2C_administrative_divisions_-_de_-_colored.svg.png',
    Bandera = 'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Flag_of_Uruguay.svg/512px-Flag_of_Uruguay.svg.png'
WHERE Nombre = 'URUGUAY';

-- VERIFICAMOS 

SELECT P.Nombre, P.IdMoneda, M.Moneda, M.Sigla
FROM Pais P
LEFT JOIN Moneda M ON P.IdMoneda = M.Id
WHERE P.Nombre = 'URUGUAY';


--  Resultado final

CREATE VIEW vDivisionPolitica
AS
SELECT 
    P.Nombre AS Pais, 
    C.Nombre AS Continente, 
    TR.TipoRegion AS TipoRegion, 
    M.Moneda AS Moneda, 
    M.Sigla AS SiglaMoneda,
    M.Imagen AS ImagenMoneda,  
    P.Mapa,           
    P.Bandera        
FROM Pais P
    JOIN Continente C ON P.IdContinente = C.Id
    JOIN TipoRegion TR ON P.IdTipoRegion = TR.Id
    JOIN Moneda M ON P.IdMoneda = M.Id
WHERE P.Nombre = 'URUGUAY';






