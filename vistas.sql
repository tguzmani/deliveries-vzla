--vistas para facilitar la cosa

--Aplicaciones y la ubicacion de sus oficinas
CREATE OR REPLACE VIEW v_aplicacion_oficinas AS
    SELECT a.DATOS.NOMBRE AS APLICACION, u.NOMBRE AS LUGAR
    FROM OFICINA o, UBICACION u , APLICACION a
    WHERE o.ID_ZONA = u.ID AND a.ID = o.ID_APLICACION
    ORDER BY a.ID;

--Todos los clientes con registro en aplicaciones
CREATE OR REPLACE VIEW v_registro_clientes AS
    SELECT c.CEDULA, CONCAT(c.PRIMER_NOMBRE,CONCAT(' ', c.PRIMER_APELLIDO)) AS NOMBRE, a.DATOS.NOMBRE AS APLICACION, r.FECHAS
    FROM REGISTRO r, CLIENTE c, APLICACION a
    WHERE r.CED_CLIENTE = c.CEDULA AND a.ID = r.ID_APLICACION
    ORDER BY c.CEDULA;

--Aliadas y a que sector pertenecen
CREATE OR REPLACE VIEW v_sector_aliadas AS
    SELECT a.DATOS.NOMBRE AS APLICACION, s.NOMBRE
    FROM ALIADA a, SECTOR s
    WHERE a.ID_SECTOR = s.ID;

--Todos los detalles de los servicios de cada aplicacion
CREATE OR REPLACE VIEW v_detalle_servicios AS
    SELECT s.id,  a.DATOS.NOMBRE AS APLICACION, s.ESPECIFICACION.CANTIDAD AS CANTIDAD_ENVIOS, CONCAT(s.ESPECIFICACION.PRECIO,'$') AS PRECIO, CONCAT(to_char(s.FECHA.FECHA_INICIO,'DD/MM/YYYY'),CONCAT('-',to_char(s.FECHA.FECHA_FIN,'DD/MM/YYYY'))) AS VIGENCIA,s.PERIODO AS PERIODO
    FROM SERVICIO s, APLICACION a
    WHERE s.ID_APLICACION = a.ID
    ORDER BY 1;

--Todos los detalles de todos los contratos
CREATE OR REPLACE VIEW v_detalle_contratos AS
    SELECT c.N_CONTRATO, a.DATOS.NOMBRE AS APLICACION, x.DATOS.NOMBRE AS ALIADA,to_char(c.FECHAS.FECHA_INICIO,'DD/MM/YYYY') AS INICIO, to_char(c.FECHAS.FECHA_FIN,'DD/MM/YYYY') AS FIN
    FROM CONTRATO c, APLICACION a, ALIADA x
    WHERE c.ID_APLICACION = a.ID AND c.ID_ALIADA = x.ID
    ORDER BY 1;

--Todas las sucursales de las aliadas
CREATE OR REPLACE VIEW v_sucursales_aliadas AS
    SELECT a.DATOS.NOMBRE AS ALIADA, u.NOMBRE AS ZONA
    FROM SUCURSAL s, ALIADA a, UBICACION u
    WHERE s.ID_ALIADA = a.ID AND s.ID_ZONA = u.ID;

--Todas la unidades y sus detalles por aplicacion y ubicacion
  CREATE OR REPLACE VIEW v_unidades AS
    SELECT a.DATOS.NOMBRE AS APLICACION, x.PLACA, x.TIPO, u.NOMBRE AS UBICACION, x.ESTATUS
    FROM UNIDAD x, UBICACION u, APLICACION a
    WHERE x.ID_APLICACION_OFICINA = a.ID AND x.ID_ZONA_OFICINA = u.ID
    ORDER BY x.ID;

--Direccion completa de todos los usuarios
CREATE OR REPLACE VIEW v_direccion_usuarios AS
    SELECT c.CEDULA, CONCAT(c.PRIMER_NOMBRE,CONCAT(' ', c.PRIMER_APELLIDO)) AS NOMBRE, e.NOMBRE AS ESTADO, m.NOMBRE AS MUNICIPIO, z.NOMBRE AS ZONA, p.DESCRIPCION
    FROM DIRECCION d, CLIENTE c, PTO_REFERENCIA p, UBICACION z, UBICACION m, UBICACION e
    WHERE d.CED_CLIENTE = c.CEDULA AND d.ID_PTO_REFERENCIA = p.ID AND d.ID_ZONA = z.ID AND z.ID_PADRE = m.ID AND m.ID_PADRE = e.ID;

--Pedidos posibles
CREATE OR REPLACE VIEW v_pedidos_posibles AS
    SELECT c.CEDULA, app.ID AS ID_APP, ali.ID AS ID_ALIADA, r.FECHAS AS FECHA_REGISTRO, app.DATOS.NOMBRE AS NOMBRE_APP, ali.DATOS.NOMBRE AS NOMBRE_ALIADA, x.FECHAS.FECHA_INICIO AS FECHA_I_CONTRATO, x.FECHAS.FECHA_FIN AS FECHA_F_CONTRATO
    FROM CLIENTE c, APLICACION app, REGISTRO r, CONTRATO x, ALIADA ali
    WHERE r.CED_CLIENTE=c.CEDULA AND r.ID_APLICACION=app.ID AND x.ID_APLICACION=app.ID AND x.ID_ALIADA=ali.ID
    AND to_date('05/09/2020','DD/MM/YYYY') BETWEEN x.FECHAS.FECHA_INICIO AND x.FECHAS.FECHA_FIN;

--Pedidos realizados y sus detalles
CREATE OR REPLACE VIEW v_pedidos AS
    SELECT p.tracking, c.CEDULA, c.PRIMER_NOMBRE AS NOMBRE, c.PRIMER_APELLIDO AS APELLIDO, d.NOMBRE AS DIRECCION, app.DATOS.NOMBRE AS APLICACION, ali.DATOS.NOMBRE as ALIADA, s.NOMBRE AS SUCURSAL, u.PLACA, u.TIPO, o.NOMBRE AS OFICINA,to_char(p.FECHAS.FECHA_INICIO,'DD/MM/YYYY - HH24:MI:SS.') as "Fecha Realizado", to_char(p.FECHAS.FECHA_FIN,'DD/MM/YYYY - HH24:MI:SS.') as "Fecha Entregado", CONCAT(ROUND((p.FECHAS.FECHA_FIN-p.FECHAS.FECHA_INICIO)*1440),'min') as "Tiempo de Entrega", CONCAT(p.total,' $') as TOTAL, CONCAT(p.VALORACION,' Estrellas') AS VALORACION
    FROM PEDIDO p, CLIENTE c, APLICACION app, ALIADA ali, UNIDAD u, UBICACION d, UBICACION s, UBICACION o
    WHERE p.CED_CLIENTE = c.CEDULA AND p.ID_APLICACION = app.ID AND p.ID_ALIADA = ali.ID AND p.ID_UNIDAD = u.ID AND p.ID_ZONA_DIRECCION=d.ID AND s.ID = get_closer_sucursal(c.CEDULA,ali.ID,d.ID) AND o.ID = get_closer_oficina(app.ID,s.ID);


--PARA EJECUTAR>  SELECT * FROM nombre_vista;
