--CODIGO DE SIMULACION DE Deliveries

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
        --IF (aleatorio<3) THEN
        dbms_output.put_line(evento || ') CLIENTE: ' || aux.CEDULA || '. APLICACION: ' || aux.NOMBRE_APP || '. ALIADA: ' || aux.ID_ALIADA || '.');
        --END IF;
    END LOOP;
    CLOSE c1;
END;

/

CALL simulate_day(to_date('01/12/2020','DD/MM/YYYY'));

/

CREATE OR REPLACE PROCEDURE crear_pedido(in_fecha IN DATE, in-cedula IN INTEGER, in-app IN INTEGER, in-ali IN INTEGER)
IS
    minuto_pedido NUMBER;
    fecha_pedido DATE;
BEGIN
    minuto_pedido:= DBMS_RANDOM.VALUE(480,1260);
    fecha_pedido:=in_fecha+minuto_pedido/1440;
    --INSERT INTO PEDIDO VALUES (DEFAULT,FECHAS(fecha_pedido,fecha_pedido+GET_TIME()));
end;

/

CREATE OR REPLACE FUNCTION get_closer_sucursal(in_cedula INTEGER, in_aliada INTEGER)
RETURN INTEGER
IS
    aux_direccion DIRECCION%rowtype;
    aux_zona UBICACION%rowtype;

    resultado_aliada ALIADA.id%type;
    resultado_ubicacion UBICACION.id%type;
    resultado_distancia NUMBER;

BEGIN
    SELECT * INTO aux_direccion FROM
        (SELECT * FROM DIRECCION WHERE CED_CLIENTE=in_cedula ORDER BY DBMS_RANDOM.VALUE)
        WHERE ROWNUM=1;

    SELECT * INTO aux_zona FROM UBICACION WHERE ID=aux_direccion.ID_ZONA;

    dbms_output.put_line('- UBICACION: ' || aux_zona.NOMBRE || '.');

    dbms_output.put_line( get_travel_time(
    10.50071475276337,
    -66.9511029846569,
    10.48666244401694,
    -66.90133777179757
    ));

    dbms_output.put_line(get_travel_time(
    10.50071475276337,-66.9511029846569,
    aux_zona.LATITUD ,aux_zona.LONGITUD));

    --SELECT u.id, GET_TRAVEL_TIME(u.LATITUD,u.LONGITUD,aux_zona.LATITUD,aux_zona.LONGITUD)
        --INTO resultado_ubicacion, resultado_distancia
        --FROM UBICACION u, ALIADA a, SUCURSAL s
        --WHERE u.id = s.id_zona AND s.id_aliada=a.id AND a.id=in_aliada
        --ORDER BY 2;

    --dbms_output.put_line('UBICACION: ' || resultado_ubicacion || '- TIEMPO: ' || resultado_distancia || ' min.');

    RETURN aux_zona.ID;

END;

/

--VALORES DE PRUEBA
SELECT GET_CLOSER_SUCURSAL(9234140,1) FROM DUAL;
SELECT GET_CLOSER_SUCURSAL(11192772,10) FROM DUAL;
SELECT GET_CLOSER_SUCURSAL(11914781,1) FROM DUAL;
