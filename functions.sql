--FUNCIÓN GENERADORA DE FECHAS RANDOM
CREATE FUNCTION get_random_date(fecha_fin DATE)
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
