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
create PROCEDURE report_three(cursor_3 OUT sys_refcursor, comercio VARCHAR, f_inicio DATE, f_fin DATE,
                                         estado VARCHAR) IS
BEGIN
    OPEN cursor_3 FOR
        SELECT "Sector",
               a1.LOGO AS "Logo de la empresa",
               "Nombre de la empresa",
               "Aplicación utilizada para el delivery",
               "Fecha de inicio",
               "Fecha de fin",
               "Estado",
               "Cantidad de envios realizados en ese rango de tiempo"
        FROM (
                 SELECT s.NOMBRE                   AS "Sector",
                        a.ID                       AS "aux",
                        a.DATOS.NOMBRE             AS "Nombre de la empresa",
                        app.DATOS.NOMBRE           AS "Aplicación utilizada para el delivery",
                        TO_CHAR(min(p.FECHAS.FECHA_INICIO), 'DD-MM-YYYY') AS "Fecha de inicio",
                        TO_CHAR(max(p.FECHAS.FECHA_FIN), 'DD-MM-YYYY')   AS "Fecha de fin",
                        e.NOMBRE                   AS "Estado",
                        COUNT(p.TRACKING)          AS "Cantidad de envios realizados en ese rango de tiempo"
                 FROM PEDIDO p
                          INNER JOIN ALIADA a on a.ID = p.ID_ALIADA
                          INNER JOIN SECTOR s ON s.ID = a.ID_SECTOR
                          INNER JOIN APLICACION app on p.ID_APLICACION = app.ID
                          INNER JOIN UBICACION u on p.ID_ZONA_DIRECCION = u.id
                          INNER JOIN UBICACION m on m.ID = u.ID_PADRE
                          INNER JOIN UBICACION e on e.ID = m.ID_PADRE
                 WHERE (0 < INSTR(comercio, a.DATOS.NOMBRE) OR comercio IS NULL) AND
                       (0 < INSTR(estado, e.NOMBRE) OR estado IS NULL) AND
                       (p.FECHAS.FECHA_INICIO >= f_inicio OR f_inicio IS NULL) AND
                       (p.FECHAS.FECHA_FIN <= f_fin OR f_fin IS NULL)
                 GROUP BY s.NOMBRE, a.ID, a.DATOS.NOMBRE, app.DATOS.NOMBRE, e.NOMBRE
                 ORDER BY 3) Pedidos
        INNER JOIN ALIADA a1 ON a1.id = "aux";
END;

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
              ORDER BY a.DATOS.NOMBRE, U2.TIPO
            ) Unidades
        INNER JOIN APLICACION a1 ON a1.id = aux;
END;

-- REPORTE 5
create PROCEDURE report_five(cursor_5 OUT sys_refcursor, estado VARCHAR) IS
BEGIN
    OPEN cursor_5 FOR
        SELECT "Estado",
               a1.LOGO AS "Empresa",
               "Nombre de proveedor de servicio",
               a2.LOGO AS "Logo de proveedor de servicio",
               "Municipio",
               "Cantidad de envíos recibidos"
        FROM (SELECT a.ID              AS "aux1",
                     app.ID            AS "aux2",
                     e.NOMBRE          AS "Estado",
                     app.DATOS.NOMBRE  AS "Nombre de proveedor de servicio",
                     m.NOMBRE          AS "Municipio",
                     count(p.TRACKING) AS "Cantidad de envíos recibidos"
              FROM PEDIDO p
                       INNER JOIN ALIADA a on a.ID = p.ID_ALIADA
                       INNER JOIN APLICACION app on p.ID_APLICACION = app.ID
                       INNER JOIN UBICACION u on p.ID_ZONA_DIRECCION = u.id
                       INNER JOIN UBICACION m on m.ID = u.ID_PADRE
                       INNER JOIN UBICACION e on e.ID = m.ID_PADRE
              WHERE e.NOMBRE = estado
              GROUP BY a.ID, app.ID, e.NOMBRE, app.DATOS.NOMBRE, m.NOMBRE
              ORDER BY "Cantidad de envíos recibidos" DESC FETCH NEXT 5 ROWS ONLY) pedidos
        INNER JOIN ALIADA a1 ON a1.ID = "aux1"
        INNER JOIN APLICACION a2 ON a2.ID = "aux2";
