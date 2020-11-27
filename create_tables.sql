-- Create table SQL
CREATE TABLE ubicacion (
    id INTEGER NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    tipo VARCHAR(30) NOT NULL,
    longitud REAL,
    latitud REAL,

    CONSTRAINT pk_ubicacion PRIMARY KEY (id),
    CONSTRAINT chk_tipo CHECK (tipo IN ('Moto', 'Camioneta', 'Carro'));
);