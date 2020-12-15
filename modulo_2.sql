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

------------------------------------------------------------------------------------------------------
-- Punto 1: Se dañan entre 2 y 10% de unidades a la semana
------------------------------------------------------------------------------------------------------

---------------------------------------------------
-- Selects
---------------------------------------------------

-- Numero de unidades activas por aplicacion
SELECT DISTINCT COUNT(*), a.id
FROM unidad u, oficina o, aplicacion a
WHERE u.ID_APLICACION_OFICINA = o.ID_APLICACION AND
      o.ID_APLICACION = a.ID AND
      o.ID_ZONA = u.ID_ZONA_OFICINA AND
      u.estatus = 'activo'
GROUP BY a.id
ORDER BY a.id;

-- Numero de unidades por aplicacion
SELECT DISTINCT COUNT(*), a.id
FROM unidad u, oficina o, aplicacion a
WHERE u.ID_APLICACION_OFICINA = o.ID_APLICACION AND
      o.ID_APLICACION = a.ID AND
      o.ID_ZONA = u.ID_ZONA_OFICINA
GROUP BY a.id
ORDER BY a.id;

---------------------------------------------------
-- Stored Procedures
---------------------------------------------------

-- Cambia el estatus de las unidades de una aplicacion a inactivo
-- Recibe un limite de unidades a desactivar y un id de una aplicacion
CREATE OR REPLACE PROCEDURE deactivate_units_by_app (
    in_units_to_deactivate NUMBER,
    in_application_id aplicacion.id%TYPE
)
AS
    CURSOR lista_inactivas IS
        SELECT DISTINCT u.id as id_unidad, a.id as id_app
            FROM unidad u, oficina o, aplicacion a
            WHERE u.ID_APLICACION_OFICINA = o.ID_APLICACION AND
                  o.ID_APLICACION = a.ID AND
                  o.ID_ZONA = u.ID_ZONA_OFICINA AND
                  a.ID = in_application_id AND
                  u.estatus = 'activo'
            FETCH FIRST in_units_to_deactivate ROWS ONLY;
BEGIN
    FOR unidad IN lista_inactivas
        LOOP
            -- DBMS_OUTPUT.PUT_LINE( '    id unidad = ' || unidad.id_unidad);
            UPDATE unidad SET estatus = 'en reparación' WHERE id = unidad.id_unidad;
        END LOOP;
END;

-- Lista cuántas unidades activas tiene cada aplicación
-- Una vez obtenidos estos parámetros se procede a desactivar
CREATE OR REPLACE PROCEDURE deactivate_units_all_apps
AS
    CURSOR lista_inactivas IS
        SELECT DISTINCT CEIL(COUNT(a.datos.nombre)*random_probability(0.02,0.1)) as inactivas,
                        a.id
        FROM unidad u, oficina o, aplicacion a
        WHERE u.ID_APLICACION_OFICINA = o.ID_APLICACION AND
              o.ID_APLICACION = a.ID AND
              o.ID_ZONA = u.ID_ZONA_OFICINA AND
              u.estatus = 'activo'
        GROUP BY a.id
        ORDER BY a.id;

BEGIN
    FOR unidad IN lista_inactivas
        LOOP
            -- DBMS_OUTPUT.PUT_LINE('id app = ' || unidad.id || ' unidades a desactivar = ' || unidad.inactivas);
            deactivate_units_by_app(unidad.inactivas, unidad.id);
        END LOOP;
END;

CALL deactivate_units_all_apps();

-- Verificar que las unidades se hayan desactivado
SELECT * FROM unidad;

-- Restaurar y verificar que los estados a activo
UPDATE unidad SET estatus = 'activo';

------------------------------------------------------------------------------------------------------
-- Punto 2: Se reparan entre 10 y 20% de unidades dañadas
------------------------------------------------------------------------------------------------------

DECLARE
    BEGIN
    FOR i IN 1..5 LOOP
        deactivate_units_all_apps();
    END LOOP;
END;

