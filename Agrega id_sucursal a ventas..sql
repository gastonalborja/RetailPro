-- RetailPro - Relacion entre ventas y sucursales.
-- Ejecutar una sola vez, sobre las tablas existentes.
-- Criterio del escenario: cada venta pertenece a la sucursal de su region.
-- En Online, esa sucursal es responsable de gestionar la venta.
-- B2B/B2C describe la orientacion del local, no una prohibicion de atender
-- otros segmentos. Norte tiene ventas Corporate y su sucursal es B2C.
-- nombre_sucursal se conserva en sucursales y se muestra mediante JOIN.

USE RetailPro;
GO

-- PASO 1: agregar el ID. Por ahora admite NULL para las ventas ya cargadas.
ALTER TABLE dbo.ventas
ADD id_sucursal INT NULL;
GO

-- PASO 2: comprobar que cada venta tenga una sola sucursal posible.
-- Se compara region con zona, no se supone que ambos IDs sean iguales.
-- Si falta una coincidencia o hay varias, detenerse y revisar los datos.
IF EXISTS (
    SELECT v.id_venta
    FROM dbo.ventas AS v
    INNER JOIN dbo.territorios AS t ON t.id_territorio = v.id_territorio
    LEFT JOIN dbo.sucursales AS s ON s.zona = t.region
    GROUP BY v.id_venta
    HAVING COUNT(s.id_sucursal) <> 1
)
BEGIN
    ;THROW 50001, N'Alguna venta no tiene una unica sucursal para su region. Revisar territorios y sucursales.', 1;
END;

-- PASO 3: completar la sucursal de las ventas existentes.
-- Ejemplo: una venta de la region Norte se asigna al local de zona Norte.
UPDATE v
SET v.id_sucursal = s.id_sucursal
FROM dbo.ventas AS v
INNER JOIN dbo.territorios AS t ON t.id_territorio = v.id_territorio
INNER JOIN dbo.sucursales AS s ON s.zona = t.region;

-- PASO 4: hacer obligatorio el ID de sucursal.
ALTER TABLE dbo.ventas
ALTER COLUMN id_sucursal INT NOT NULL;

-- PASO 5: crear la clave foranea.
-- Una sucursal puede tener muchas ventas; cada venta pertenece a una sucursal.
-- Impide guardar un id_sucursal que no exista en dbo.sucursales.
ALTER TABLE dbo.ventas
ADD CONSTRAINT FK_ventas_sucursales
FOREIGN KEY (id_sucursal) REFERENCES dbo.sucursales (id_sucursal);

-- PASO 6: ver el registro de ventas con el ID y nombre de la sucursal.
-- JOIN obtiene el nombre sin duplicarlo en la tabla ventas.
SELECT v.id_venta,
       v.id_sucursal,
       s.nombre_sucursal,
       s.zona,
       v.id_cliente,
       v.id_producto,
       v.id_territorio,
       v.fecha_venta,
       v.cantidad,
       v.monto_total,
       v.costo_unitario,
       v.canal
FROM dbo.ventas AS v
INNER JOIN dbo.sucursales AS s ON s.id_sucursal = v.id_sucursal
ORDER BY v.id_venta;
GO

-- IMPORTANTE: los INSERT futuros deben incluir id_sucursal.
-- La clave foranea valida la existencia de la sucursal, pero por si sola
-- no comprueba que su zona coincida con la region del territorio elegido.
-- Mantener ese criterio al preparar nuevas ventas.
