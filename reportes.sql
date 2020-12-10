-- REPORTE 1

-- REPORTE 2
-- Require funcion MIN(contrato.fecha_inicio)
-- Require funcion listar_estados()
SELECT *
FROM aliada a, contrato c;

-- REPORTE 3

-- REPORTE 4
SELECT *
FROM aplicacion app, oficina ofi, unidad uni, ubicacion ubi
WHERE ofi.id_aplicacion = app.id
AND ofi.id_zona = ubi.id
AND uni.id_zona_oficina = ofi.id_zona
AND uni.id_aplicacion_oficina = ofi.id_aplicacion
AND ubi.tipo = 'estado';

-- REPORTE 5

-- REPORTE 6