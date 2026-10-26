-- RetailPro - Ventas SIMULADAS para el proyecto academico.
-- PASO 1: leer antes de ejecutar.
-- Ejecutar UNA SOLA VEZ y con dbo.ventas vacia.
-- Este archivo solo se preparo; NO se ejecuto en SQL Server.
-- Periodos: abril-junio de 2026 y julio-septiembre de 2026.
-- Usa los IDs reales consultados: clientes 21-50 y productos 1-24.
-- Territorios de Montevideo: 1 Norte, 2 Sur, 3 Centro,
-- 4 Central (La Blanqueada), 5 Este y 6 Oeste.
-- Moneda: USD con IVA incluido. Costos simulados del catalogo.
-- Los descuentos son supuestos academicos, no promociones verificadas.
-- Cada comentario indica el descuento TOTAL aplicado a esa fila:
-- monto_total = cantidad * precio del catalogo - descuento total.
-- costo_unitario es por UNA unidad, no por toda la venta.
-- id_venta se genera automaticamente.
-- No ejecutar el antiguo script 05.

-- PASO 2: seleccionar la base de datos.
USE RetailPro;
GO

-- PASO 3: agregar las 168 lineas con un INSERT INTO.
-- Cada fila sigue el orden de las columnas indicadas.
-- Las cantidades altas se asignan a empresas (Corporate).
-- Las fechas se escriben como AAAAMMDD.
INSERT INTO dbo.ventas
    (id_cliente, id_producto, id_territorio, fecha_venta,
     cantidad, monto_total, costo_unitario, canal)
