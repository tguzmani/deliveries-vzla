-- Create table SQL
CREATE TABLE cliente (
    cedula INTEGER NOT NULL AUTO_INCREMENT,
    primer_nombre VARCHAR(50) NOT NULL,
    segundo_nombre VARCHAR(50),
    primer_apellido VARCHAR(50) NOT NULL,
    segundo_apellido VARCHAR(50),
    email VARCHAR(50) UNIQUE NOT NULL,
    foto BLOB;

    CONSTRAINT pk_cliente PRIMARY KEY (cedula) 
);

CREATE TABLE aplicacion (
    id INTEGER NOT NULL AUTO_INCREMENT,
    datos dato_empresa NOT NULL,

    CONSTRAINT pk_aplicacion PRIMARY KEY (id)
);

CREATE TABLE registro (
    id_aplicacion INTEGER NOT NULL,
    ced_cliente INTEGER NOT NULL,
    id INTEGER NOT NULL AUTO_INCREMENT,
    fechas fechas NOT NULL, 

    CONSTRAINT pk_registro PRIMARY KEY (id_aplicacion, ced_cliente, id),
    CONSTRAINT fk_registro_cliente FOREIGN KEY id_aplicacion REFERENCES cliente (cedula),
    CONSTRAINT fk_registro_aplicacion FOREIGN KEY id_aplicacion REFERENCES aplicacion (id)
);

CREATE TABLE servicio (
    id INTEGER NOT NULL AUTO_INCREMENT,
    id_aplicacion INTEGER NOT NULL,
    especificacion precio_cantidad NOT NULL,
    periodo fechas NOT NULL,

    CONSTRAINT pk_servicio PRIMARY KEY (id_aplicacion, id),
    CONSTRAINT fk_servicio_aplicacion FOREIGN KEY id_aplicacion REFERENCES aplicacion (id)
);

CREATE TABLE sector (
    id INTEGER NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,

    CONSTRAINT pk_sector PRIMARY KEY (id)
);

CREATE TABLE aliada (
    id INTEGER NOT NULL AUTO_INCREMENT,
    datos dato_empresa NOT NULL,
    id_sector NOT NULL,

    CONSTRAINT pk_aliada PRIMARY KEY (id),
    CONSTRAINT fk_aliada_sector FOREIGN KEY id_sector REFERENCES sector (id)
);

CREATE TABLE contrato (
    n_contrato INTEGER NOT NULL AUTO_INCREMENT,
    id_aplicacion INTEGER NOT NULL,
    id_aliada INTEGER NOT NULL,
    fechas fechas NOT NULL,
    id_servicio INTEGER NOT NULL,

    CONSTRAINT pk_contrato PRIMARY KEY (n_contrato, id_aliada, id_aplicacion),
    CONSTRAINT fk_contrato_aliada FOREIGN KEY id_aliada REFERENCES aliada (id),
    CONSTRAINT fk_contrato_aplicacion FOREIGN KEY id_aplicacion REFERENCES aplicacion (id)
);

CREATE TABLE ubicacion (
    id INTEGER NOT NULL AUTO_INCREMENT,
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
    CONSTRAINT fk_oficina_aplicacion FOREIGN KEY id_aplicacion REFERENCES aplicacion (id),
    CONSTRAINT fk_oficina_zona FOREIGN KEY id_zona REFERENCES ubicacion (id),
);

CREATE TABLE sucursal (
    id_aliada INTEGER NOT NULL,
    id_zona INTEGER NOT NULL,

    CONSTRAINT pk_sucursal PRIMARY KEY (id_aliada, id_zona),
    CONSTRAINT fk_sucursal_aliada FOREIGN KEY id_aliada REFERENCES aliada (id),
    CONSTRAINT fk_sucursal_zona FOREIGN KEY id_zona REFERENCES ubicacion (id),
);

