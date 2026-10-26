-- RetailPro - Correcciones de coherencia del escenario academico.
-- SOLO SCRIPT: no se ejecuto ningun cambio en la base.
-- Ejecutar UNA SOLA VEZ, DESPUES del script 15 de sucursales.
-- No agrega ni elimina ventas; conserva IDs, cantidades, fechas e ingresos.
-- No cambia la caida del 15% del Norte.
-- Los precios historicos se reconstruyen desde el catalogo usado para crear
-- estas ventas SIMULADAS; no aplicar este criterio a operaciones reales.
-- En clientes Corporate, ci corresponde al contacto, no al documento de empresa.
-- El RUT queda pendiente: no se inventan identificadores fiscales.

USE RetailPro;
GO

-- PASO 1: agregar campos que faltaban.
-- fecha_carga conserva cuando se incorporo el producto al sistema.
-- precio_unitario_venta conserva el precio de lista usado al vender.
-- descuento_total es el descuento de TODA la fila, en USD con IVA.
-- es_simulada identifica el origen academico de los registros.
-- id_territorio vincula formalmente cada sucursal con su ubicacion.
-- Ejecutar los pasos siguientes en orden.
ALTER TABLE dbo.productos ADD fecha_carga DATE NULL;

ALTER TABLE dbo.ventas ADD
    precio_unitario_venta DECIMAL(18,2) NULL,
    descuento_total DECIMAL(18,2) NULL,
    es_simulada BIT NOT NULL
        CONSTRAINT DF_ventas_es_simulada DEFAULT (0);

ALTER TABLE dbo.sucursales ADD id_territorio INT NULL;

ALTER TABLE dbo.clientes ADD rut NVARCHAR(12) NULL;
GO

-- PASO 2: validar los datos antes de completarlos.
-- La transaccion permite deshacer TODOS los cambios de datos de este bloque
-- si una validacion falla. Las columnas del paso 1 ya fueron creadas.
SET XACT_ABORT ON;

