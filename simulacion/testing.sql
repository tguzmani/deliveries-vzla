CREATE OR REPLACE PROCEDURE test_pedido(
    in_fecha IN DATE,
    in_cedula IN INTEGER,
    in_app IN INTEGER,
    in_ali IN INTEGER,
    in_elapsed in number)
IS
    minuto_pedido NUMBER;
    fecha_pedido DATE;

    id_zona_sucursal UBICACION.id%type;
    aux_direccion DIRECCION%rowtype;
    id_zona_oficina UBICACION.id%type;
    aux_zona_oficina UBICACION%rowtype;
    aux_zona_sucursal UBICACION%rowtype;
    aux_zona_direccion UBICACION%rowtype;

    tiempo_recogida NUMBER;
    tiempo_entrega NUMBER;
    step VARCHAR2(50);

    fecha_entrega DATE;
BEGIN
    -- dbms_output.put_line('NUEVO PEDIDO: ');
    SEPARATOR('-', 80);

    --SE OBTIENE UNA HORA ALEATORIA DURANTE ESE DIA PARA EL PEDIDO
    minuto_pedido := DBMS_RANDOM.VALUE(480,1260);
    minuto_pedido := 300;
    fecha_pedido := in_fecha + minuto_pedido / 1440;

    --SE OBTIENE UNA DIRECCION ALEATORIA DE LAS DEL CLIENTE
    SELECT * INTO aux_direccion FROM
        (SELECT * FROM DIRECCION WHERE CED_CLIENTE=in_cedula ORDER BY DBMS_RANDOM.VALUE)
        WHERE ROWNUM=1;

    --SE BUSCA LA SUCURSAL MAS CERCANA A SU DIRECCION
    id_zona_sucursal := get_closer_sucursal(in_cedula, in_ali, aux_direccion.ID_ZONA);

    --SE BUSCA LA OFICINA MAS CERCANA DE LA APLICACION PARA ENVIAR UNA UNIDAD
    id_zona_oficina := get_closer_oficina(in_app, id_zona_sucursal);

    --SE CALCULA EL TIEMPO DE RECOGIDA Y ENTREGA
    SELECT * INTO aux_zona_oficina FROM UBICACION u WHERE u.ID = id_zona_oficina;
    SELECT * INTO aux_zona_sucursal FROM UBICACION u WHERE u.ID = id_zona_sucursal;
    SELECT * INTO aux_zona_direccion FROM UBICACION u WHERE u.ID = aux_direccion.ID_ZONA;

    tiempo_recogida := get_travel_time(
        aux_zona_oficina.LONGITUD,
        aux_zona_oficina.LATITUD,
        aux_zona_sucursal.LONGITUD,
        aux_zona_sucursal.LATITUD);

    tiempo_recogida := tiempo_recogida + 15;
    -- dbms_output.put_line('-RECOGIDA: ' || tiempo_recogida || 'min.');

    tiempo_entrega := get_travel_time(
        aux_zona_sucursal.LONGITUD,
        aux_zona_sucursal.LATITUD,
        aux_zona_direccion.LONGITUD,
        aux_zona_direccion.LATITUD);

    if (in_elapsed < tiempo_recogida) then
        dbms_output.put_line('elapsed < recogida: ');

        step := get_travel_step(
        aux_zona_oficina.LONGITUD,
        aux_zona_oficina.LATITUD,
        aux_zona_sucursal.LONGITUD,
        aux_zona_sucursal.LATITUD,
        in_elapsed * 60);
    else
        dbms_output.put_line('elapsed >= recogida: ');
        step := get_travel_step(
        aux_zona_sucursal.LONGITUD,
        aux_zona_sucursal.LATITUD,
        aux_zona_direccion.LONGITUD,
        aux_zona_direccion.LATITUD,
        (in_elapsed - tiempo_recogida) * 60);
    end if;

    dbms_output.put_line('-STEP: ' || step);

    tiempo_entrega := tiempo_entrega + 10;
    -- dbms_output.put_line('-ENTREGA: ' || tiempo_entrega || 'min.');

    fecha_entrega := fecha_pedido + (tiempo_recogida + tiempo_entrega) / 1440;

    -- dbms_output.put_line('-FECHA PEDIDO: ' || TO_CHAR(fecha_pedido,'DD/MM/YYYY - HH24:MI:SS.'));
    -- dbms_output.put_line('-FECHA ENTREGA: ' || TO_CHAR(fecha_entrega, 'DD/MM/YYYY - HH24:MI:SS.'));
end;

begin
    FOR i IN 1..9
    LOOP
       test_pedido(SYSDATE, 5263491, 2, 1, 5*i);
    END LOOP;
end;



select sysdate + 0.03 from dual;