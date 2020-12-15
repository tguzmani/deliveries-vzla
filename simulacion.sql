--CODIGO DE SIMULACION DE Deliveries
--SE RECOMIENDA COMPILAR LAS FUNCIONES Y SP ANTES DE PROBARLO

-----------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------

--SP QUE SIMULA UN DIA COMPLETO, BUSCA TODOS LOS PEDIDOS POSIBLES Y ALEATORIAMENTE DECIDE SI SE REALIZAN

CREATE OR REPLACE PROCEDURE simulate_day (in_fecha IN DATE)
IS
    aux v_pedidos_posibles%rowtype;
    evento NUMBER;
    contador INTEGER;
    CURSOR c1 IS
        SELECT * FROM v_pedidos_posibles --SAMPLE(50)
        WHERE in_fecha BETWEEN FECHA_I_CONTRATO AND FECHA_F_CONTRATO
        AND in_fecha > FECHA_REGISTRO;
BEGIN
    OPEN c1;
    contador:=0;
    evento:=0;
    LOOP
        FETCH c1 INTO aux;
        EXIT WHEN c1%NOTFOUND;
        contador:=contador+1;
        evento:= TRUNC(DBMS_RANDOM.VALUE(0,10));
        IF (evento<3) THEN
            dbms_output.put_line('-------------------------------------------------------');
            --dbms_output.put_line(evento || ') CLIENTE: ' || aux.CEDULA || '. APLICACION: ' || aux.ID_APP || '. ALIADA: ' || aux.ID_ALIADA || '.');
            CREAR_PEDIDO(in_fecha,aux.CEDULA,aux.ID_APP,aux.ID_ALIADA);
        END IF;
    END LOOP;
    CLOSE c1;
END;


--SE EJECUTA CON
CALL simulate_day(to_date('01/12/2020','DD/MM/YYYY'));


-----------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------


--SP QUE CREA UN PEDIDO ALEATORIO PARA UNA FECHA, CLIENTE, APLICACION Y ALiADO DADO


CREATE OR REPLACE PROCEDURE crear_pedido(in_fecha IN DATE, in_cedula IN INTEGER, in_app IN INTEGER, in_ali IN INTEGER)
IS
    minuto_pedido NUMBER;
    fecha_pedido DATE;

    id_zona_sucursal UBICACION.id%type;
    aux_direccion DIRECCION%rowtype;
    id_zona_oficina UBICACION.id%type;
    id_unidad UNIDAD.id%type;
    aux_zona_oficina UBICACION%rowtype;
    aux_zona_sucursal UBICACION%rowtype;
    aux_zona_direccion UBICACION%rowtype;

    tiempo_recogida NUMBER;
    tiempo_entrega NUMBER;

    fecha_entrega DATE;
    aux_total PEDIDO.total%type;
    valoracion INTEGER;

    nuevo_tracking PEDIDO.tracking%type;

