-- FUNCIÓN GENERADORA DE FECHAS RANDOM
CREATE OR REPLACE FUNCTION get_random_date(fecha_fin DATE)
RETURN DATE IS
    fecha DATE;
BEGIN
    SELECT TO_CHAR(TO_DATE(
            TRUNC(
                DBMS_RANDOM.VALUE(TO_CHAR(DATE '2020-03-13','J'), TO_CHAR(fecha_fin,'J'))
                 ),'J'))
    INTO fecha FROM DUAL;

    RETURN fecha;
END;

-- FUNCIÓN GENERADORA DE PLACAS
CREATE OR REPLACE FUNCTION get_random_placa(in_tipo in INTEGER)
RETURN VARCHAR IS
    n_placa UNIDAD.placa%type;
    repetida INTEGER;
BEGIN
    n_placa:='';
    repetida:=1;
    WHILE (repetida=1)
    LOOP
        IF (in_tipo = 1) THEN
            --SE CREA PLACA DE AUTOMOVIL, CAMIONETA
            n_placa:= CONCAT(DBMS_RANDOM.STRING('U',3),TRUNC(DBMS_RANDOM.VALUE(100,999.9)));
            n_placa:= CONCAT(n_placa, DBMS_RANDOM.STRING('U',2));
        elsif (in_tipo = 2) THEN
            --SE CREA PLACA DE MOTOCICLETA
            n_placa:= CONCAT(DBMS_RANDOM.STRING('U',2),TRUNC(DBMS_RANDOM.VALUE(0,9.9)));
            n_placa:= CONCAT(n_placa, DBMS_RANDOM.STRING('U',1));
            n_placa:= CONCAT(n_placa, TRUNC(DBMS_RANDOM.VALUE(10,99.9)));
            n_placa:= CONCAT(n_placa, DBMS_RANDOM.STRING('U',1));
        end if;
        SELECT count(U.id) INTO repetida FROM UNIDAD U WHERE U.placa = n_placa;
    END LOOP;
    RETURN n_placa;
END;

CREATE OR REPLACE FUNCTION get_estado(zona VARCHAR)
    RETURN VARCHAR IS
    estado UBICACION.nombre%type;
BEGIN
    SELECT u.NOMBRE
    INTO estado
    FROM UBICACION u
    WHERE u.TIPO = 'estado' and LEVEL = 3
    START WITH u.NOMBRE = zona
    CONNECT BY PRIOR u.ID_PADRE = u.id;

    RETURN estado;
END;

create FUNCTION get_startDate(aliada VARCHAR, app VARCHAR) RETURN VARCHAR IS
    fecha date ;
BEGIN
    SELECT MIN(TO_CHAR(c.FECHAS.FECHA_INICIO, 'DD-MM-YYYY'))
    INTO fecha
    FROM CONTRATO c
             INNER JOIN ALIADA A2 on A2.ID = c.ID_ALIADA
             INNER JOIN APLICACION A3 on A3.ID = c.ID_APLICACION
    WHERE a2.DATOS.NOMBRE = aliada AND a3.DATOS.NOMBRE = app;

    RETURN TO_CHAR(fecha, 'DD-MM-YYYY');
END;

--FUNCION QUE GENERA CODIGO DE PRODUCTO ALEATORIO
CREATE OR REPLACE FUNCTION get_random_cod_producto
RETURN INTEGER IS
    codigo PRODUCTO.COD_PRODUCTO%type;
BEGIN
    SELECT DBMS_RANDOM.VALUE(1000,999999999)
    INTO codigo FROM DUAL;

    RETURN codigo;
END;
