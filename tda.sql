-- TDAs

--TDA: datos_empresa

CREATE OR REPLACE TYPE datos_empresa AS OBJECT(
    logo     BLOB,
    nombre    VARCHAR2(20),
    rif     VARCHAR2(20),

    STATIC FUNCTION validar_rif(rif VARCHAR2) RETURN VARCHAR2,
    STATIC FUNCTION validar_nombre(nombre VARCHAR2) RETURN VARCHAR2
);

CREATE OR REPLACE TYPE BODY datos_empresa IS
STATIC FUNCTION validar_rif(rif VARCHAR2) RETURN VARCHAR2
IS
BEGIN
    IF regexp_like(rif, '^[[:digit:]]{8,10}$') THEN
          RETURN (rif);
    ELSE
          RAISE_APPLICATION_ERROR(-20001, 'ERROR: el RIF debe ser de 8 a 10 dígitos');
    END IF;
END;

STATIC FUNCTION validar_nombre(nombre VARCHAR2) RETURN VARCHAR2
IS
BEGIN
    IF NOT regexp_like(nombre, '^[[:blank:]]*$') THEN
          RETURN (nombre);
    ELSE
          RAISE_APPLICATION_ERROR(-20001, 'ERROR: el nombre no puede estar vacío.');
    END IF;
END;
END;

--TDA: fechas

CREATE OR REPLACE TYPE fechas AS OBJECT(
    fecha_inicio DATE,
    fecha_fin DATE,

    STATIC FUNCTION validar_fecha(fecha DATE) RETURN DATE,
    STATIC FUNCTION validar_vigencia(fecha_fin VARCHAR2) RETURN DATE
);

CREATE OR REPLACE TYPE BODY fechas IS

END;

--TDA: precio_cantidad

CREATE OR REPLACE TYPE precio_cantidad AS OBJECT(
    cantidad INTEGER,
    precio NUMBER(8,2),

    STATIC FUNCTION validar_cantidad(cantidad INTEGER) RETURN INTEGER,
    STATIC FUNCTION validar_precio(precio NUMBER) RETURN NUMBER
);

CREATE OR REPLACE TYPE BODY precio_cantidad IS

END;
