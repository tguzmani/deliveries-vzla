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
    fecha FECHAS,

    CONSTRAINT pk_servicio PRIMARY KEY (id, id_aplicacion),
    CONSTRAINT fk_servicio_aplicacion FOREIGN KEY (id_aplicacion) REFERENCES aplicacion (id) ON DELETE CASCADE,
    CONSTRAINT ch_servicio CHECK (periodo IN ('mensual', 'trimestral', 'anual'))
);