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

-- (1/3) Parece que para poder utilizar bien los JSON hay que utilizar una tabla auxiliar
-- En esta se guardan las filas de JSON y luego con un SELECT (más abajo)
-- Se extrae información de las mismas

CREATE TABLE json_http_helper (
    id INTEGER GENERATED ALWAYS AS IDENTITY,
    fecha DATE DEFAULT CURRENT_DATE,
    data CLOB,

    CONSTRAINT ch_json CHECK (data IS JSON)
);

-- (2/3) Este es el procedimiento de prueba. Una vez domine su uso, me muevo al API de Google
CREATE OR REPLACE PROCEDURE test_http (
    in_query VARCHAR
)
IS
    req utl_http.req;
    res utl_http.resp;
    url VARCHAR2(4000) := 'http://localhost:8000/?data=' || in_query;
    name VARCHAR2(4000);
    buffer VARCHAR2(4000);
BEGIN
    req := utl_http.begin_request(url, 'GET',' HTTP/1.1');
    -- utl_http.set_header(req, 'user-agent', 'mozilla/4.0'); 
    utl_http.set_header(req, 'content-type', 'application/json'); 
    -- utl_http.set_header(req, 'Content-Length', length(content));

    -- utl_http.write_text(req, content);
    res := utl_http.get_response(req);

    DELETE FROM json_http_helper;

    BEGIN
      LOOP
        utl_http.read_line(res, buffer);
        dbms_output.put_line(buffer);
        INSERT INTO json_http_helper VALUES (default, default, buffer);
      END LOOP;
      utl_http.end_response(res);
    EXCEPTION
      WHEN utl_http.end_of_body 
      THEN
        utl_http.end_response(res);
    END;
END;

CALL test_http('350');

-- (3/3) Verificar que el SP hace lo que debe
SELECT jt.*
FROM json_http_helper,
JSON_TABLE(data, '$'
    COLUMNS (distance INTEGER PATH '$.distance'))
AS jt;