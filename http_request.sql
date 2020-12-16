-- Antes de solicitar cualquier request a Maps, hay que habilitar los permisos

-- (1/2) Primero se crea una entrada en el ACL (Access Control List)
BEGIN
    DBMS_NETWORK_ACL_ADMIN.CREATE_ACL (
        acl => 'networkacl.xml',
        description => 'Allow HTTPS requests',
        principal => 'SYSTEM',
        is_grant => TRUE,
        privilege => 'connect',
        start_date => SYSTIMESTAMP,
        end_date => NULL
    );

    COMMIT;
END;

-- (2/2) Se asigna el ACL. Este lo hace para todos los usuarios
BEGIN
    DBMS_NETWORK_ACL_ADMIN.ASSIGN_ACL (
        acl  => 'networkacl.xml',
        host => '*',
        lower_port => NULL,
        upper_port => NUll
    );

    COMMIT;
END;
/

CREATE OR REPLACE FUNCTION get_travel_time (
    in_origin_long IN UBICACION.latitud%type,
    in_origin_lat IN UBICACION.longitud%type,
    in_destination_long IN UBICACION.latitud%type,
    in_destination_lat IN UBICACION.longitud%type
) RETURN NUMBER
IS
    -- HTTP Request
    req utl_http.req;
    res utl_http.resp;

    -- Ruta
    route VARCHAR2(4000) := 'localhost:8000/?';
    query_origins VARCHAR2(4000) :=
        'originLat=' || in_origin_long || '&originLong=' || in_origin_lat;
    query_destination VARCHAR2(4000) :=
        '&destinationLat=' || in_destination_long || '&destinationLong=' || in_destination_lat;
    url VARCHAR(4000) := route || query_origins || query_destination;



    -- Containers
    buffer VARCHAR2(4000);
    travel_time NUMBER;
BEGIN
    -- Debugging
    DBMS_OUTPUT.PUT_LINE('in_origin_long = ' || in_origin_long);
    DBMS_OUTPUT.PUT_LINE('in_origin_lat = ' || in_origin_lat);
    DBMS_OUTPUT.PUT_LINE('in_destination_long = ' || in_destination_long);
    DBMS_OUTPUT.PUT_LINE('in_destination_lat = ' || in_destination_lat);
    DBMS_OUTPUT.PUT_LINE('url = ' || url);

    req := utl_http.begin_request(url, 'GET',' HTTP/1.1');
    utl_http.set_header(req, 'content-type', 'application/json');
    res := utl_http.get_response(req);

    BEGIN
      LOOP
        utl_http.read_line(res, buffer);
        -- dbms_output.put_line(url);
        DBMS_OUTPUT.PUT_LINE('response = '|| buffer);
        travel_time := TO_NUMBER(buffer);
      END LOOP;

    EXCEPTION
      WHEN utl_http.end_of_body
      THEN
        utl_http.end_response(res);
        RETURN ROUND(travel_time/60,2);
    END;
END;

SELECT get_travel_time(
    10.50071475276337,
    -66.9511029846569,
    10.48666244401694,
    -66.90133777179757
) AS travel_time FROM dual;

