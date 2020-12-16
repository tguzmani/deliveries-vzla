CREATE TABLE contrato (
    n_contrato INTEGER GENERATED ALWAYS AS IDENTITY,
    id_aplicacion INTEGER NOT NULL,
    id_aliada INTEGER NOT NULL,
    fechas fechas,
    id_servicio INTEGER NOT NULL,
    id_servicio_aplicacion INTEGER NOT NULL,

    CONSTRAINT pk_contrato PRIMARY KEY (n_contrato, id_aplicacion, id_aliada),
    CONSTRAINT fk_contrato_aplicacion FOREIGN KEY (id_aplicacion) REFERENCES aplicacion (id) ON DELETE CASCADE,
    CONSTRAINT fk_contrato_aliada FOREIGN KEY (id_aliada) REFERENCES aliada (id) ON DELETE CASCADE,
    CONSTRAINT fk_contrato_servicio FOREIGN KEY (id_servicio, id_servicio_aplicacion) REFERENCES servicio (id, id_aplicacion)
);

CREATE TABLE servicio (
    id INTEGER GENERATED ALWAYS AS IDENTITY,
    id_aplicacion INTEGER NOT NULL,
    especificacion precio_cantidad,
    periodo VARCHAR(50),
    fechas FECHAS,

    CONSTRAINT pk_servicio PRIMARY KEY (id, id_aplicacion),
    CONSTRAINT fk_servicio_aplicacion FOREIGN KEY (id_aplicacion) REFERENCES aplicacion (id) ON DELETE CASCADE,
    CONSTRAINT ch_servicio CHECK (periodo IN ('mensual', 'trimestral', 'anual'))
);

CREATE TABLE oficina (
    id_aplicacion INTEGER NOT NULL,
    id_zona INTEGER NOT NULL,

    CONSTRAINT pk_oficina PRIMARY KEY (id_aplicacion, id_zona),
    CONSTRAINT fk_oficina_aplicacion FOREIGN KEY (id_aplicacion) REFERENCES aplicacion (id) ON DELETE CASCADE,
    CONSTRAINT fk_oficina_zona FOREIGN KEY (id_zona) REFERENCES ubicacion (id) ON DELETE CASCADE
);

CREATE TABLE sucursal (
    id_aliada INTEGER NOT NULL,
    id_zona INTEGER NOT NULL,

    CONSTRAINT pk_sucursal PRIMARY KEY (id_aliada, id_zona),
    CONSTRAINT fk_sucursal_aliada FOREIGN KEY (id_aliada) REFERENCES aliada (id) ON DELETE CASCADE,
    CONSTRAINT fk_sucursal_zona FOREIGN KEY (id_zona) REFERENCES ubicacion (id) ON DELETE CASCADE
);

CREATE TABLE ubicacion (
    id INTEGER GENERATED ALWAYS AS IDENTITY,
    nombre VARCHAR(50) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    longitud REAL,
    latitud REAL,
    id_padre INTEGER,

    CONSTRAINT pk_ubicacion PRIMARY KEY (id),
    CONSTRAINT fk_ubicacion_ubicacion FOREIGN KEY (id_padre) REFERENCES ubicacion (id),
    CONSTRAINT ch_ubicacion CHECK (tipo IN ('estado', 'municipio', 'zona'))
);