VALUES
    -- Norte: abril-junio.
    (29, 1, 1, '20260402', 20, 12000.00, 528.00, N'Online'), -- Notebooks; descuento USD 1200.00.
    (30, 15, 1, '20260507', 9, 8000.00, 712.00, N'Presencial'), -- Notebooks; descuento USD 10.00.
    (47, 6, 1, '20260612', 28, 4000.00, 115.99, N'Online'), -- Monitores; descuento USD 59.72.
    (48, 16, 1, '20260417', 32, 4000.00, 103.20, N'Presencial'), -- Monitores; descuento USD 128.00.
    (49, 18, 1, '20260522', 100, 1500.00, 12.00, N'Online'), -- Teclados; descuento USD 0.00.
    (50, 19, 1, '20260627', 28, 1500.00, 44.00, N'Presencial'), -- Teclados; descuento USD 40.00.
    (29, 20, 1, '20260406', 53, 1000.00, 15.20, N'Online'), -- Mouse; descuento USD 7.00.
    (30, 21, 1, '20260511', 29, 1000.00, 28.00, N'Presencial'), -- Mouse; descuento USD 15.00.
    (47, 9, 1, '20260616', 19, 1500.00, 64.00, N'Online'), -- Auriculares; descuento USD 20.00.
    (48, 22, 1, '20260421', 34, 1500.00, 36.00, N'Presencial'), -- Auriculares; descuento USD 30.00.
    (49, 10, 1, '20260526', 11, 750.00, 56.00, N'Online'), -- Microfonos; descuento USD 20.00.
    (50, 24, 1, '20260605', 10, 750.00, 63.20, N'Presencial'), -- Microfonos; descuento USD 40.00.
    (29, 11, 1, '20260410', 4, 1250.00, 260.00, N'Online'), -- Volantes; descuento USD 50.00.
    (30, 12, 1, '20260515', 4, 1250.00, 276.00, N'Presencial'), -- Volantes; descuento USD 130.00.
    -- Norte: julio-septiembre.
    (47, 1, 1, '20260704', 10, 6000.00, 528.00, N'Online'), -- Notebooks; descuento USD 600.00.
    (48, 15, 1, '20260809', 9, 8000.00, 712.00, N'Presencial'), -- Notebooks; descuento USD 10.00.
    (49, 6, 1, '20260914', 28, 4000.00, 115.99, N'Online'), -- Monitores; descuento USD 59.72.
    (50, 16, 1, '20260719', 32, 4000.00, 103.20, N'Presencial'), -- Monitores; descuento USD 128.00.
    (29, 18, 1, '20260824', 100, 1500.00, 12.00, N'Online'), -- Teclados; descuento USD 0.00.
    (30, 19, 1, '20260903', 28, 1500.00, 44.00, N'Presencial'), -- Teclados; descuento USD 40.00.
    (47, 20, 1, '20260708', 53, 1000.00, 15.20, N'Online'), -- Mouse; descuento USD 7.00.
    (48, 21, 1, '20260813', 29, 1000.00, 28.00, N'Presencial'), -- Mouse; descuento USD 15.00.
    (49, 9, 1, '20260918', 19, 1500.00, 64.00, N'Online'), -- Auriculares; descuento USD 20.00.
    (50, 22, 1, '20260723', 34, 1500.00, 36.00, N'Presencial'), -- Auriculares; descuento USD 30.00.
    (29, 10, 1, '20260802', 11, 750.00, 56.00, N'Online'), -- Microfonos; descuento USD 20.00.
    (30, 24, 1, '20260907', 10, 750.00, 63.20, N'Presencial'), -- Microfonos; descuento USD 40.00.
    (47, 11, 1, '20260712', 4, 1250.00, 260.00, N'Online'), -- Volantes; descuento USD 50.00.
    (48, 12, 1, '20260817', 4, 1250.00, 276.00, N'Presencial'), -- Volantes; descuento USD 130.00.
    -- Sur: abril-junio.
    (49, 14, 2, '20260505', 4, 2975.00, 632.00, N'Online'), -- Notebooks; descuento USD 185.00.
    (50, 13, 2, '20260610', 5, 2000.00, 392.00, N'Presencial'), -- Notebooks; descuento USD 450.00.
    (29, 6, 2, '20260415', 7, 1000.00, 115.99, N'Online'), -- Monitores; descuento USD 14.93.
    (30, 16, 2, '20260520', 8, 1000.00, 103.20, N'Presencial'), -- Monitores; descuento USD 32.00.
    (47, 18, 2, '20260625', 25, 375.00, 12.00, N'Online'), -- Teclados; descuento USD 0.00.
    (48, 19, 2, '20260404', 7, 375.00, 44.00, N'Presencial'), -- Teclados; descuento USD 10.00.
    (49, 20, 2, '20260509', 14, 250.00, 15.20, N'Online'), -- Mouse; descuento USD 16.00.
    (50, 8, 2, '20260614', 5, 250.00, 44.00, N'Presencial'), -- Mouse; descuento USD 25.00.
    (29, 23, 2, '20260419', 6, 375.00, 52.00, N'Online'), -- Auriculares; descuento USD 15.00.
    (30, 9, 2, '20260524', 5, 375.00, 64.00, N'Presencial'), -- Auriculares; descuento USD 25.00.
    (21, 10, 2, '20260603', 3, 187.50, 56.00, N'Online'), -- Microfonos; descuento USD 22.50.
    (22, 10, 2, '20260408', 3, 187.50, 56.00, N'Presencial'), -- Microfonos; descuento USD 22.50.
    (23, 11, 2, '20260513', 1, 325.00, 260.00, N'Online'), -- Volantes; descuento USD 0.00.
    (24, 12, 2, '20260618', 1, 325.00, 276.00, N'Presencial'), -- Volantes; descuento USD 20.00.
    -- Sur: julio-septiembre.
    (47, 15, 2, '20260807', 4, 3337.50, 712.00, N'Online'), -- Notebooks; descuento USD 222.50.
    (48, 1, 2, '20260912', 4, 2200.00, 528.00, N'Presencial'), -- Notebooks; descuento USD 440.00.
    (49, 5, 2, '20260717', 7, 1100.00, 127.20, N'Online'), -- Monitores; descuento USD 13.00.
    (50, 17, 2, '20260822', 6, 1100.00, 151.20, N'Presencial'), -- Monitores; descuento USD 34.00.
    (25, 7, 2, '20260927', 3, 412.50, 119.99, N'Online'), -- Teclados; descuento USD 37.47.
    (29, 18, 2, '20260706', 28, 412.50, 12.00, N'Presencial'), -- Teclados; descuento USD 7.50.
    (30, 21, 2, '20260811', 8, 275.00, 28.00, N'Online'), -- Mouse; descuento USD 5.00.
    (47, 8, 2, '20260916', 5, 275.00, 44.00, N'Presencial'), -- Mouse; descuento USD 0.00.
    (48, 22, 2, '20260721', 10, 412.50, 36.00, N'Online'), -- Auriculares; descuento USD 37.50.
    (49, 22, 2, '20260826', 10, 412.50, 36.00, N'Presencial'), -- Auriculares; descuento USD 37.50.
    (26, 24, 2, '20260905', 3, 206.25, 63.20, N'Online'), -- Microfonos; descuento USD 30.75.
    (27, 24, 2, '20260710', 3, 206.25, 63.20, N'Presencial'), -- Microfonos; descuento USD 30.75.
    (28, 11, 2, '20260815', 1, 325.00, 260.00, N'Online'), -- Volantes; descuento USD 0.00.
    (31, 12, 2, '20260920', 1, 325.00, 276.00, N'Presencial'), -- Volantes; descuento USD 20.00.
    -- Centro: abril-junio.
    (32, 2, 3, '20260608', 3, 4787.50, 1326.40, N'Online'), -- Notebooks; descuento USD 186.50.
    (50, 14, 3, '20260413', 4, 3000.00, 632.00, N'Presencial'), -- Notebooks; descuento USD 160.00.
    (29, 17, 3, '20260518', 8, 1500.00, 151.20, N'Online'), -- Monitores; descuento USD 12.00.
    (30, 16, 3, '20260623', 12, 1500.00, 103.20, N'Presencial'), -- Monitores; descuento USD 48.00.
    (47, 7, 3, '20260402', 4, 562.50, 119.99, N'Online'), -- Teclados; descuento USD 37.46.
    (48, 19, 3, '20260507', 11, 562.50, 44.00, N'Presencial'), -- Teclados; descuento USD 42.50.
    (49, 20, 3, '20260612', 20, 375.00, 15.20, N'Online'), -- Mouse; descuento USD 5.00.
    (50, 21, 3, '20260417', 11, 375.00, 28.00, N'Presencial'), -- Mouse; descuento USD 10.00.
    (29, 23, 3, '20260522', 9, 562.50, 52.00, N'Online'), -- Auriculares; descuento USD 22.50.
    (30, 9, 3, '20260627', 8, 562.50, 64.00, N'Presencial'), -- Auriculares; descuento USD 77.50.
    (47, 24, 3, '20260406', 4, 281.25, 63.20, N'Online'), -- Microfonos; descuento USD 34.75.
    (48, 10, 3, '20260511', 5, 281.25, 56.00, N'Presencial'), -- Microfonos; descuento USD 68.75.
    (33, 11, 3, '20260616', 1, 325.00, 260.00, N'Online'), -- Volantes; descuento USD 0.00.
    (34, 12, 3, '20260421', 1, 325.00, 276.00, N'Presencial'), -- Volantes; descuento USD 20.00.
    -- Centro: julio-septiembre.
    (49, 13, 3, '20260910', 9, 4409.36, 392.00, N'Online'), -- Notebooks; descuento USD 0.64.
    (35, 4, 3, '20260715', 2, 3150.00, 1519.99, N'Presencial'), -- Notebooks; descuento USD 649.98.
    (50, 5, 3, '20260820', 10, 1575.00, 127.20, N'Online'), -- Monitores; descuento USD 15.00.
    (29, 6, 3, '20260925', 11, 1575.00, 115.99, N'Presencial'), -- Monitores; descuento USD 19.89.
    (30, 7, 3, '20260704', 4, 590.63, 119.99, N'Online'), -- Teclados; descuento USD 9.33.
    (47, 18, 3, '20260809', 40, 590.63, 12.00, N'Presencial'), -- Teclados; descuento USD 9.37.
    (48, 20, 3, '20260914', 21, 393.75, 15.20, N'Online'), -- Mouse; descuento USD 5.25.
    (49, 21, 3, '20260719', 12, 393.75, 28.00, N'Presencial'), -- Mouse; descuento USD 26.25.
    (50, 22, 3, '20260824', 14, 590.63, 36.00, N'Online'), -- Auriculares; descuento USD 39.37.
    (29, 9, 3, '20260903', 8, 590.63, 64.00, N'Presencial'), -- Auriculares; descuento USD 49.37.
    (30, 24, 3, '20260708', 4, 295.31, 63.20, N'Online'), -- Microfonos; descuento USD 20.69.
    (47, 10, 3, '20260813', 5, 295.31, 56.00, N'Presencial'), -- Microfonos; descuento USD 54.69.
    (36, 11, 3, '20260918', 2, 650.00, 260.00, N'Online'), -- Volantes; descuento USD 0.00.
    (37, 12, 3, '20260723', 2, 650.00, 276.00, N'Presencial'), -- Volantes; descuento USD 40.00.
    -- Central: abril-junio.
    (38, 2, 4, '20260411', 3, 4787.50, 1326.40, N'Online'), -- Notebooks; descuento USD 186.50.
    (48, 1, 4, '20260516', 5, 3000.00, 528.00, N'Presencial'), -- Notebooks; descuento USD 300.00.
    (49, 17, 4, '20260621', 8, 1500.00, 151.20, N'Online'), -- Monitores; descuento USD 12.00.
    (50, 16, 4, '20260426', 12, 1500.00, 103.20, N'Presencial'), -- Monitores; descuento USD 48.00.
    (29, 19, 4, '20260505', 11, 562.50, 44.00, N'Online'), -- Teclados; descuento USD 42.50.
    (30, 18, 4, '20260610', 38, 562.50, 12.00, N'Presencial'), -- Teclados; descuento USD 7.50.
    (47, 8, 4, '20260415', 7, 375.00, 44.00, N'Online'), -- Mouse; descuento USD 10.00.
    (48, 20, 4, '20260520', 20, 375.00, 15.20, N'Presencial'), -- Mouse; descuento USD 5.00.
    (49, 23, 4, '20260625', 9, 562.50, 52.00, N'Online'), -- Auriculares; descuento USD 22.50.
    (50, 22, 4, '20260404', 13, 562.50, 36.00, N'Presencial'), -- Auriculares; descuento USD 22.50.
    (29, 24, 4, '20260509', 4, 281.25, 63.20, N'Online'), -- Microfonos; descuento USD 34.75.
    (30, 10, 4, '20260614', 5, 281.25, 56.00, N'Presencial'), -- Microfonos; descuento USD 68.75.
    (39, 11, 4, '20260419', 1, 325.00, 260.00, N'Online'), -- Volantes; descuento USD 0.00.
    (40, 12, 4, '20260524', 1, 325.00, 276.00, N'Presencial'), -- Volantes; descuento USD 20.00.
    -- Central: julio-septiembre.
    (47, 15, 4, '20260713', 5, 4409.36, 712.00, N'Online'), -- Notebooks; descuento USD 40.64.
    (41, 4, 4, '20260818', 2, 3150.00, 1519.99, N'Presencial'), -- Notebooks; descuento USD 649.98.
    (48, 5, 4, '20260923', 10, 1575.00, 127.20, N'Online'), -- Monitores; descuento USD 15.00.
    (49, 6, 4, '20260702', 11, 1575.00, 115.99, N'Presencial'), -- Monitores; descuento USD 19.89.
    (50, 7, 4, '20260807', 4, 590.63, 119.99, N'Online'), -- Teclados; descuento USD 9.33.
    (29, 19, 4, '20260912', 11, 590.63, 44.00, N'Presencial'), -- Teclados; descuento USD 14.37.
    (30, 21, 4, '20260717', 12, 393.75, 28.00, N'Online'), -- Mouse; descuento USD 26.25.
    (47, 8, 4, '20260822', 8, 393.75, 44.00, N'Presencial'), -- Mouse; descuento USD 46.25.
    (48, 9, 4, '20260927', 8, 590.63, 64.00, N'Online'), -- Auriculares; descuento USD 49.37.
    (49, 23, 4, '20260706', 10, 590.63, 52.00, N'Presencial'), -- Auriculares; descuento USD 59.37.
    (50, 24, 4, '20260811', 4, 295.31, 63.20, N'Online'), -- Microfonos; descuento USD 20.69.
    (29, 10, 4, '20260916', 5, 295.31, 56.00, N'Presencial'), -- Microfonos; descuento USD 54.69.
    (42, 11, 4, '20260721', 2, 650.00, 260.00, N'Online'), -- Volantes; descuento USD 0.00.
    (43, 12, 4, '20260826', 2, 650.00, 276.00, N'Presencial'), -- Volantes; descuento USD 40.00.
    -- Este: abril-junio.
    (30, 14, 5, '20260514', 4, 2975.00, 632.00, N'Online'), -- Notebooks; descuento USD 185.00.
    (47, 13, 5, '20260619', 5, 2000.00, 392.00, N'Presencial'), -- Notebooks; descuento USD 450.00.
    (44, 3, 5, '20260424', 1, 1000.00, 997.60, N'Online'), -- Monitores; descuento USD 247.00.
    (45, 3, 5, '20260503', 1, 1000.00, 997.60, N'Presencial'), -- Monitores; descuento USD 247.00.
    (48, 18, 5, '20260608', 25, 375.00, 12.00, N'Online'), -- Teclados; descuento USD 0.00.
    (49, 19, 5, '20260413', 7, 375.00, 44.00, N'Presencial'), -- Teclados; descuento USD 10.00.
    (50, 20, 5, '20260518', 14, 250.00, 15.20, N'Online'), -- Mouse; descuento USD 16.00.
    (29, 8, 5, '20260623', 5, 250.00, 44.00, N'Presencial'), -- Mouse; descuento USD 25.00.
    (30, 23, 5, '20260402', 6, 375.00, 52.00, N'Online'), -- Auriculares; descuento USD 15.00.
    (47, 9, 5, '20260507', 5, 375.00, 64.00, N'Presencial'), -- Auriculares; descuento USD 25.00.
    (46, 10, 5, '20260612', 3, 187.50, 56.00, N'Online'), -- Microfonos; descuento USD 22.50.
    (21, 10, 5, '20260417', 3, 187.50, 56.00, N'Presencial'), -- Microfonos; descuento USD 22.50.
    (22, 11, 5, '20260522', 1, 325.00, 260.00, N'Online'), -- Volantes; descuento USD 0.00.
    (23, 12, 5, '20260627', 1, 325.00, 276.00, N'Presencial'), -- Volantes; descuento USD 20.00.
    -- Este: julio-septiembre.
    (48, 15, 5, '20260816', 4, 3337.50, 712.00, N'Online'), -- Notebooks; descuento USD 222.50.
    (49, 1, 5, '20260921', 4, 2200.00, 528.00, N'Presencial'), -- Notebooks; descuento USD 440.00.
    (24, 3, 5, '20260726', 1, 1100.00, 997.60, N'Online'), -- Monitores; descuento USD 147.00.
    (50, 5, 5, '20260805', 7, 1100.00, 127.20, N'Presencial'), -- Monitores; descuento USD 13.00.
    (25, 7, 5, '20260910', 3, 412.50, 119.99, N'Online'), -- Teclados; descuento USD 37.47.
    (29, 18, 5, '20260715', 28, 412.50, 12.00, N'Presencial'), -- Teclados; descuento USD 7.50.
    (30, 21, 5, '20260820', 8, 275.00, 28.00, N'Online'), -- Mouse; descuento USD 5.00.
    (47, 8, 5, '20260925', 5, 275.00, 44.00, N'Presencial'), -- Mouse; descuento USD 0.00.
    (48, 22, 5, '20260704', 10, 412.50, 36.00, N'Online'), -- Auriculares; descuento USD 37.50.
    (49, 22, 5, '20260809', 10, 412.50, 36.00, N'Presencial'), -- Auriculares; descuento USD 37.50.
    (26, 24, 5, '20260914', 3, 206.25, 63.20, N'Online'), -- Microfonos; descuento USD 30.75.
    (27, 24, 5, '20260719', 3, 206.25, 63.20, N'Presencial'), -- Microfonos; descuento USD 30.75.
    (28, 11, 5, '20260824', 1, 325.00, 260.00, N'Online'), -- Volantes; descuento USD 0.00.
    (31, 12, 5, '20260903', 1, 325.00, 276.00, N'Presencial'), -- Volantes; descuento USD 20.00.
    -- Oeste: abril-junio.
    (32, 2, 6, '20260617', 2, 2975.00, 1326.40, N'Online'), -- Notebooks; descuento USD 341.00.
    (33, 14, 6, '20260422', 3, 2000.00, 632.00, N'Presencial'), -- Notebooks; descuento USD 370.00.
    (50, 6, 6, '20260527', 7, 1000.00, 115.99, N'Online'), -- Monitores; descuento USD 14.93.
    (29, 16, 6, '20260606', 8, 1000.00, 103.20, N'Presencial'), -- Monitores; descuento USD 32.00.
    (30, 19, 6, '20260411', 7, 375.00, 44.00, N'Online'), -- Teclados; descuento USD 10.00.
    (34, 7, 6, '20260516', 3, 375.00, 119.99, N'Presencial'), -- Teclados; descuento USD 74.97.
    (47, 20, 6, '20260621', 14, 250.00, 15.20, N'Online'), -- Mouse; descuento USD 16.00.
    (48, 21, 6, '20260426', 8, 250.00, 28.00, N'Presencial'), -- Mouse; descuento USD 30.00.
    (49, 23, 6, '20260505', 6, 375.00, 52.00, N'Online'), -- Auriculares; descuento USD 15.00.
    (50, 9, 6, '20260610', 5, 375.00, 64.00, N'Presencial'), -- Auriculares; descuento USD 25.00.
    (35, 10, 6, '20260415', 3, 187.50, 56.00, N'Online'), -- Microfonos; descuento USD 22.50.
    (36, 10, 6, '20260520', 3, 187.50, 56.00, N'Presencial'), -- Microfonos; descuento USD 22.50.
    (37, 11, 6, '20260625', 1, 325.00, 260.00, N'Online'), -- Volantes; descuento USD 0.00.
    (38, 12, 6, '20260404', 1, 325.00, 276.00, N'Presencial'), -- Volantes; descuento USD 20.00.
    -- Oeste: julio-septiembre.
    (39, 4, 6, '20260919', 2, 3337.50, 1519.99, N'Online'), -- Notebooks; descuento USD 462.48.
    (29, 13, 6, '20260724', 5, 2200.00, 392.00, N'Presencial'), -- Notebooks; descuento USD 250.00.
    (30, 17, 6, '20260803', 6, 1100.00, 151.20, N'Online'), -- Monitores; descuento USD 34.00.
    (40, 3, 6, '20260908', 1, 1100.00, 997.60, N'Presencial'), -- Monitores; descuento USD 147.00.
    (47, 18, 6, '20260713', 28, 412.50, 12.00, N'Online'), -- Teclados; descuento USD 7.50.
    (48, 19, 6, '20260818', 8, 412.50, 44.00, N'Presencial'), -- Teclados; descuento USD 27.50.
    (49, 8, 6, '20260923', 5, 275.00, 44.00, N'Online'), -- Mouse; descuento USD 0.00.
    (50, 21, 6, '20260702', 8, 275.00, 28.00, N'Presencial'), -- Mouse; descuento USD 5.00.
    (29, 22, 6, '20260807', 10, 412.50, 36.00, N'Online'), -- Auriculares; descuento USD 37.50.
    (30, 23, 6, '20260912', 7, 412.50, 52.00, N'Presencial'), -- Auriculares; descuento USD 42.50.
    (41, 24, 6, '20260717', 3, 206.25, 63.20, N'Online'), -- Microfonos; descuento USD 30.75.
    (42, 24, 6, '20260822', 3, 206.25, 63.20, N'Presencial'), -- Microfonos; descuento USD 30.75.
    (43, 11, 6, '20260927', 1, 325.00, 260.00, N'Online'), -- Volantes; descuento USD 0.00.
    (44, 12, 6, '20260930', 1, 325.00, 276.00, N'Presencial'); -- Volantes; descuento USD 20.00.