END;

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

--REPORTE 7
create PROCEDURE report_seven(cursor_7 OUT sys_refcursor, estado VARCHAR, f_inicio DATE, f_fin DATE, proveedor VARCHAR) IS
BEGIN
    OPEN cursor_7 FOR
        SELECT
            "Estado",
            "Nombre de proveedor de servicio",
            a.LOGO as "Logo proveedor de servicio",
            "Dirección de envío",
            "Referencia",
            "#Tracking",
            "Fecha de inicio",
            "Fecha de fin",
            "Cantidad de productos a enviar",
            "Email cliente"
        FROM (SELECT
                e.NOMBRE as "Estado",
                app.DATOS.NOMBRE as "Nombre de proveedor de servicio",
                app.ID as "aux",
                z.NOMBRE as "Dirección de envío",
                pto.DESCRIPCION as "Referencia",
                p.TRACKING as "#Tracking",
                p.FECHAS.FECHA_INICIO as "Fecha de inicio",
                p.FECHAS.FECHA_FIN as "Fecha de fin",
                SUM(p2.ESPECIFICACION.CANTIDAD) as "Cantidad de productos a enviar",
                c.EMAIL as "Email cliente"
            FROM PEDIDO p
            INNER JOIN UBICACION z ON p.ID_ZONA_DIRECCION = z.ID
            INNER JOIN UBICACION m ON z.ID_PADRE = m.ID
            INNER JOIN UBICACION e ON m.ID_PADRE = e.ID
            INNER JOIN APLICACION app on app.ID = p.ID_APLICACION
            INNER JOIN PTO_REFERENCIA pto on pto.ID = p.ID_DIRECCION
            INNER JOIN PRODUCTO p2 on p.TRACKING = p2.TRACKING_PEDIDO
            INNER JOIN CLIENTE c on p.CED_CLIENTE = c.CEDULA
            WHERE (0 < INSTR(proveedor, app.DATOS.NOMBRE) OR proveedor IS NULL) AND
                  (0 < INSTR(estado, e.NOMBRE) OR estado IS NULL) AND
                  (p.FECHAS.FECHA_INICIO >= f_inicio OR f_inicio IS NULL) AND
                  (p.FECHAS.FECHA_FIN <= f_fin OR f_fin IS NULL)
            GROUP BY e.NOMBRE, app.DATOS.NOMBRE, app.ID, z.NOMBRE, pto.DESCRIPCION, p.TRACKING, p.FECHAS.FECHA_INICIO, p.FECHAS.FECHA_FIN, c.EMAIL)
        INNER JOIN APLICACION a ON a.ID = "aux";
END;

--REPORTE 8
SELECT p.TRACKING,
       TO_CHAR(p.FECHAS.FECHA_INICIO, 'DD-MM-YYYY HH:Mi AM'),
       TO_CHAR(p.FECHAS.FECHA_FIN, 'DD-MM-YYYY HH:Mi AM'),
       count(P2.ID), C2.EMAIL,
       CONCAT(TRUNC(MOD((p.FECHAS.FECHA_FIN-p.FECHAS.FECHA_INICIO) * (60*24),60)),' minutos')
FROM PEDIDO p
INNER JOIN PRODUCTO P2 on p.TRACKING = P2.TRACKING_PEDIDO
INNER JOIN CLIENTE C2 on p.CED_CLIENTE = C2.CEDULA
GROUP BY p.TRACKING, p.FECHAS.FECHA_INICIO, p.FECHAS.FECHA_FIN, C2.EMAIL
ORDER BY p.TRACKING;

