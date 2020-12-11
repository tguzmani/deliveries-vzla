-- REPORTE 1
CREATE OR REPLACE PROCEDURE report_one(cursor_1 OUT sys_refcursor) IS
BEGIN
    OPEN cursor_1 FOR
        SELECT a.logo                  as "Logo Empresa",
               a.datos.NOMBRE          as Empresa,
               CASE b.PERIODO
                   WHEN 'mensual' THEN CONCAT(b.ESPECIFICACION.CANTIDAD, CONCAT(' envíos * ', 'Mes'))
                   WHEN 'trimestral' THEN CONCAT(b.ESPECIFICACION.CANTIDAD, CONCAT(' envìos * ', 'Tres meses'))
                   WHEN 'anual' THEN CONCAT(b.ESPECIFICACION.CANTIDAD, CONCAT(' envìos * ', 'Año'))
                   END                 as "Acuerdo de servicio",
               b.ESPECIFICACION.PRECIO as "Precio segun acuerdo de servicio"
        FROM APLICACION a
                 INNER JOIN SERVICIO b
                            ON b.ID_APLICACION = a.ID
        order by a.DATOS.NOMBRE;
END;

-- REPORTE 2
SELECT c.cedula, c.FOTO, c.PRIMER_NOMBRE, c.SEGUNDO_APELLIDO,
       c.SEGUNDO_NOMBRE, c.SEGUNDO_APELLIDO, c.EMAIL, a.LOGO,
       a.DATOS.NOMBRE, r.FECHAS, (SELECT u.NOMBRE FROM UBICACION u, DIRECCION d WHERE c.CEDULA=d.CED_CLIENTE
           and u.ID=d.ID_ZONA)
FROM CLIENTE c, APLICACION a, REGISTRO r
WHERE r.CED_CLIENTE = c.CEDULA AND a.ID = r.ID_APLICACION;
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