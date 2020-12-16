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
CREATE OR REPLACE PROCEDURE report_two(cursor_2 OUT sys_refcursor, estado VARCHAR) IS
BEGIN
    OPEN cursor_2 FOR
        SELECT a1.LOGO AS "Logo",
               "Fecha de registro",
               "Aplicación registrada para el delivery",
               "Fecha desde",
               "Fecha hasta",
               "Estado(s) donde hace delivery",
               "Monto de contrato"
        FROM (SELECT DISTINCT a.ID                                                                 AS aux,
                              a.DATOS.NOMBRE,
                              c.FECHAS.FECHA_INICIO,
                              GET_STARTDATE(a.DATOS.NOMBRE, A2.DATOS.NOMBRE)                       AS "Fecha de registro",
                              A2.DATOS.NOMBRE                                                      AS "Aplicación registrada para el delivery",
                              TO_CHAR(C.FECHAS.FECHA_INICIO, 'DD-MM-YYYY')                         AS "Fecha desde",
                              TO_CHAR(C.FECHAS.FECHA_FIN, 'DD-MM-YYYY')                            AS "Fecha hasta",
                              GET_ESTADOS_DELIVERY(a.DATOS.NOMBRE)                                 AS "Estado(s) donde hace delivery",
                              CONCAT('$',
                                     CONCAT(S.ESPECIFICACION.PRECIO, CONCAT(' ', S.PERIODO)))      AS "Monto de contrato"
              FROM ALIADA a
                       INNER JOIN CONTRATO C on a.ID = C.ID_ALIADA
                       INNER JOIN APLICACION A2 on C.ID_APLICACION = A2.ID
                       INNER JOIN SERVICIO S on C.ID_SERVICIO = S.ID
                       INNER JOIN SUCURSAL S2 on a.ID = S2.ID_ALIADA
              WHERE 0 < INSTR(estado, GET_ESTADO(S2.ID_ZONA)) OR estado IS NULL
              ORDER BY a.DATOS.NOMBRE, a2.DATOS.NOMBRE) t
        INNER JOIN ALIADA A1 ON a1.ID = aux;
END;

-- REPORTE 3
SELECT s.NOMBRE,
       a.ID,
       a.DATOS.NOMBRE,
       app.DATOS.NOMBRE,
       min(p.FECHAS.FECHA_INICIO),
       max(p.FECHAS.FECHA_FIN),
       e.NOMBRE,
       COUNT(p.TRACKING)
FROM PEDIDO p
         INNER JOIN ALIADA a on a.ID = p.ID_ALIADA
         INNER JOIN SECTOR s ON s.ID = a.ID_SECTOR
         INNER JOIN APLICACION app on p.ID_APLICACION = app.ID
         INNER JOIN UBICACION u on p.ID_ZONA_DIRECCION = u.id
         INNER JOIN UBICACION m on m.ID = u.ID_PADRE
         INNER JOIN UBICACION e on e.ID = m.ID_PADRE
GROUP BY s.NOMBRE, a.ID, a.DATOS.NOMBRE, app.DATOS.NOMBRE, e.NOMBRE
ORDER BY 3;

-- REPORTE 4
create PROCEDURE report_four(cursor_4 OUT sys_refcursor, estado VARCHAR) IS
BEGIN
    OPEN cursor_4 FOR
        SELECT a1.LOGO,
               Unidades.Empresa,
               Unidades.Estado,
               Unidades."Unidad de transporte",
               Unidades."Cantidad Disponible",
               Unidades."Cantidad En Reparación"
        FROM (SELECT a.ID                              as aux,
                     a.DATOS.NOMBRE                    AS Empresa,
                     GET_ESTADO(o.ID_ZONA)              AS Estado,
                     U2.TIPO                           AS "Unidad de transporte",
                     CONCAT(SUM(DECODE(U2.ESTATUS, 'activo', 1, 0)),
                            CONCAT(' ', 'unidad(es)')) AS "Cantidad Disponible",
                     CONCAT(SUM(DECODE(U2.ESTATUS, 'en reparación', 1, 0)),
                            CONCAT(' ', 'unidad(es)')) AS "Cantidad En Reparación"
              FROM APLICACION a
                       JOIN OFICINA O on a.ID = O.ID_APLICACION
                       JOIN UBICACION U on U.ID = O.ID_ZONA
                       JOIN UNIDAD U2 on O.ID_APLICACION = U2.ID_APLICACION_OFICINA and O.ID_ZONA = U2.ID_ZONA_OFICINA
              WHERE GET_ESTADO(o.ID_ZONA) = estado AND O.ID_ZONA = u.ID
              GROUP BY a.id, a.DATOS.NOMBRE, GET_ESTADO(o.ID_ZONA), U2.TIPO
              ORDER BY a.DATOS.NOMBRE, U2.TIPO) Unidades
        INNER JOIN APLICACION a1 ON a1.id = aux;
END;

-- REPORTE 5
SELECT e.NOMBRE, a.ID, app.DATOS.NOMBRE, app.ID, m.NOMBRE, count(p.TRACKING)
FROM PEDIDO p
         INNER JOIN ALIADA a on a.ID = p.ID_ALIADA
         INNER JOIN APLICACION app on p.ID_APLICACION = app.ID
         INNER JOIN UBICACION u on p.ID_ZONA_DIRECCION = u.id
         INNER JOIN UBICACION m on m.ID = u.ID_PADRE
         INNER JOIN UBICACION e on e.ID = m.ID_PADRE
GROUP BY e.NOMBRE, a.ID, app.DATOS.NOMBRE, app.ID, m.NOMBRE
ORDER BY 6 DESC;
--ORDER BY numero de envios FETCH NEXT 5 ROWS ONLY; para tener el top 5

-- REPORTE 6
create PROCEDURE report_six(cursor_6 OUT sys_refcursor, estado VARCHAR, fecha DATE) IS
BEGIN
    OPEN cursor_6 FOR
        SELECT c.CEDULA                        AS Cedula,
               c.FOTO                          AS Foto,
               c.PRIMER_NOMBRE                 AS "Primer Nombre",
               c.SEGUNDO_NOMBRE                AS "Segundo Nombre",
               c.PRIMER_APELLIDO               AS "Primer Apellido",
               c.SEGUNDO_APELLIDO              AS "Segundo Apellido",
               c.EMAIL                         AS Email,
               a.LOGO                          AS "Aplicación Registrada",
               a.DATOS.NOMBRE                  AS "Nombre de la Aplicación Registrada",
               TO_CHAR(r.FECHAS, 'DD-MM-YYYY') AS "Cliente desde",
               GET_ESTADO(d.ID_ZONA)            AS "Estado",
               p.DESCRIPCION                   AS "Dirección de Envío"
        FROM CLIENTE c
                 JOIN DIRECCION D on D.CED_CLIENTE = c.CEDULA
                 JOIN REGISTRO R on R.CED_CLIENTE = c.CEDULA
                 JOIN UBICACION U on U.ID = D.ID_ZONA
                 JOIN APLICACION A on A.ID = R.ID_APLICACION
                 JOIN PTO_REFERENCIA P on P.ID = D.ID_PTO_REFERENCIA
        WHERE GET_ESTADO(d.ID_ZONA) = estado AND r.FECHAS<fecha AND D.ID_ZONA = u.ID
        ORDER BY c.PRIMER_NOMBRE;
END;