--REPORTE 9
create PROCEDURE report_nine(cursor_9 OUT sys_refcursor, estado VARCHAR, f_inicio DATE, f_fin DATE, zona VARCHAR) IS
BEGIN
    OPEN cursor_9 FOR
        SELECT
            TO_CHAR(MIN(p.FECHAS.FECHA_INICIO),'DD-MM-YYYY') AS "Fecha de inicio",
            TO_CHAR(MAX(p.FECHAS.FECHA_FIN),'DD-MM-YYYY') AS "Fecha de fin",
            e.NOMBRE AS "Estado",
            z.NOMBRE AS "Zona",
            s.NOMBRE AS "Sector del producto",
            SUM(p2.ESPECIFICACION.CANTIDAD) AS "Cantidad productos"
        FROM SECTOR s
        INNER JOIN PRODUCTO p2 on s.ID = p2.ID_SECTOR
        INNER JOIN PEDIDO p on p2.TRACKING_PEDIDO = p.TRACKING
        INNER JOIN UBICACION z ON p.ID_ZONA_DIRECCION = z.ID
        INNER JOIN UBICACION m ON z.ID_PADRE = m.ID
        INNER JOIN UBICACION e ON m.ID_PADRE = e.ID
        WHERE (0 < INSTR(zona, z.NOMBRE) OR zona IS NULL) AND
              (0 < INSTR(estado, e.NOMBRE) OR estado IS NULL) AND
              (p.FECHAS.FECHA_INICIO >= f_inicio OR f_inicio IS NULL) AND
              (p.FECHAS.FECHA_FIN <= f_fin OR f_fin IS NULL)
        GROUP BY e.NOMBRE, z.NOMBRE, s.NOMBRE
        ORDER BY 6 DESC
        FETCH FIRST 10 ROWS ONLY;
END;

--REPORTE 10
create PROCEDURE report_ten(cursor_10 OUT sys_refcursor, f_inicio DATE, f_fin DATE, proveedor VARCHAR) IS
BEGIN
    OPEN cursor_10 FOR
        SELECT
            "Fecha de inicio",
            "Fecha de fin",
            a1.LOGO AS "Comercio",
            "Nombre de proveedor de servicio",
            a2.LOGO AS "Logo proveedor de servicio",
            "Ingresos"
        FROM
            (SELECT
                TO_CHAR(MIN(c.FECHAS.FECHA_INICIO),'DD-MM-YYYY') AS "Fecha de inicio",
                TO_CHAR(MAX(c.FECHAS.FECHA_FIN),'DD-MM-YYYY') AS "Fecha de fin",
                ali.ID AS "aux1",
                app.DATOS.NOMBRE AS "Nombre de proveedor de servicio",
                app.ID AS "aux2",
                CONCAT('$',SUM(s.ESPECIFICACION.PRECIO)) AS "Ingresos"
            FROM CONTRATO c
            INNER JOIN APLICACION app on app.ID = c.ID_APLICACION
            INNER JOIN ALIADA ali on ali.ID = c.ID_ALIADA
            INNER JOIN SERVICIO s on c.ID_SERVICIO = s.ID
            WHERE (0 < INSTR(proveedor, app.DATOS.NOMBRE) OR proveedor IS NULL) AND
                  (c.FECHAS.FECHA_INICIO >= f_inicio OR f_inicio IS NULL) AND
                  (c.FECHAS.FECHA_FIN <= f_fin OR f_fin IS NULL)
            GROUP BY ali.ID, app.DATOS.NOMBRE, app.ID
            ORDER BY 5)
        INNER JOIN ALIADA a1 ON a1.ID = "aux1"
        INNER JOIN APLICACION a2 ON a2.ID = "aux2";
END;

--REPORTE 11
create or replace PROCEDURE report_eleven(cursor_11 OUT sys_refcursor, f_inicio DATE, f_fin DATE, estad VARCHAR) IS
BEGIN
    OPEN cursor_11 FOR
        SELECT
            "Fecha de inicio",
            "Fecha de fin",
            "Nombre de proveedor de servicio",
            a.LOGO AS "Logo proveedor de servicio",
            "Estado"
        FROM
            (SELECT
                TO_CHAR(MIN(p.FECHAS.FECHA_INICIO),'DD-MM-YYYY') AS "Fecha de inicio",
                TO_CHAR(MAX(p.FECHAS.FECHA_FIN),'DD-MM-YYYY') AS "Fecha de fin",
                a.DATOS.NOMBRE AS "Nombre de proveedor de servicio",
                a.ID AS "aux",
                e.NOMBRE AS "Estado",
                COUNT(p.TRACKING) as "Pedidos"
            FROM PEDIDO p
            INNER JOIN APLICACION a on a.ID = p.ID_APLICACION
            INNER JOIN UBICACION z ON p.ID_ZONA_DIRECCION = z.ID
            INNER JOIN UBICACION m ON z.ID_PADRE = m.ID
            INNER JOIN UBICACION e ON m.ID_PADRE = e.ID
            WHERE (0 < INSTR(estad, e.NOMBRE) OR estad IS NULL) AND
                  (p.FECHAS.FECHA_INICIO >= f_inicio OR f_inicio IS NULL) AND
                  (p.FECHAS.FECHA_FIN <= f_fin OR f_fin IS NULL)
            GROUP BY a.DATOS.NOMBRE, a.ID, e.NOMBRE
            ORDER BY 6 DESC
            FETCH FIRST 3 ROWS ONLY)
        INNER JOIN APLICACION a ON a.ID = "aux";