BEGIN
    dbms_output.put_line('NUEVO PEDIDO: ');

    --SE OBTIENE UNA HORA ALEATORIA DURANTE ESE DIA PARA EL PEDIDO
    minuto_pedido:= DBMS_RANDOM.VALUE(480,1260);
    fecha_pedido:=in_fecha+minuto_pedido/1440;
    dbms_output.put_line('-FECHA: ' || TO_CHAR(fecha_pedido,'DD/MM/YYYY - HH24:MI:SS.'));

    --SE OBTIENE UNA DIRECCION ALEATORIA DE LAS DEL CLIENTE
    SELECT * INTO aux_direccion FROM
        (SELECT * FROM DIRECCION WHERE CED_CLIENTE=in_cedula ORDER BY DBMS_RANDOM.VALUE)
        WHERE ROWNUM=1;

    --SE BUSCA LA SUCURSAL MAS CERCANA A SU DIRECCION
    id_zona_sucursal:=GET_CLOSER_SUCURSAL(in_cedula,in_ali,aux_direccion.ID_ZONA);

    --SE BUSCA LA UNIDAD MAS CERCANA DE LA APLICACION PARA RECOGER EL PEDIDO
    id_zona_oficina:= get_closer_oficina(in_app,id_zona_sucursal);
    id_unidad:= get_unidad_libre(in_app,id_zona_oficina,fecha_pedido);

    --SE CALCULA EL TIEMPO DE RECOGIDA Y ENTREGA
    SELECT * INTO aux_zona_oficina FROM UBICACION u WHERE u.ID = id_zona_oficina;
    SELECT * INTO aux_zona_sucursal FROM UBICACION u WHERE u.ID = id_zona_sucursal;
    SELECT * INTO aux_zona_direccion FROM UBICACION u WHERE u.ID = aux_direccion.ID_ZONA;

    tiempo_recogida:= get_travel_time(aux_zona_oficina.LONGITUD,aux_zona_oficina.LATITUD,aux_zona_sucursal.LONGITUD,aux_zona_sucursal.LATITUD);
    tiempo_recogida:= tiempo_recogida + 15;
    dbms_output.put_line('-RECOGIDA: ' || tiempo_recogida || 'min.');

    tiempo_entrega:= get_travel_time(aux_zona_sucursal.LONGITUD,aux_zona_sucursal.LATITUD,aux_zona_direccion.LONGITUD,aux_zona_direccion.LATITUD);
    tiempo_entrega:= tiempo_entrega + 10;
    dbms_output.put_line('-ENTREGA: ' || tiempo_entrega || 'min.');

    fecha_entrega:= fecha_pedido + (tiempo_recogida+tiempo_entrega)/1440;
    dbms_output.put_line('-HORA ENTREGA: ' || TO_CHAR(fecha_entrega,'DD/MM/YYYY - HH24:MI:SS.'));

    --VALORACION
    valoracion:= DBMS_RANDOM.VALUE(1,8);
    IF (valoracion>5) THEN
        valoracion:=5;
    end if;

    dbms_output.put_line('-VALORACION: ' || valoracion || ' estrellas.');

    INSERT INTO PEDIDO VALUES (DEFAULT,FECHAS(fecha_pedido,fecha_entrega),0,in_cedula,in_app,in_ali,ID_UNIDAD,aux_direccion.CED_CLIENTE,aux_direccion.ID_ZONA,aux_direccion.ID,valoracion);

    SELECT p.TRACKING INTO nuevo_tracking FROM PEDIDO p WHERE p.TOTAL=0;

    --SE INCLUYEN LOS PRODUCTOS
    aux_total := crear_productos(in_ali,nuevo_tracking);
    dbms_output.put_line('-TOTAL: ' || aux_total || '$');

    UPDATE PEDIDO p SET p.TOTAL=aux_total WHERE p.TOTAL=0;

end;

--DATOS DE PRUEBA
CALL CREAR_PEDIDO(to_date('01/12/2020','DD/MM/YYYY'),11914781,2,1);
CALL CREAR_PEDIDO(to_date('01/12/2020','DD/MM/YYYY'),5263491,5,3);

-----------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION crear_productos(in_ali IN INTEGER, in_tracking IN INTEGER)
RETURN NUMBER
IS
    n_pedidos INTEGER;
    cantidad INTEGER;
    precio PEDIDO.total%type;
    total PEDIDO.total%type;
    aux_sector SECTOR.id%type;
BEGIN
    n_pedidos := DBMS_RANDOM.VALUE(1,3);
    total := 0;

    SELECT s.ID INTO aux_sector FROM ALIADA a, SECTOR s WHERE s.ID = a.ID_SECTOR AND a.ID=in_ali;
    dbms_output.put_line('-SECTOR: ' || aux_sector);

    dbms_output.put_line('-PRODUCTOS:');

    WHILE n_pedidos>0
    LOOP
        cantidad := DBMS_RANDOM.VALUE(1,3);
        precio := DBMS_RANDOM.VALUE(0.5,15);
        dbms_output.put_line(n_pedidos || ')CODIGO: ' || get_random_cod_producto() || '- CANTIDAD: ' || cantidad || '- PRECIO: ' || precio || '$');
        INSERT INTO PRODUCTO VALUES (DEFAULT,in_tracking,get_random_cod_producto(),PRECIO_CANTIDAD(PRECIO_CANTIDAD.VALIDAR_CANTIDAD(cantidad),PRECIO_CANTIDAD.VALIDAR_PRECIO(precio)),aux_sector);
        n_pedidos := n_pedidos-1;
        total := total + precio*cantidad;
    end loop;

    RETURN total;
end;