CREATE TABLE direccion (
    id INTEGER NOT NULL AUTO_INCREMENT, 
    ced_cliente INTEGER NOT NULL,
    id_zona INTEGEr NOT NULL,

    CONSTRAINT pk_direccion PRIMARY KEY (ced_cliente, id, id_zona),
    CONSTRAINT fk_direccion_cliente FOREIGN KEY ced_cliente REFERENCES cliente (cedula),
    CONSTRAINT fk_direccion_zona FOREIGN KEY id_zona REFERENCES zona (cedula),
);

CREATE TABLE unidad (
    id INTEGER NOT NULL AUTO_INCREMENT,
    placa VARCHAR(50) NOT NULL UNIQUE,
    tipo VARCHAR(50) NOT NULL, 
    estatus VARCHAR(50) NOT NULL, 
    id_aplicacion_oficina INTEGER NOT NULL,
    id_zona_oficina INTEGER NOT NULL,

    CONSTRAINT pk_unidad PRIMARY KEY (id),

    CONSTRAINT fk_unidad_aplicacion_oficina FOREIGN KEY id_aplicacion_oficina
        REFERENCES oficina (id_zona),
    CONSTRAINT fk_unidad_aplicacion_zona FOREIGN KEY id_zona_oficina
        REFERENCES oficina (id_aplicacion),

    CONSTRAINT ch_tipo CHECK (tipo IN ('carro', 'camioneta', 'moto')),
    CONSTRAINT ch_tipo CHECK (tipo IN ('activo', 'en reparación'))
);

CREATE TABLE envio (
    tracking INTEGER NOT NULL AUTO_INCREMENT,
    fechas fechas NOT NULL,
    id_unidad NOT NULL,
    id_cliente_direccion NOT NULL, 
    id_zona_direccion NOT NULL, 
    id_direccion NOT NULL, 
    valoracion NOT NULL,

    CONSTRAINT pk_envio PRIMARY KEY (tracking),

    CONSTRAINT fk_envio_cliente_direccion FOREIGN KEY id_cliente_direccion
        REFERENCES direccion (ced_cliente),
    CONSTRAINT fk_envio_zona_direccion FOREIGN KEY id_zona_direccion
        REFERENCES direccion (id_zona),
);

CREATE TABLE pto_referencia (
    id tracking INTEGER NOT NULL AUTO_INCREMENT,
    descripcion VARCHAR(50) NOT NULL UNIQUE,

    CONSTRAINT pk_pto_referencia PRIMARY KEY (id)
);

CREATE TABLE pedido (
    id INTEGER NOT NULL AUTO_INCREMENT,
    fechas fechas NOT NULL,
    total INTEGER NOT NULL,
    ced_cliente NOT NULL, 
    id_aplicacion NOT NULL,
    id_aliada NOT NULL, 
    id_pto_referencia NOT NULL, 
    tracking_envio NOT NULL, 

    CONSTRAINT pk_pedido PRIMARY KEY (id),

    CONSTRAINT fk_pedido_cliente FOREIGN KEY ced_cliente REFERENCES cliente (cedula),
    CONSTRAINT fk_pedido_aplicacion FOREIGN KEY id_aplicacion REFERENCES aplicacion (id),
    CONSTRAINT fk_pedido_aliada FOREIGN KEY id_aliada REFERENCES aliada (id),
    CONSTRAINT fk_pedido_pto_referencia FOREIGN KEY id_pto_referencia REFERENCES pto_referencia (id),
    CONSTRAINT fk_pedido_envio FOREIGN KEY tracking_envio REFERENCES envio (tracking),
);

CREATE TABLE producto (
    id INTEGER NOT NULL AUTO_INCREMENT,
    id_pedido NOT NULL, 
    cod_producto NOT NULL,
    especifiacion precio_cantidad NOT NULL,
    id_sector NOT NULL,

    CONSTRAINT pk_producto PRIMARY KEY (id),
    CONSTRAINT fk_producto_pedido FOREIGN KEY id_pedido REFERENCES pedido (id),
    CONSTRAINT fk_producto_sector FOREIGN KEY id_sector REFERENCES sector (id) 
);