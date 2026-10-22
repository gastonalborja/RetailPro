--Proyecrto final Data Analytic91060 coderhouse 2026
--Motor utilizado:SQL server management studio22 
--Profesores


create database RetailPro 



USE RetailPro;
GO

CREATE TABLE dbo.clientes (
    id_cliente INT IDENTITY(1,1) NOT NULL,
    nombre_completo NVARCHAR(150) NOT NULL,
    segmento NVARCHAR(20) NOT NULL,
    email NVARCHAR(254) NULL,
    fecha_registro DATE NOT NULL,
    CONSTRAINT PK_clientes PRIMARY KEY (id_cliente),
    CONSTRAINT CK_clientes_segmento
        CHECK (segmento IN (N'Corporate', N'Retail'))
);
GO

-- Permite varios clientes sin email, pero evita repetir emails informados.
CREATE UNIQUE INDEX UX_clientes_email
    ON dbo.clientes (email)
    WHERE email IS NOT NULL;
GO


CREATE TABLE dbo.productos (                                        -- Catalogo: una fila por producto; dbo es el esquema.
    id_producto INT IDENTITY(1,1) NOT NULL,                          -- ID automatico: empieza en 1 y aumenta de a 1.
    nombre_producto NVARCHAR(150) NOT NULL,                         -- Nombre Unicode obligatorio; NOT NULL no impide texto vacio.
    categoria NVARCHAR(100) NOT NULL,                               -- Clasificacion del producto, segun el preentregable 1.
    precio_unitario DECIMAL(18,2) NOT NULL,                          -- Precio actual por unidad; 18 digitos totales y 2 decimales.
    costo_unitario DECIMAL(18,2) NOT NULL,                           -- Costo actual; ventas guarda su propio costo historico.
    CONSTRAINT PK_productos PRIMARY KEY (id_producto),              -- Identifica cada producto y evita IDs repetidos.
    CONSTRAINT CK_productos_precio CHECK (precio_unitario >= 0),     -- Rechaza precios negativos; permite cero.
    CONSTRAINT CK_productos_costo CHECK (costo_unitario >= 0)        -- Rechaza costos negativos; permite cero y costos mayores al precio.
);
GO

-- Describe el lugar de la venta, independientemente del domicilio del cliente.
CREATE TABLE dbo.territorios (
    id_territorio INT IDENTITY(1,1) NOT NULL,
    region NVARCHAR(50) NOT NULL,
    pais NVARCHAR(100) NOT NULL,
    ciudad NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_territorios PRIMARY KEY (id_territorio)
);
GO

-- Granularidad inicial: cada fila representa una venta de un solo producto.
-- monto_total es el ingreso efectivo de esa venta, incluidos sus descuentos.
-- costo_unitario guarda el costo aplicado al vender, no el costo actual.
-- Esta incorporacion al brief permite conservar el margen historico.
CREATE TABLE dbo.ventas (
    id_venta INT IDENTITY(1,1) NOT NULL,
    id_cliente INT NOT NULL,
    id_producto INT NOT NULL,
    id_territorio INT NOT NULL,
    fecha_venta DATE NOT NULL,
    cantidad INT NOT NULL,
    monto_total DECIMAL(18,2) NOT NULL,
    costo_unitario DECIMAL(18,2) NOT NULL,
    CONSTRAINT PK_ventas PRIMARY KEY (id_venta),
    CONSTRAINT FK_ventas_clientes FOREIGN KEY (id_cliente)
        REFERENCES dbo.clientes (id_cliente),
    CONSTRAINT FK_ventas_productos FOREIGN KEY (id_producto)
        REFERENCES dbo.productos (id_producto),
    CONSTRAINT FK_ventas_territorios FOREIGN KEY (id_territorio)
        REFERENCES dbo.territorios (id_territorio),
    CONSTRAINT CK_ventas_cantidad CHECK (cantidad > 0),
    CONSTRAINT CK_ventas_monto CHECK (monto_total >= 0),
    CONSTRAINT CK_ventas_costo CHECK (costo_unitario >= 0)
);
GO

-- Orden de carga: clientes, productos y territorios antes de ventas.
-- Costo total de una venta: cantidad * costo_unitario.
-- Ganancia bruta: monto_total - cantidad * costo_unitario.
-- Margen agregado: SUM(ganancia bruta) / NULLIF(SUM(monto_total), 0).