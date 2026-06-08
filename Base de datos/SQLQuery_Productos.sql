USE TpArqWeb
-- CREACION DE TABLAS
-- 1. Tabla Base: Productos
CREATE TABLE PRODUCTO (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(200) NOT NULL,
    preciobase DECIMAL(18, 2) NOT NULL,
    imagen VARBINARY(max),
    stock INT NOT NULL
);
GO

-- 2. Tabla Derivada: Insumos
CREATE TABLE INSUMO (
    -- El Id actúa como Primary Key y a la vez como Foreign Key a Productos
    id INT PRIMARY KEY,
    
    -- El Enum 'TipoMaterial' se guarda como INT (0=PLA, 1=PETG, etc.)
    material INT NOT NULL, 
    diametromilimetros DECIMAL(5, 2) NOT NULL,
    color NVARCHAR(50) NOT NULL,
    marca NVARCHAR(100) NOT NULL,
    kilogramos DECIMAL(12, 2) NOT NULL,

    CONSTRAINT FK_INSUMO_PRODUCTO FOREIGN KEY (Id) 
        REFERENCES PRODUCTO(id) ON DELETE CASCADE
);
GO

-- 3. Tabla Derivada: PiezasImpresas
CREATE TABLE PIEZAIMPRESA (
    -- El Id actúa como Primary Key y a la vez como Foreign Key a Productos
    id INT PRIMARY KEY,
    
    tiempoimpresionminutos INT NOT NULL,
    costodiseno DECIMAL(18, 2) NOT NULL,
    pesoconsumidogramos DECIMAL(12, 2) NOT NULL,
    
    -- Relación con el Insumo que consume (Foreign Key)
    insumoid INT NULL, 

    CONSTRAINT FK_PIEZAIMPRESA_PRODUCTO FOREIGN KEY (id) 
        REFERENCES PRODUCTO(id) ON DELETE CASCADE,

    CONSTRAINT FK_PIEZAIMPRESA_INSUMO FOREIGN KEY (insumoid) 
        REFERENCES INSUMO(Id) 
        -- NO usar ON DELETE CASCADE aquí para evitar ciclos o borrar piezas 
        -- accidentalmente si se elimina un filamento del catálogo
);
GO
-- FIN CREACION DE TABLAS

SELECT * FROM PRODUCTO
SELECT * FROM PIEZAIMPRESA
SELECT * FROM INSUMO

-- TRANSACCION PARA INSERTAR DATOS
-- Habilitar el bloque de transacciones para asegurar que se inserte todo correctamente
BEGIN TRANSACTION;

DECLARE @UltimoIdGenerado INT;
DECLARE @InsumoPlaRojoId INT;
DECLARE @InsumoPetgNegroId INT;

-- Insumo 1
INSERT INTO PRODUCTO (Nombre, PrecioBase, Imagen, stock)
VALUES ('Filamento PLA Rojo 1kg', 15000.00, 0x89554E470D0A1A0A, 10);
SET @InsumoPlaRojoId = SCOPE_IDENTITY();

INSERT INTO INSUMO (Id, Material, DiametroMilimetros, Color, Marca, kilogramos)
VALUES (@InsumoPlaRojoId, 0, 1.75, 'Rojo', 'Grilon3', 1);

-- Insumo 2
INSERT INTO PRODUCTO (Nombre, PrecioBase, Imagen, stock)
VALUES ('Filamento PETG Negro 1kg', 18000.00, NULL, 20);
SET @InsumoPetgNegroId = SCOPE_IDENTITY();

INSERT INTO INSUMO (Id, Material, DiametroMilimetros, Color, Marca, kilogramos)
VALUES (@InsumoPetgNegroId, 1, 1.75, 'Negro', 'Printalot', 1);

-- Pieza 1
INSERT INTO PRODUCTO (Nombre, PrecioBase, Imagen, stock)
VALUES ('Maceta Geométrica Groot', 3500.00, 0xFFD8FFE000104A464946, 30);
SET @UltimoIdGenerado = SCOPE_IDENTITY();

INSERT INTO PIEZAIMPRESA (Id, TiempoImpresionMinutos, CostoDiseno, PesoConsumidoGramos, InsumoId)
VALUES (@UltimoIdGenerado, 180, 600.00, 120.50, @InsumoPlaRojoId);