---------------------------------------------------
-- Selects
---------------------------------------------------

SELECT DISTINCT COUNT(*), a.id
FROM unidad u, oficina o, aplicacion a
WHERE u.ID_APLICACION_OFICINA = o.ID_APLICACION AND
      o.ID_APLICACION = a.ID AND
      o.ID_ZONA = u.ID_ZONA_OFICINA AND
      u.estatus = 'en reparación'
GROUP BY a.id
ORDER BY a.id;

SELECT DISTINCT *
FROM unidad u, oficina o, aplicacion a
WHERE u.ID_APLICACION_OFICINA = o.ID_APLICACION AND
      o.ID_APLICACION = a.ID AND
      o.ID_ZONA = u.ID_ZONA_OFICINA AND
      u.estatus = 'en reparación'
ORDER BY a.id;

---------------------------------------------------
-- Stored Procedures
---------------------------------------------------

CREATE OR REPLACE PROCEDURE repair_units_by_app (
    in_units_to_deactivate NUMBER,
    in_application_id aplicacion.id%TYPE
)
AS
    CURSOR lista_inactivas IS
        SELECT DISTINCT u.id as id_unidad, a.id as id_app
            FROM unidad u, oficina o, aplicacion a
            WHERE u.ID_APLICACION_OFICINA = o.ID_APLICACION AND
                  o.ID_APLICACION = a.ID AND
                  o.ID_ZONA = u.ID_ZONA_OFICINA AND
                  a.ID = in_application_id AND
                  u.estatus = 'en reparación'
            FETCH FIRST in_units_to_deactivate ROWS ONLY;
BEGIN
    FOR unidad IN lista_inactivas
        LOOP
            -- DBMS_OUTPUT.PUT_LINE( '    id unidad = ' || unidad.id_unidad);
            UPDATE unidad SET estatus = 'activo' WHERE id = unidad.id_unidad;
        END LOOP;
END;

-- Lista cuántas unidades activas tiene cada aplicación
-- Una vez obtenidos estos parámetros se procede a desactivar
CREATE OR REPLACE PROCEDURE repair_units_all_apps
AS
    CURSOR lista_inactivas IS
        SELECT DISTINCT CEIL(COUNT(a.datos.nombre)*random_probability(0.1,0.2)) as inactivas,
                        a.id
        FROM unidad u, oficina o, aplicacion a
        WHERE u.ID_APLICACION_OFICINA = o.ID_APLICACION AND
              o.ID_APLICACION = a.ID AND
              o.ID_ZONA = u.ID_ZONA_OFICINA AND
              u.estatus = 'en reparación'
        GROUP BY a.id
        ORDER BY a.id;

BEGIN
    FOR unidad IN lista_inactivas
        LOOP
            -- DBMS_OUTPUT.PUT_LINE('id app = ' || unidad.id || ' unidades a reparar = ' || unidad.inactivas);
            repair_units_by_app(unidad.inactivas, unidad.id);
        END LOOP;
END;

CALL repair_units_all_apps();

------------------------------------------------------------------------------------------------------
-- Punto 3: Si el 30% de las unidades se dañan, entonces se adquieren unidades nuevas
------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION num_units_by_status_and_app (
    in_application_id aplicacion.id%TYPE,
    in_estatus unidad.estatus%TYPE
) RETURN NUMBER IS
    num_units NUMBER;
BEGIN
    SELECT DISTINCT COUNT(*)
    INTO num_units
    FROM unidad u, oficina o, aplicacion a
    WHERE u.ID_APLICACION_OFICINA = o.ID_APLICACION AND
          o.ID_APLICACION = in_application_id AND
          o.ID_ZONA = u.ID_ZONA_OFICINA AND
          u.estatus = in_estatus
    GROUP BY a.id;
    RETURN num_units;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    RETURN 0;
END;