GO

-- PASO 4: comprobar cantidad y fechas.
-- Esperado: 168 filas y ultima fecha 30/09/2026.
SELECT COUNT(*) AS lineas_de_venta,
       MIN(fecha_venta) AS primera_venta,
       MAX(fecha_venta) AS ultima_venta
FROM dbo.ventas;
GO

-- PASO 5: comparar ingresos por region y trimestre.
-- JOIN relaciona ventas con territorios.
-- DATEPART obtiene el trimestre. SUM suma importes.
-- GROUP BY agrupa las ventas para obtener un total por grupo.
SELECT t.region,
       DATEPART(QUARTER, v.fecha_venta) AS trimestre,
       SUM(v.monto_total) AS ventas_usd
FROM dbo.ventas AS v
INNER JOIN dbo.territorios AS t ON t.id_territorio = v.id_territorio
WHERE v.fecha_venta >= '20260401' AND v.fecha_venta < '20261001'
GROUP BY t.region, DATEPART(QUARTER, v.fecha_venta)
ORDER BY t.region, trimestre;
GO

-- PASO 6: verificar el porcentaje de caida del Norte.
-- CASE separa el trimestre anterior (T2) del actual (T3).
-- Formula: (actual - anterior) / anterior * 100.
-- NULLIF evita dividir entre cero.
-- Esperado: T2 = 40000, T3 = 34000, variacion = -15.00%.
SELECT
    SUM(CASE WHEN fecha_venta < '20260701' THEN monto_total ELSE 0 END) AS ventas_T2,
    SUM(CASE WHEN fecha_venta >= '20260701' THEN monto_total ELSE 0 END) AS ventas_T3,
    CAST(100.0 * (
        SUM(CASE WHEN fecha_venta >= '20260701' THEN monto_total ELSE 0 END)
      - SUM(CASE WHEN fecha_venta < '20260701' THEN monto_total ELSE 0 END)
    ) / NULLIF(
        SUM(CASE WHEN fecha_venta < '20260701' THEN monto_total ELSE 0 END), 0
    ) AS DECIMAL(10,2)) AS variacion_porcentaje
