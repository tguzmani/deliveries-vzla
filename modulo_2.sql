-- Crea un numero al azar entre 0 y 1, no incluyente
CREATE OR REPLACE FUNCTION random_probability(
    minimo NUMBER,
    maximo NUMBER
)
RETURN NUMBER IS
BEGIN
    IF NOT ((0 < minimo AND minimo < 1) OR (0 < maximo AND maximo < 1)) THEN
        RAISE_APPLICATION_ERROR(-20001, 'ERROR: Mínimo y máximo deben estar entre 0 y 1, no incluyente');
    END IF;

    RETURN TRUNC(DBMS_RANDOM.VALUE(minimo, maximo), 2);
END;

CREATE OR REPLACE PROCEDURE deactivate_units_by_app (
    in_units_to_deactivate NUMBER,
    in_application_id aplicacion.id%TYPE
)
AS
    CURSOR lista_inactivas IS
        SELECT DISTINCT CEIL(COUNT(a.datos.nombre)*random_probability(0.02,0.1)) as inactivas,
                        a.id
        FROM unidad u, oficina o, aplicacion a
        WHERE u.ID_APLICACION_OFICINA = o.ID_APLICACION AND
              o.ID_APLICACION = a.ID
        GROUP BY a.datos.nombre;

    fila_inactivas lista_inactivas%ROWTYPE;
BEGIN
    FOR unidad IN lista_inactivas
        LOOP
            DBMS_OUTPUT.PUT_LINE('id app = ' || unidad.id || 'unidades a joder = ' || unidad.inactivas);
        END LOOP;
END;

CREATE OR REPLACE PROCEDURE deactivate_units_all_apps
AS
    CURSOR lista_inactivas IS
        SELECT DISTINCT CEIL(COUNT(a.datos.nombre)*random_probability(0.02,0.1)) as inactivas,
                        a.id
        FROM unidad u, oficina o, aplicacion a
        WHERE u.ID_APLICACION_OFICINA = o.ID_APLICACION AND
              o.ID_APLICACION = a.ID
        GROUP BY a.id
        ORDER BY a.id;

    fila_inactivas lista_inactivas%ROWTYPE;
BEGIN
    FOR unidad IN lista_inactivas
        LOOP
            DBMS_OUTPUT.PUT_LINE('id app = ' || unidad.id || ' unidades a joder = ' || unidad.inactivas);
        END LOOP;
END;

CALL deactivate_units_all_apps()