SELECT DISTINCT num_units_by_status_and_app(6, 'en reparación')/COUNT(*), a.id
FROM unidad u, oficina o, aplicacion a
WHERE u.ID_APLICACION_OFICINA = o.ID_APLICACION AND
      o.ID_APLICACION = a.ID AND
      o.ID_ZONA = u.ID_ZONA_OFICINA AND
      a.id = 6
GROUP BY a.id
ORDER BY a.id;

CALL deactivate_units_all_apps();

UPDATE unidad SET estatus = 'activo';

CREATE OR REPLACE TRIGGER adquire_units
AFTER UPDATE ON unidad
DECLARE
    CURSOR listar_num_unidades IS
        SELECT DISTINCT COUNT(*) as num_unidades, a.id as id_aplicacion
        FROM unidad u, oficina o, aplicacion a
        WHERE u.ID_APLICACION_OFICINA = o.ID_APLICACION AND
              o.ID_APLICACION = a.ID AND
              o.ID_ZONA = u.ID_ZONA_OFICINA
        GROUP BY a.id
        ORDER BY a.id;

    proportion NUMBER;
    num_deactivated_units NUMBER;
    unit_type VARCHAR2(50);
    plate_number VARCHAR(50);
    zona_oficina INTEGER;
BEGIN
    FOR unidad in listar_num_unidades
    LOOP
        num_deactivated_units := num_units_by_status_and_app(unidad.id_aplicacion,
            'en reparación');

        proportion := num_deactivated_units / unidad.num_unidades;

        IF proportion >= 0.3 THEN
            DBMS_OUTPUT.PUT_LINE('TRIGGER: proportion = ' || proportion || ' from app id = ' || unidad.id_aplicacion);
            FOR i IN 1..num_deactivated_units
            LOOP
                -- Elegir vehículo al azar
                SELECT u.tipo
                INTO unit_type
                FROM unidad u
                GROUP BY tipo
                ORDER BY DBMS_RANDOM.VALUE
                FETCH FIRST 1 ROW ONLY;

                -- Generar placa según sea el caso
                IF unit_type = 'moto' THEN
                    plate_number := get_random_placa(2);
                ELSE
                    plate_number := get_random_placa(1);
                END IF;

                -- Al azar, se elige la oficina en donde se pondrá la unidad
                SELECT DISTINCT o.id_zona as id_zona_oficina
                INTO zona_oficina
                FROM unidad u, oficina o, aplicacion a
                WHERE u.ID_APLICACION_OFICINA = o.ID_APLICACION AND
                      o.ID_APLICACION = a.ID AND
                      o.ID_ZONA = u.ID_ZONA_OFICINA AND
                      a.id = unidad.id_aplicacion
                ORDER BY DBMS_RANDOM.VALUE
                FETCH FIRST 1 ROW ONLY;

                -- DBMS_OUTPUT.PUT_LINE('se van a comprar ' || num_deactivated_units || ' ' || '(' || i || '/' || num_deactivated_units || ')');

                INSERT INTO unidad VALUES (DEFAULT,
                                           plate_number,
                                           unit_type, 'activo',
                                           unidad.id_aplicacion,
                                           zona_oficina,
                                           NULL);
            END LOOP;
        END IF;
    END LOOP;
END;

SELECT DISTINCT o.id_zona as id_zona_oficina
FROM unidad u, oficina o, aplicacion a
WHERE u.ID_APLICACION_OFICINA = o.ID_APLICACION AND
      o.ID_APLICACION = a.ID AND
      o.ID_ZONA = u.ID_ZONA_OFICINA AND
      a.id = 3
ORDER BY DBMS_RANDOM.VALUE
FETCH FIRST 1 ROW ONLY;

------------------------------------------------------------------------------------------------------
-- Prueba final del módulo
------------------------------------------------------------------------------------------------------

CALL deactivate_units_all_apps();
CALL repair_units_all_apps();

-- Las unidades nuevas están después del ID = 140
SELECT * FROM unidad WHERE ID > 140 ORDER BY 1 DESC;

-- Eliminar todas las unidades nuevas
DELETE FROM unidad WHERE ID > 140;
