-- RetailPro - Territorios del escenario academico en Montevideo.
-- Toda la operacion se desarrolla en Montevideo, Uruguay.
-- Las regiones son zonas comerciales internas, no departamentos del pais.
-- Ejecutar una sola vez, con la tabla territorios vacia.
-- id_territorio se genera automaticamente.
-- Centro corresponde al local de 18 de Julio, en el barrio Centro.
-- Central corresponde a La Blanqueada; los otros barrios son propuestos.

USE RetailPro;
GO

INSERT INTO dbo.territorios (region, pais, ciudad, barrio)
VALUES
    (N'Norte', N'Uruguay', N'Montevideo', N'Colon'),
    (N'Sur', N'Uruguay', N'Montevideo', N'Punta Carretas'),
    (N'Centro', N'Uruguay', N'Montevideo', N'Centro'),
    (N'Central', N'Uruguay', N'Montevideo', N'La Blanqueada'),
    (N'Este', N'Uruguay', N'Montevideo', N'Carrasco'),
    (N'Oeste', N'Uruguay', N'Montevideo', N'Cerro');
GO

SELECT id_territorio, region, pais, ciudad, barrio
FROM dbo.territorios
ORDER BY id_territorio;
GO
