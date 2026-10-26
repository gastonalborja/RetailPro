-- RetailPro - Carga de productos.
-- Ejecutar una sola vez para evitar productos duplicados.
-- Todos los precios y costos estan en USD con IVA incluido.
-- Los costos son simulados para el proyecto: 80% del precio de venta.
-- id_producto se genera automaticamente.
-- activo toma el valor 1 y fecha_alta toma la fecha de carga por defecto.

USE RetailPro;
GO

-- Cada fila de VALUES representa un producto.
INSERT INTO dbo.productos
    (nombre_producto, categoria, precio_unitario, costo_unitario, sku, marca)
VALUES
(N'Lenovo 82XQ012HUS Ryzen 5 8GB 512GB SSD', N'Notebooks', 660.00, 528.00, N'RP-NOT-001', N'Lenovo'),
(N'HP 16-CD0075CL Core Ultra 7 24GB 1TB SSD', N'Notebooks', 1658.00, 1326.40, N'RP-NOT-002', N'HP'),
(N'Dell UltraSharp U2725QE 27 pulgadas 4K', N'Monitores', 1247.00, 997.60, N'RP-MON-001', N'Dell'),
(N'Gigabyte A16 CVHI3LA894PH i7 16GB 1TB RTX5060', N'Notebooks', 1899.99, 1519.99, N'RP-NOT-003', N'Gigabyte'),
(N'Gigabyte GS25F2A 25 pulgadas 240Hz', N'Monitores', 159.00, 127.20, N'RP-MON-002', N'Gigabyte'),
(N'MSI MAG 245F X24 24 pulgadas 240Hz', N'Monitores', 144.99, 115.99, N'RP-MON-003', N'MSI'),
(N'HyperX Alloy Rise 75', N'Teclados', 149.99, 119.99, N'RP-TEC-001', N'HyperX'),
(N'HyperX Pulsefire Fuse Wireless', N'Mouse', 55.00, 44.00, N'RP-MOU-001', N'HyperX'),
(N'HyperX Cloud Jet Wireless negro', N'Auriculares', 80.00, 64.00, N'RP-AUR-001', N'HyperX'),
(N'HyperX Solocast 2', N'Microfonos', 70.00, 56.00, N'RP-MIC-001', N'HyperX'),
(N'Logitech G29 PC PlayStation', N'Volantes', 325.00, 260.00, N'RP-VOL-001', N'Logitech'),
(N'Logitech G920 PC Xbox', N'Volantes', 345.00, 276.00, N'RP-VOL-002', N'Logitech');
GO

-- Consultar los productos cargados.
SELECT id_producto, nombre_producto, categoria, precio_unitario,
       costo_unitario, sku, marca, activo, fecha_alta
FROM dbo.productos
ORDER BY id_producto;
GO



-- RetailPro - Ampliacion del catalogo para el escenario academico.
-- Ejecutar una sola vez, despues del script 03.
-- Precios y costos SIMULADOS en USD con IVA incluido.
-- Son supuestos del proyecto, no cotizaciones verificadas de comercios.
-- Costo simulado: 80% del precio de venta.
-- Este script agrega productos; la caida del Norte se representa en ventas.

USE RetailPro;
GO

INSERT INTO dbo.productos
    (nombre_producto, categoria, precio_unitario, costo_unitario, sku, marca)
VALUES
    (N'Lenovo IdeaPad 8GB 256GB SSD', N'Notebooks', 490.00, 392.00, N'RP-NOT-004', N'Lenovo'),
    (N'HP Notebook 16GB 512GB SSD', N'Notebooks', 790.00, 632.00, N'RP-NOT-005', N'HP'),
    (N'ASUS VivoBook 16GB 512GB SSD', N'Notebooks', 890.00, 712.00, N'RP-NOT-006', N'ASUS'),
    (N'Samsung Monitor 24 pulgadas Full HD', N'Monitores', 129.00, 103.20, N'RP-MON-004', N'Samsung'),
    (N'LG Monitor 27 pulgadas Full HD', N'Monitores', 189.00, 151.20, N'RP-MON-005', N'LG'),
    (N'Logitech Teclado USB K120', N'Teclados', 15.00, 12.00, N'RP-TEC-002', N'Logitech'),
    (N'Redragon Teclado mecanico Kumara', N'Teclados', 55.00, 44.00, N'RP-TEC-003', N'Redragon'),
    (N'Logitech Mouse inalambrico M280', N'Mouse', 19.00, 15.20, N'RP-MOU-002', N'Logitech'),
    (N'Logitech Mouse gamer G203', N'Mouse', 35.00, 28.00, N'RP-MOU-003', N'Logitech'),
    (N'JBL Auriculares Quantum 100', N'Auriculares', 45.00, 36.00, N'RP-AUR-002', N'JBL'),
    (N'HyperX Auriculares Cloud Stinger 2', N'Auriculares', 65.00, 52.00, N'RP-AUR-003', N'HyperX'),
    (N'Logitech Microfono Blue Snowball iCE', N'Microfonos', 79.00, 63.20, N'RP-MIC-002', N'Logitech');
GO

-- Ver el catalogo con los nuevos productos y sus IDs para cargar ventas.
SELECT id_producto, nombre_producto, categoria,
       precio_unitario, costo_unitario, sku, marca
FROM dbo.productos
ORDER BY id_producto;
GO