-- Pieza 2
INSERT INTO PRODUCTO (Nombre, PrecioBase, Imagen, stock)
VALUES ('Soporte Articulado Extrusor', 5200.00, NULL, 40);
SET @UltimoIdGenerado = SCOPE_IDENTITY();

INSERT INTO PIEZAIMPRESA (Id, TiempoImpresionMinutos, CostoDiseno, PesoConsumidoGramos, InsumoId)
VALUES (@UltimoIdGenerado, 320, 1200.00, 210.00, @InsumoPetgNegroId);

COMMIT TRANSACTION;
PRINT 'Tablas recreadas y datos cargados exitosamente sin SKU.';
GO
-- FIN TRANSACCION

SELECT * FROM PRODUCTO
SELECT * FROM PIEZAIMPRESA
SELECT * FROM INSUMO

DELETE FROM PRODUCTO WHERE id = 0
DELETE FROM PRODUCTO WHERE id = 0
DELETE FROM PRODUCTO WHERE id = 0
DELETE FROM PRODUCTO WHERE id = 0

-- ZONA PELIGROSA
DROP TABLE IF EXISTS PIEZAIMPRESA;
DROP TABLE IF EXISTS INSUMO;
DROP TABLE IF EXISTS PRODUCTO;
-----------------

-- QUERY PARA MOSTRAR TODOS LOS PRODUCTOS
SELECT 
    p.id, 
    p.nombre, 
    p.preciobase, 
    p.imagen,
    
    -- Columna virtual para que tu backend sepa qué clase instanciar
    CASE 
        WHEN i.id IS NOT NULL THEN 'Insumo'
        WHEN pi.id IS NOT NULL THEN 'PiezaImpresa'
    END AS tipoproducto,

    -- Campos exclusivos de Insumos (Vendrán en NULL si el producto es una pieza)
    i.material,
    i.diametromilimetros,
    i.color,
    i.marca,
    i.kilogramos,

    -- Campos exclusivos de Piezas Impresas (Vendrán en NULL si el producto es un insumo)
    pi.tiempoimpresionminutos,
    pi.costodiseno,
    pi.insumoid

FROM PRODUCTO p
LEFT JOIN INSUMO i ON p.Id = i.Id
LEFT JOIN PIEZAIMPRESA pi ON p.Id = pi.Id;
-- FIN QUERY


-- CREACION STORED PROCEDURE
CREATE PROC PRODUCTO_LISTAR
AS
BEGIN
	SELECT p.id, p.nombre, p.preciobase, p.imagen, p.stock
    
    -- Columna virtual para que tu backend sepa qué clase instanciar
    CASE 
        WHEN i.id IS NOT NULL THEN 'Insumo'
        WHEN pi.id IS NOT NULL THEN 'PiezaImpresa'
    END AS tipoproducto,

    -- Campos exclusivos de Insumos (Vendrán en NULL si el producto es una pieza)
    i.material,
    i.diametromilimetros,
    i.color,
    i.marca,
    i.kilogramos,

    -- Campos exclusivos de Piezas Impresas (Vendrán en NULL si el producto es un insumo)
    pi.tiempoimpresionminutos,
    pi.costodiseno,
    pi.insumoid

    FROM PRODUCTO p
    LEFT JOIN INSUMO i ON p.Id = i.Id
    LEFT JOIN PIEZAIMPRESA pi ON p.Id = pi.Id;
END

-- Sotred procedure 2
CREATE PROC PRODUCTO_EDITAR_STOCK
@id int, @cantidad int
AS
BEGIN
	UPDATE PRODUCTO SET 
        stock = stock - @cantidad
    WHERE id = @id
END
-- FIN STORED PROCEDURE

USE TpArqWeb
DROP PROC PRODUCTO_LISTAR

-- IMAGENES
UPDATE PRODUCTO
SET imagen = (
    SELECT BulkColumn 
    FROM OPENROWSET(BULK 'C:\BackupTpArqWeb\soporte_extrusor.png', SINGLE_BLOB) AS Imagen
)
WHERE id = 4; -- Reemplaza con el ID correcto

SELECT * FROM PRODUCTO
-- FIN IMAGENES