BEGIN TRY
    BEGIN TRANSACTION;

    -- El script 15 debe haberse ejecutado antes.
    IF EXISTS (SELECT 1 FROM dbo.ventas WHERE id_sucursal IS NULL)
    BEGIN
        THROW 50001, N'Completar primero la relacion de ventas con sucursales (script 15).', 1;
        ;THROW 50001, N'Completar primero la relacion de ventas con sucursales (script 15).', 1;
    END;

    -- Este arreglo se diseno para las 168 ventas academicas ya revisadas.
    IF (SELECT COUNT(*) FROM dbo.ventas) <> 168
       OR EXISTS (
           SELECT 1 FROM dbo.ventas
           WHERE fecha_venta < '20260401' OR fecha_venta >= '20261001'
       )
    BEGIN
        THROW 50002, N'Las ventas cambiaron respecto del escenario revisado. Revisar antes de aplicar esta correccion.', 1;
        ;THROW 50002, N'Las ventas cambiaron respecto del escenario revisado. Revisar antes de aplicar esta correccion.', 1;
    END;

    IF EXISTS (
        SELECT 1 FROM dbo.ventas AS v
        INNER JOIN dbo.productos AS p ON p.id_producto = v.id_producto
        WHERE v.monto_total > v.cantidad * p.precio_unitario
    )
    BEGIN
        THROW 50003, N'Hay importes mayores al precio de referencia; no se puede reconstruir el descuento.', 1;
        ;THROW 50003, N'Hay importes mayores al precio de referencia; no se puede reconstruir el descuento.', 1;
    END;

    IF EXISTS (
        SELECT sku FROM dbo.productos GROUP BY sku HAVING COUNT(*) > 1
    ) OR EXISTS (
        SELECT ci FROM dbo.clientes GROUP BY ci HAVING COUNT(*) > 1
    )
    BEGIN
        THROW 50004, N'Hay SKU o CI repetidos; revisar antes de crear indices unicos.', 1;
        ;THROW 50004, N'Hay SKU o CI repetidos; revisar antes de crear indices unicos.', 1;
    END;

    IF EXISTS (
        SELECT 1 FROM dbo.clientes
        WHERE ci IS NULL OR LEN(LTRIM(RTRIM(ci))) = 0
    ) OR EXISTS (
        SELECT 1 FROM dbo.productos WHERE LEN(LTRIM(RTRIM(sku))) = 0
    )
    BEGIN
        THROW 50005, N'Hay identificadores vacios; completarlos antes de continuar.', 1;
        ;THROW 50005, N'Hay identificadores vacios; completarlos antes de continuar.', 1;
    END;

    IF EXISTS (
        SELECT 1 FROM dbo.ventas
        WHERE canal IS NULL OR canal NOT IN (N'Online', N'Presencial')
    )
    BEGIN
        THROW 50006, N'Hay ventas con canal pendiente o invalido.', 1;
        ;THROW 50006, N'Hay ventas con canal pendiente o invalido.', 1;
    END;

    -- Cada zona debe corresponder a un unico territorio.
    IF EXISTS (
        SELECT s.id_sucursal
        FROM dbo.sucursales AS s
        LEFT JOIN dbo.territorios AS t ON t.region = s.zona
        GROUP BY s.id_sucursal
        HAVING COUNT(t.id_territorio) <> 1
    )
    BEGIN
        THROW 50007, N'Hay sucursales sin territorio unico para su zona.', 1;
        ;THROW 50007, N'Hay sucursales sin territorio unico para su zona.', 1;
    END;

    -- PASO 3: separar fecha comercial y fecha de carga.
    -- Se preserva la fecha original de carga del catalogo.
    UPDATE dbo.productos
    SET fecha_carga = fecha_alta;

    -- Para el escenario, se ubica el alta comercial un dia antes de
    -- la primera venta del producto, SOLO si el alta era posterior.
    -- Es una fecha SIMULADA, no una fecha historica verificada.
    UPDATE p
    SET fecha_alta = DATEADD(DAY, -1, primeras.primera_venta)
    FROM dbo.productos AS p
    INNER JOIN (
        SELECT id_producto, MIN(fecha_venta) AS primera_venta
        FROM dbo.ventas
        GROUP BY id_producto
    ) AS primeras ON primeras.id_producto = p.id_producto
    WHERE p.fecha_alta > primeras.primera_venta;

    ALTER TABLE dbo.productos
    ALTER COLUMN fecha_carga DATE NOT NULL;

    ALTER TABLE dbo.productos
    ADD CONSTRAINT DF_productos_fecha_carga
    DEFAULT (CONVERT(DATE, GETDATE())) FOR fecha_carga;

    -- PASO 4: guardar los precios y descuentos del escenario.
    -- Se conservan los montos ya cargados: no se recalcula la facturacion.
    UPDATE v
    SET v.precio_unitario_venta = p.precio_unitario,
        v.descuento_total = v.cantidad * p.precio_unitario - v.monto_total,
        v.es_simulada = 1
    FROM dbo.ventas AS v
    INNER JOIN dbo.productos AS p ON p.id_producto = v.id_producto;

    ALTER TABLE dbo.ventas
    ALTER COLUMN precio_unitario_venta DECIMAL(18,2) NOT NULL;

    ALTER TABLE dbo.ventas
    ALTER COLUMN descuento_total DECIMAL(18,2) NOT NULL;

    ALTER TABLE dbo.ventas
    ALTER COLUMN canal NVARCHAR(20) NOT NULL;

    ALTER TABLE dbo.ventas ADD
        CONSTRAINT CK_ventas_precio_historico CHECK (precio_unitario_venta >= 0),
        CONSTRAINT CK_ventas_descuento_total CHECK (descuento_total >= 0),
        CONSTRAINT CK_ventas_importe_calculado
            CHECK (monto_total = cantidad * precio_unitario_venta - descuento_total);

    -- PASO 5: evitar duplicados y textos vacios en CI y SKU.
    -- Esto NO valida el digito verificador ni la identidad de una persona.
    ALTER TABLE dbo.clientes
    ALTER COLUMN ci NVARCHAR(12) NOT NULL;

    CREATE UNIQUE INDEX UX_clientes_ci ON dbo.clientes (ci);
    CREATE UNIQUE INDEX UX_productos_sku ON dbo.productos (sku);
    CREATE UNIQUE INDEX UX_clientes_rut
        ON dbo.clientes (rut) WHERE rut IS NOT NULL;

    ALTER TABLE dbo.clientes
    ADD CONSTRAINT CK_clientes_ci_contenido
        CHECK (LEN(LTRIM(RTRIM(ci))) > 0),
        CONSTRAINT CK_clientes_rut_formato
        CHECK (rut IS NULL OR (LEN(rut) = 12 AND rut NOT LIKE N'%[^0-9]%'));

    ALTER TABLE dbo.productos
    ADD CONSTRAINT CK_productos_sku_contenido
        CHECK (LEN(LTRIM(RTRIM(sku))) > 0);

    -- PASO 6: relacionar cada sucursal con su territorio.
    UPDATE s
    SET s.id_territorio = t.id_territorio
    FROM dbo.sucursales AS s
    INNER JOIN dbo.territorios AS t ON t.region = s.zona;

    IF EXISTS (
        SELECT 1 FROM dbo.ventas AS v
        INNER JOIN dbo.sucursales AS s ON s.id_sucursal = v.id_sucursal
        WHERE v.id_territorio <> s.id_territorio
    )
    BEGIN
        THROW 50008, N'Hay ventas cuyo territorio no coincide con el de su sucursal.', 1;
        ;THROW 50008, N'Hay ventas cuyo territorio no coincide con el de su sucursal.', 1;
    END;

    ALTER TABLE dbo.sucursales
    ALTER COLUMN id_territorio INT NOT NULL;

    ALTER TABLE dbo.sucursales
    ADD CONSTRAINT FK_sucursales_territorios
        FOREIGN KEY (id_territorio) REFERENCES dbo.territorios (id_territorio);

    -- La clave compuesta permite comprobar sucursal Y territorio en ventas.
    ALTER TABLE dbo.sucursales
    ADD CONSTRAINT UQ_sucursales_territorio
        UNIQUE (id_sucursal, id_territorio);

    ALTER TABLE dbo.ventas
    ADD CONSTRAINT FK_ventas_sucursal_territorio
        FOREIGN KEY (id_sucursal, id_territorio)
        REFERENCES dbo.sucursales (id_sucursal, id_territorio);

    -- PASO 7: hacer explicita la atencion B2B, B2C o Mixta.
    -- Clasificacion del escenario segun los segmentos que atendio cada local.
    -- No asigna canales por segmento: Corporate tambien puede comprar Online.
    ALTER TABLE dbo.sucursales
    DROP CONSTRAINT CK_sucursales_tipo;

    UPDATE s
    SET tipo_sucursal =
        CASE
            WHEN EXISTS (
                SELECT 1 FROM dbo.ventas AS v
                INNER JOIN dbo.clientes AS c ON c.id_cliente = v.id_cliente
                WHERE v.id_sucursal = s.id_sucursal AND c.segmento = N'Corporate'
            )
            AND EXISTS (
                SELECT 1 FROM dbo.ventas AS v
                INNER JOIN dbo.clientes AS c ON c.id_cliente = v.id_cliente
                WHERE v.id_sucursal = s.id_sucursal AND c.segmento = N'Retail'
            ) THEN N'Mixta'
            WHEN EXISTS (
                SELECT 1 FROM dbo.ventas AS v
                INNER JOIN dbo.clientes AS c ON c.id_cliente = v.id_cliente
                WHERE v.id_sucursal = s.id_sucursal AND c.segmento = N'Corporate'
            ) THEN N'B2B'
            WHEN EXISTS (
                SELECT 1 FROM dbo.ventas AS v
                INNER JOIN dbo.clientes AS c ON c.id_cliente = v.id_cliente
                WHERE v.id_sucursal = s.id_sucursal AND c.segmento = N'Retail'
            ) THEN N'B2C'
            ELSE s.tipo_sucursal
        END
    FROM dbo.sucursales AS s;

    ALTER TABLE dbo.sucursales
    ADD CONSTRAINT CK_sucursales_tipo
        CHECK (tipo_sucursal IN (N'B2B', N'B2C', N'Mixta'));

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF XACT_STATE() <> 0 ROLLBACK TRANSACTION;
    THROW;
