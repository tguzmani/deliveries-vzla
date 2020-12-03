-- TDAs

--TDA: DATOS EMPRESA

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
