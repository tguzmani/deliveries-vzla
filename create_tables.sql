-- Esquema PL/SQL

CREATE TABLE cliente (
    cedula INTEGER NOT NULL,
    primer_nombre VARCHAR(50) NOT NULL,
    segundo_nombre VARCHAR(50),
    primer_apellido VARCHAR(50) NOT NULL,
    segundo_apellido VARCHAR(50),
    email VARCHAR(50) NOT NULL,
    foto BLOB,

    CONSTRAINT pk_cliente PRIMARY KEY (cedula),
    CONSTRAINT unique_email UNIQUE (email)
);

CREATE TABLE aplicacion (
    id INTEGER GENERATED ALWAYS AS IDENTITY,
    datos datos_empresa,
    logo BLOB,

    CONSTRAINT pk_aplicacion PRIMARY KEY (id)
);

CREATE TABLE registro (
    id_aplicacion INTEGER NOT NULL,
    ced_cliente INTEGER NOT NULL,
    id INTEGER GENERATED ALWAYS AS IDENTITY,
    fechas DATE,

    CONSTRAINT pk_registro PRIMARY KEY (id_aplicacion, ced_cliente, id),
    CONSTRAINT fk_registro_cliente FOREIGN KEY (ced_cliente) REFERENCES cliente (cedula) ON DELETE CASCADE,
    CONSTRAINT fk_registro_aplicacion FOREIGN KEY (id_aplicacion) REFERENCES aplicacion (id) ON DELETE CASCADE
);

CREATE TABLE servicio (
    id INTEGER GENERATED ALWAYS AS IDENTITY,
    id_aplicacion INTEGER NOT NULL,
    especificacion precio_cantidad,
    periodo VARCHAR(50),

    CONSTRAINT pk_servicio PRIMARY KEY (id, id_aplicacion),
    CONSTRAINT fk_servicio_aplicacion FOREIGN KEY (id_aplicacion) REFERENCES aplicacion (id) ON DELETE CASCADE,
    CONSTRAINT ch_servicio CHECK (periodo IN ('mensual', 'trimestral', 'anual'))
);

CREATE TABLE sector (
    id INTEGER GENERATED ALWAYS AS IDENTITY,
    nombre VARCHAR(50) NOT NULL,

    CONSTRAINT pk_sector PRIMARY KEY (id),
    CONSTRAINT unique_sector UNIQUE (nombre)
);

CREATE TABLE aliada (
    id INTEGER GENERATED ALWAYS AS IDENTITY,
    datos datos_empresa,
    logo BLOB,
    id_sector INTEGER,

    CONSTRAINT pk_aliada PRIMARY KEY (id),
    CONSTRAINT fk_aliada_sector FOREIGN KEY (id_sector) REFERENCES sector (id)
);

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
    CONSTRAINT fk_contrato_servicio FOREIGN KEY (id_servicio, id_servicio_aplicacion) REFERENCES servicio (id, id_aplicacion),
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

CREATE TABLE pto_referencia (
    id INTEGER GENERATED ALWAYS AS IDENTITY,
    descripcion VARCHAR(50) NOT NULL,

    CONSTRAINT pk_pto_referencia PRIMARY KEY (id),
    CONSTRAINT unique_pto_referencia UNIQUE (descripcion)
);

CREATE TABLE direccion (
    id INTEGER GENERATED ALWAYS AS IDENTITY,
    ced_cliente INTEGER NOT NULL,
    id_zona INTEGER NOT NULL,
    id_pto_referencia INTEGER NOT NULL,

    CONSTRAINT pk_direccion PRIMARY KEY (id, ced_cliente, id_zona),
    CONSTRAINT fk_direccion_cliente FOREIGN KEY (ced_cliente) REFERENCES cliente (cedula) ON DELETE CASCADE,
    CONSTRAINT fk_direccion_zona FOREIGN KEY (id_zona) REFERENCES ubicacion (id) ON DELETE CASCADE,
    CONSTRAINT fk_pto_referencia FOREIGN KEY (id_pto_referencia) REFERENCES pto_referencia (id)
);

CREATE TABLE unidad (
    id INTEGER GENERATED ALWAYS AS IDENTITY,
    placa VARCHAR(50) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    estatus VARCHAR(50) NOT NULL,
    id_aplicacion_oficina INTEGER NOT NULL,
    id_zona_oficina INTEGER NOT NULL,
    descrip_estatus VARCHAR(50),

    CONSTRAINT pk_unidad PRIMARY KEY (id),
    CONSTRAINT unique_placa UNIQUE (placa),

    CONSTRAINT fk_unidad_oficina FOREIGN KEY (id_aplicacion_oficina, id_zona_oficina)
      REFERENCES oficina (id_aplicacion, id_zona),

    CONSTRAINT ch_tipo CHECK (tipo IN ('carro', 'camioneta', 'moto')),
    CONSTRAINT ch_estatus CHECK (estatus IN ('activo', 'en reparación'))
);

CREATE TABLE pedido (
    tracking INTEGER GENERATED ALWAYS AS IDENTITY,
    fechas fechas,
    total NUMBER(8,2) NOT NULL,
    ced_cliente INTEGER NOT NULL,
    id_aplicacion INTEGER NOT NULL,
    id_aliada INTEGER NOT NULL,
    id_unidad  INTEGER NOT NULL,
    id_cliente_direccion INTEGER NOT NULL,
    id_zona_direccion INTEGER NOT NULL,
    id_direccion INTEGER NOT NULL,
    valoracion INTEGER,

    CONSTRAINT pk_pedido PRIMARY KEY (tracking),

    CONSTRAINT fk_pedido_cliente FOREIGN KEY (ced_cliente) REFERENCES cliente (cedula),
    CONSTRAINT fk_pedido_aplicacion FOREIGN KEY (id_aplicacion) REFERENCES aplicacion (id),
    CONSTRAINT fk_pedido_aliada FOREIGN KEY (id_aliada) REFERENCES aliada (id),
    CONSTRAINT fk_pedido_unidad FOREIGN KEY (id_unidad) REFERENCES unidad (id),
    CONSTRAINT fk_pedido_direccion FOREIGN KEY (id_cliente_direccion,id_zona_direccion,id_direccion)
      REFERENCES direccion (ced_cliente,id_zona,id),

    CONSTRAINT ch_valoracion CHECK (valoracion BETWEEN 1 and 5)
);

CREATE TABLE producto (
    id INTEGER GENERATED ALWAYS AS IDENTITY,
    tracking_pedido INTEGER NOT NULL,
    cod_producto INTEGER NOT NULL,
    especificacion precio_cantidad,
    id_sector INTEGER NOT NULL,

    CONSTRAINT pk_producto PRIMARY KEY (id, tracking_pedido),
    CONSTRAINT fk_producto_pedido FOREIGN KEY (tracking_pedido) REFERENCES pedido (tracking) ON DELETE CASCADE,
    CONSTRAINT fk_producto_sector FOREIGN KEY (id_sector) REFERENCES sector (id)
);