FROM dbo.ventas
WHERE id_territorio = 1
  AND fecha_venta >= '20260401' AND fecha_venta < '20261001';
GO

-- PASO 7: analizar la caida por categoria y canal.
-- En Norte, Notebooks Online pasa de USD 12000 a USD 6000.
-- Son 20 y 10 unidades del producto 1, al mismo precio aplicado de USD 600.
-- El resto de las combinaciones de Norte conserva producto, cantidad,
-- costo y descuento entre trimestres.
-- Esto identifica donde cae la venta; no demuestra causas como falta de stock.
SELECT p.categoria, v.canal,
       DATEPART(QUARTER, v.fecha_venta) AS trimestre,
       SUM(v.cantidad) AS unidades,
       SUM(v.monto_total) AS ventas_usd
FROM dbo.ventas AS v
INNER JOIN dbo.productos AS p ON p.id_producto = v.id_producto
WHERE v.id_territorio = 1
  AND v.fecha_venta >= '20260401' AND v.fecha_venta < '20261001'
GROUP BY p.categoria, v.canal, DATEPART(QUARTER, v.fecha_venta)
ORDER BY p.categoria, v.canal, trimestre;
GO

-- PASO 8: consulta de los ultimos 30 dias solicitada por el curso.
-- MAX obtiene la ultima fecha del dataset; DATEADD retrocede 30 dias.
-- La ultima venta es 30/09/2026; el limite inferior es 31/08/2026.
-- >= incluye el dia limite, siguiendo el patron de la consigna.
-- Se ordena de la venta mas reciente a la mas antigua.
SELECT c.nombre_completo, v.fecha_venta, v.monto_total
FROM dbo.ventas AS v
INNER JOIN dbo.clientes AS c ON c.id_cliente = v.id_cliente
WHERE v.fecha_venta >= DATEADD(DAY, -30, (SELECT MAX(fecha_venta) FROM dbo.ventas))
ORDER BY v.fecha_venta DESC, v.id_venta DESC;
GO

