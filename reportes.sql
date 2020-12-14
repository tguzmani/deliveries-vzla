-- REPORTE 1
create PROCEDURE report_one(cursor_1 OUT sys_refcursor) IS
BEGIN
    OPEN cursor_1 FOR
        SELECT a.logo                  as "Logo Empresa",
               a.datos.NOMBRE          as "Empresa",
               CASE b.PERIODO
                   WHEN 'mensual' THEN CONCAT(b.ESPECIFICACION.CANTIDAD, CONCAT(' envíos * ', 'Mes'))
                   WHEN 'trimestral' THEN CONCAT(b.ESPECIFICACION.CANTIDAD, CONCAT(' envìos * ', 'Tres meses'))
                   WHEN 'anual' THEN CONCAT(b.ESPECIFICACION.CANTIDAD, CONCAT(' envìos * ', 'Año'))
                   END                 as "Acuerdo de servicio",
               CONCAT(b.FECHA.FECHA_INICIO, CONCAT(' - ',b.FECHA.FECHA_FIN)) as "Fecha Vigencia",
               b.ESPECIFICACION.PRECIO as "Precio segun acuerdo de servicio"
        FROM APLICACION a
                 INNER JOIN SERVICIO b
                            ON b.ID_APLICACION = a.ID
        order by a.DATOS.NOMBRE;
END;

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
SELECT c.cedula, c.FOTO, c.PRIMER_NOMBRE, c.SEGUNDO_APELLIDO,
       c.SEGUNDO_NOMBRE, c.SEGUNDO_APELLIDO, c.EMAIL, a.LOGO,
       a.DATOS.NOMBRE, r.FECHAS
FROM CLIENTE c, APLICACION a, REGISTRO r
WHERE r.CED_CLIENTE = c.CEDULA AND a.ID = r.ID_APLICACION ;

SELECT c.PRIMER_NOMBRE, c.FOTO, c.PRIMER_NOMBRE, c.SEGUNDO_APELLIDO,
       c.SEGUNDO_NOMBRE, c.SEGUNDO_APELLIDO, c.EMAIL, GET_ESTADO(u.NOMBRE) AS Estado, p.DESCRIPCION AS "Dirección de Envío"
FROM UBICACION u, CLIENTE c, DIRECCION d, PTO_REFERENCIA p
WHERE d.ID_ZONA = u.ID and c.CEDULA=d.CED_CLIENTE and GET_ESTADO(u.NOMBRE) = 'Miranda' and p.ID=d.ID_PTO_REFERENCIA;

SELECT c.PRIMER_NOMBRE, r.FECHAS, GET_ESTADO(u.NOMBRE)
FROM CLIENTE c, UBICACION u
JOIN DIRECCION D on D.CED_CLIENTE = c.CEDULA
JOIN REGISTRO R on R.CED_CLIENTE = c.CEDULA
WHERE GET_ESTADO(u.NOMBRE) = 'Miranda';