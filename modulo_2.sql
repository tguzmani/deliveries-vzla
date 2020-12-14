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

CREATE OR REPLACE FUNCTION num_units_per_app(
    id_aplicacion NUMBER
)
RETURN NUMBER IS
BEGIN
    RETURN 1;
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
      u.estatus = 'activas'
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
                  a.ID = in_application_id
            FETCH FIRST in_units_to_deactivate ROWS ONLY;
BEGIN
    FOR unidad IN lista_inactivas
        LOOP
            DBMS_OUTPUT.PUT_LINE( '    id unidad = ' || unidad.id_unidad);
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
            DBMS_OUTPUT.PUT_LINE('id app = ' || unidad.id || ' unidades a desactivar = ' || unidad.inactivas);
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