-----------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION get_closer_sucursal(in_cedula INTEGER, in_aliada INTEGER, in_direccion INTEGER)
RETURN INTEGER
IS
    --aux_direccion DIRECCION%rowtype;
    aux_zona UBICACION%rowtype;

    resultado_nombre UBICACION.nombre%type;
    resultado_ubicacion UBICACION.id%type;
    resultado_distancia NUMBER;

    CURSOR c1 IS
        SELECT u.id, u.NOMBRE, GET_TRAVEL_TIME(u.LONGITUD,u.LATITUD,aux_zona.LONGITUD,aux_zona.LATITUD)
        INTO resultado_ubicacion, resultado_nombre, resultado_distancia
        FROM UBICACION u, ALIADA a, SUCURSAL s
        WHERE u.id = s.id_zona AND s.id_aliada=a.id AND a.id=in_aliada
        ORDER BY 3;

BEGIN
    --SELECT * INTO aux_direccion FROM
        --(SELECT * FROM DIRECCION WHERE CED_CLIENTE=in_cedula ORDER BY DBMS_RANDOM.VALUE)
        --WHERE ROWNUM=1;

    SELECT * INTO aux_zona FROM UBICACION WHERE ID=in_direccion;

    dbms_output.put_line('-UBICACION CLIENTE: ' || aux_zona.NOMBRE || '.');

    OPEN c1;
    FETCH c1 INTO resultado_ubicacion, resultado_nombre, resultado_distancia;
    dbms_output.put_line('-SUCURSAL MAS CERCANA: ' || resultado_nombre || '- TIEMPO: ' || resultado_distancia || ' min.');
    CLOSE c1;
    RETURN resultado_ubicacion;

END;

-----------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION get_closer_oficina(in_app INTEGER, in_zona_sucursal INTEGER)
RETURN INTEGER
IS
    aux_zona_sucursal UBICACION%rowtype;

    resultado_nombre UBICACION.nombre%type;
    resultado_ubicacion UBICACION.id%type;
    resultado_distancia NUMBER;

    CURSOR c1 IS
        SELECT u.id, u.NOMBRE, GET_TRAVEL_TIME(u.LONGITUD,u.LATITUD,aux_zona_sucursal.LONGITUD,aux_zona_sucursal.LATITUD)
        --INTO resultado_ubicacion, resultado_nombre, resultado_distancia
        FROM UBICACION u, APLICACION a, OFICINA o
        WHERE u.ID = o.ID_ZONA AND o.ID_APLICACION=a.ID AND a.id=in_app
        ORDER BY 3;

BEGIN

    SELECT * INTO aux_zona_sucursal FROM UBICACION WHERE ID=in_zona_sucursal;

    OPEN c1;
    FETCH c1 INTO resultado_ubicacion, resultado_nombre, resultado_distancia;
    dbms_output.put_line('-OFICINA MAS CERCANA: ' || resultado_nombre || '- TIEMPO: ' || resultado_distancia || ' min.');
    CLOSE c1;
    RETURN resultado_ubicacion;

END;

-----------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION get_unidad_libre(in_app INTEGER, in_zona_oficina INTEGER, in_fecha DATE)
RETURN INTEGER
IS
    aux_unidad UNIDAD%rowtype;

BEGIN
    SELECT * INTO aux_unidad FROM
        (SELECT * FROM UNIDAD x
        WHERE x.ID_APLICACION_OFICINA= in_app AND x.ID_ZONA_OFICINA=in_zona_oficina AND x.ESTATUS='activo'
          AND (SELECT count(p.TRACKING) FROM PEDIDO p WHERE p.ID_UNIDAD=x.ID AND in_fecha BETWEEN p.FECHAS.FECHA_INICIO AND p.FECHAS.FECHA_FIN)=0
        ORDER BY DBMS_RANDOM.VALUE)
        WHERE ROWNUM=1;
            dbms_output.put_line('-UNIDAD: ' || aux_unidad.ID || ' - PLACA: ' || aux_unidad.PLACA || ' - ESTATUS: ' || aux_unidad.ESTATUS || ' - TIPO: ' || aux_unidad.TIPO);
    RETURN aux_unidad.ID;

    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('-NO HAY UNIDADES DISPONIBLES, SOLICITE PEDIDO MAS TARDE');

    RETURN 0;

END;

-----------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