END;


--REPORTE 12
create or replace PROCEDURE report_twelve(cursor_12 OUT sys_refcursor, origen VARCHAR, destino VARCHAR) IS
BEGIN
    OPEN cursor_12 FOR
SELECT
    app.LOGO as "Logo proveedor de servicio",
    "Zona de origen",
    "Zona de destino",
    "Tiempo de transporte",
    "Tipo de transporte"
FROM
    (SELECT
        a.ID AS "aux",
        u1.NOMBRE AS "Zona de origen",
        u2.NOMBRE AS "Zona de destino",
        CASE u.TIPO
                       WHEN 'moto' THEN CONCAT(ROUND(1440*(AVG(p.FECHAS.FECHA_FIN-p.FECHAS.FECHA_INICIO))-10),'min')
                       WHEN 'carro' THEN CONCAT(ROUND(1440*(AVG(p.FECHAS.FECHA_FIN-p.FECHAS.FECHA_INICIO))),'min')
                       WHEN 'camioneta' THEN CONCAT(ROUND(1440*(AVG(p.FECHAS.FECHA_FIN-p.FECHAS.FECHA_INICIO))+5),'min')
                       END                 as "Tiempo de transporte",
        u.TIPO AS "Tipo de transporte"
    FROM PEDIDO p
    INNER JOIN APLICACION a on a.ID = p.ID_APLICACION
    INNER JOIN SUCURSAL s on s.ID_ALIADA = p.ID_ALIADA
    INNER JOIN UBICACION u2 on p.ID_ZONA_DIRECCION = u2.ID
    INNER JOIN UBICACION u1 on u1.ID = s.ID_ZONA
    INNER JOIN UNIDAD u on p.ID_UNIDAD = u.ID
    WHERE s.ID_ZONA = GET_CLOSER_SUCURSAL(p.CED_CLIENTE,p.ID_ALIADA,p.ID_ZONA_DIRECCION) AND
          (0 < INSTR(origen, u1.NOMBRE) OR origen IS NULL) AND
          (0 < INSTR(destino, u1.NOMBRE) OR destino IS NULL)
    GROUP BY a.ID, u1.NOMBRE, u2.NOMBRE, u.TIPO
    ORDER BY 1,2,3,5)
INNER JOIN APLICACION app on app.ID = "aux";
END;

--REPORTE 13
create PROCEDURE report_thirteen(cursor_13 OUT sys_refcursor, f_inicio DATE, f_fin DATE) IS
BEGIN
    OPEN cursor_13 FOR
        SELECT "Nombre de proveedor de servicio",
               app1.LOGO "Logo de proveedor de servicio",
               "Promedio de satisfacción"
        FROM (SELECT app.ID                                         "aux",
                     app.DATOS.NOMBRE                               "Nombre de proveedor de servicio",
                     CONCAT(ROUND(AVG(p.VALORACION)), ' estrellas') "Promedio de satisfacción"
              FROM APLICACION app
                       INNER JOIN PEDIDO P on app.ID = P.ID_APLICACION
              WHERE p.FECHAS.FECHA_INICIO >= f_inicio AND p.FECHAS.FECHA_FIN <= f_fin
              GROUP BY app.ID, app.DATOS.NOMBRE)
        INNER JOIN APLICACION app1 On app1.ID = "aux";
END;