END CATCH;
GO

-- PASO 8: revisar fechas y datos de las ventas.
SELECT p.id_producto, p.nombre_producto, p.fecha_alta, p.fecha_carga,
       MIN(v.fecha_venta) AS primera_venta
FROM dbo.productos AS p
LEFT JOIN dbo.ventas AS v ON v.id_producto = p.id_producto
GROUP BY p.id_producto, p.nombre_producto, p.fecha_alta, p.fecha_carga
ORDER BY p.id_producto;

SELECT v.id_venta, v.fecha_venta, s.id_sucursal, s.nombre_sucursal,
       t.region, t.barrio, v.canal,
       p.nombre_producto, v.cantidad,
       v.precio_unitario_venta, v.descuento_total,
       v.monto_total, v.costo_unitario, v.es_simulada
FROM dbo.ventas AS v
INNER JOIN dbo.sucursales AS s ON s.id_sucursal = v.id_sucursal
INNER JOIN dbo.territorios AS t ON t.id_territorio = v.id_territorio
INNER JOIN dbo.productos AS p ON p.id_producto = v.id_producto
ORDER BY v.id_venta;

-- Confirmar que se conservan USD 40000 y USD 34000 en Norte.
SELECT DATEPART(QUARTER, v.fecha_venta) AS trimestre,
       SUM(v.monto_total) AS ingresos_norte_usd,
       AVG(v.monto_total) AS promedio_por_registro
FROM dbo.ventas AS v
INNER JOIN dbo.territorios AS t ON t.id_territorio = v.id_territorio
WHERE t.region = N'Norte'
  AND v.fecha_venta >= '20260401' AND v.fecha_venta < '20261001'
GROUP BY DATEPART(QUARTER, v.fecha_venta)
ORDER BY trimestre;
GO

-- PARA LOS PROXIMOS INSERT:
-- Incluir id_sucursal, precio_unitario_venta, descuento_total y canal.
-- Indicar es_simulada = 1 para datos del proyecto.
-- Los scripts de carga anteriores no incorporan estos campos nuevos.
-- No volver a ejecutar el script 14 despues de esta migracion.
-- El promedio sigue siendo por registro/producto, no por factura multiproducto.
-- Este script no inventa pedidos, RUT, contactos ni causas comerciales.

