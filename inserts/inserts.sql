-- Inserts

--Registro
INSERT INTO REGISTRO VALUES (1, 6035694, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (1, 13749571, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (1, 5263491, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (1, 8052968, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (2, 11914781, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (2, 14850119, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (2, 9234140, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (2, 11192772, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (3, 7727507, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (3, 8843392, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (3, 13908954, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (3, 13659465, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (4, 12516807, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (4, 8306312, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (4, 8742813, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (4, 6035694, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (5, 13749571, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (5, 5263491, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (5, 8052968, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (5, 11914781, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (6, 14850119, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (6, 9234140, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (6, 11192772, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (6, 7727507, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (7, 8843392, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (7, 13908954, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (7, 13659465, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (7, 12516807, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (8, 8306312, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (8, 8742813, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (8, 6035694, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (8, 13749571, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (9, 5263491, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (9, 8052968, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (9, 11914781, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (9, 14850119, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (10, 9234140, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (10, 11192772, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (10, 7727507, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (10, 8843392, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (11, 13908954, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (11, 13659465, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (11, 12516807, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (11, 8306312, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (12, 8742813, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (12, 6035694, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (12, 13749571, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (12, 5263491, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (13, 8052968, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (13, 11914781, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (13, 14850119, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (13, 9234140, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (14, 11192772, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (14, 7727507, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (14, 8843392, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (14, 13908954, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (15, 13659465, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (15, 12516807, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (15, 8306312, default, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (15, 8742813, default, get_random_date(current_date));

-- Sector
INSERT INTO SECTOR VALUES (default, 'Restaurantes');
INSERT INTO SECTOR VALUES (default, 'Farmacia');
INSERT INTO SECTOR VALUES (default, 'Bebidas');
INSERT INTO SECTOR VALUES (default, 'Mercado');
INSERT INTO SECTOR VALUES (default, 'Mensajeria');
INSERT INTO SECTOR VALUES (default, 'Calzado');
INSERT INTO SECTOR VALUES (default, 'Café & Deli');
INSERT INTO SECTOR VALUES (default, 'Tecnología');
INSERT INTO SECTOR VALUES (default, 'Floristería');
INSERT INTO SECTOR VALUES (default, 'Empacados');
INSERT INTO SECTOR VALUES (default, 'Juguetes');
INSERT INTO SECTOR VALUES (default, 'Comida de Animales');
INSERT INTO SECTOR VALUES (default, 'Ropa');
INSERT INTO SECTOR VALUES (default, 'Deportes');
INSERT INTO SECTOR VALUES (default, 'Perfumería');

--CUANDO EJECUTEN ESTOS INSERTS HACEMOS EL UPDATE DE LOS SECTORES A NUESTROS ALIADOS
UPDATE ALIADA SET ID_SECTOR = 1 WHERE ID = 1;
UPDATE ALIADA SET ID_SECTOR = 1 WHERE ID = 2;
UPDATE ALIADA SET ID_SECTOR = 1 WHERE ID = 3;
UPDATE ALIADA SET ID_SECTOR = 1 WHERE ID = 4;
UPDATE ALIADA SET ID_SECTOR = 1 WHERE ID = 5;
UPDATE ALIADA SET ID_SECTOR = 2 WHERE ID = 6;
UPDATE ALIADA SET ID_SECTOR = 2 WHERE ID = 7;
UPDATE ALIADA SET ID_SECTOR = 1 WHERE ID = 8;
UPDATE ALIADA SET ID_SECTOR = 3 WHERE ID = 9;
UPDATE ALIADA SET ID_SECTOR = 3 WHERE ID = 10;
UPDATE ALIADA SET ID_SECTOR = 1 WHERE ID = 11;
UPDATE ALIADA SET ID_SECTOR = 1 WHERE ID = 12;
UPDATE ALIADA SET ID_SECTOR = 1 WHERE ID = 13;
UPDATE ALIADA SET ID_SECTOR = 3 WHERE ID = 14;
UPDATE ALIADA SET ID_SECTOR = 1 WHERE ID = 15;

--Servicio
INSERT INTO SERVICIO VALUES (default, 1, PRECIO_CANTIDAD(PRECIO_CANTIDAD.VALIDAR_CANTIDAD(100),
    PRECIO_CANTIDAD.VALIDAR_PRECIO(300)), 'trimestral');
INSERT INTO SERVICIO VALUES (default, 1, PRECIO_CANTIDAD(PRECIO_CANTIDAD.VALIDAR_CANTIDAD(50),
    PRECIO_CANTIDAD.VALIDAR_PRECIO(150)), 'mensual');
INSERT INTO SERVICIO VALUES (default, 2, PRECIO_CANTIDAD(PRECIO_CANTIDAD.VALIDAR_CANTIDAD(200),
    PRECIO_CANTIDAD.VALIDAR_PRECIO(200)), 'trimestral');
INSERT INTO SERVICIO VALUES (default, 2, PRECIO_CANTIDAD(PRECIO_CANTIDAD.VALIDAR_CANTIDAD(1500),
    PRECIO_CANTIDAD.VALIDAR_PRECIO(500)), 'anual');
INSERT INTO SERVICIO VALUES (default, 3, PRECIO_CANTIDAD(PRECIO_CANTIDAD.VALIDAR_CANTIDAD(100),
    PRECIO_CANTIDAD.VALIDAR_PRECIO(200)), 'mensual');
INSERT INTO SERVICIO VALUES (default, 3, PRECIO_CANTIDAD(PRECIO_CANTIDAD.VALIDAR_CANTIDAD(500),
    PRECIO_CANTIDAD.VALIDAR_PRECIO(500)), 'trimestral');
INSERT INTO SERVICIO VALUES (default, 4, PRECIO_CANTIDAD(PRECIO_CANTIDAD.VALIDAR_CANTIDAD(100),
    PRECIO_CANTIDAD.VALIDAR_PRECIO(100)), 'mensual');
INSERT INTO SERVICIO VALUES (default, 4, PRECIO_CANTIDAD(PRECIO_CANTIDAD.VALIDAR_CANTIDAD(200),
    PRECIO_CANTIDAD.VALIDAR_PRECIO(150)), 'mensual');
INSERT INTO SERVICIO VALUES (default, 5, PRECIO_CANTIDAD(PRECIO_CANTIDAD.VALIDAR_CANTIDAD(200),
    PRECIO_CANTIDAD.VALIDAR_PRECIO(250)), 'mensual');
INSERT INTO SERVICIO VALUES (default, 5, PRECIO_CANTIDAD(PRECIO_CANTIDAD.VALIDAR_CANTIDAD(2000),
    PRECIO_CANTIDAD.VALIDAR_PRECIO(1000)), 'anual');
INSERT INTO SERVICIO VALUES (default, 6, PRECIO_CANTIDAD(PRECIO_CANTIDAD.VALIDAR_CANTIDAD(400),
    PRECIO_CANTIDAD.VALIDAR_PRECIO(500)), 'trimestral');
INSERT INTO SERVICIO VALUES (default, 7, PRECIO_CANTIDAD(PRECIO_CANTIDAD.VALIDAR_CANTIDAD(800),
    PRECIO_CANTIDAD.VALIDAR_PRECIO(1000)), 'anual');
INSERT INTO SERVICIO VALUES (default, 8, PRECIO_CANTIDAD(PRECIO_CANTIDAD.VALIDAR_CANTIDAD(75),
    PRECIO_CANTIDAD.VALIDAR_PRECIO(150)), 'mensual');
INSERT INTO SERVICIO VALUES (default, 9, PRECIO_CANTIDAD(PRECIO_CANTIDAD.VALIDAR_CANTIDAD(80),
    PRECIO_CANTIDAD.VALIDAR_PRECIO(100)), 'mensual');
INSERT INTO SERVICIO VALUES (default, 10, PRECIO_CANTIDAD(PRECIO_CANTIDAD.VALIDAR_CANTIDAD(300),
    PRECIO_CANTIDAD.VALIDAR_PRECIO(400)), 'trimestral');
INSERT INTO SERVICIO VALUES (default, 11, PRECIO_CANTIDAD(PRECIO_CANTIDAD.VALIDAR_CANTIDAD(200),
    PRECIO_CANTIDAD.VALIDAR_PRECIO(300)), 'mensual');
INSERT INTO SERVICIO VALUES (default, 12, PRECIO_CANTIDAD(PRECIO_CANTIDAD.VALIDAR_CANTIDAD(100),
    PRECIO_CANTIDAD.VALIDAR_PRECIO(150)), 'mensual');
INSERT INTO SERVICIO VALUES (default, 13, PRECIO_CANTIDAD(PRECIO_CANTIDAD.VALIDAR_CANTIDAD(75),
    PRECIO_CANTIDAD.VALIDAR_PRECIO(100)), 'mensual');
INSERT INTO SERVICIO VALUES (default, 14, PRECIO_CANTIDAD(PRECIO_CANTIDAD.VALIDAR_CANTIDAD(450),
    PRECIO_CANTIDAD.VALIDAR_PRECIO(450)), 'trimestral');
INSERT INTO SERVICIO VALUES (default, 15, PRECIO_CANTIDAD(PRECIO_CANTIDAD.VALIDAR_CANTIDAD(500),
    PRECIO_CANTIDAD.VALIDAR_PRECIO(600)), 'anual');

-- Ubicacion
INSERT INTO UBICACION VALUES (default, 'Distrito Capital', 'estado', default, default, default);
INSERT INTO UBICACION VALUES (default, 'Miranda', 'estado', default, default, default);
INSERT INTO UBICACION VALUES (default, 'La Guaira', 'estado', default, default, default);
INSERT INTO UBICACION VALUES (default, 'Libertador', 'municipio', default, default, 1);
INSERT INTO UBICACION VALUES (default, 'El Hatillo', 'municipio', default, default, 2);
INSERT INTO UBICACION VALUES (default, 'Chacao', 'municipio', default, default, 2);
INSERT INTO UBICACION VALUES (default, 'Baruta', 'municipio', default, default, 2);
INSERT INTO UBICACION VALUES (default, 'Sucre', 'municipio', default, default, 2);
INSERT INTO UBICACION VALUES (default, 'Vargas', 'municipio', default, default, 3);
INSERT INTO UBICACION VALUES (default, 'Altamira', 'zona', default, default,6);
INSERT INTO UBICACION VALUES (default, 'Chacao', 'zona', default, default,6);
INSERT INTO UBICACION VALUES (default, 'Chacaito', 'zona', default, default,6);
INSERT INTO UBICACION VALUES (default, 'La Castellana', 'zona', default, default,6);
INSERT INTO UBICACION VALUES (default, 'Las Mercedes', 'zona', default, default,7);
INSERT INTO UBICACION VALUES (default, 'Los Dos Caminos', 'zona', default, default,8);
INSERT INTO UBICACION VALUES (default, 'Los Palos Grandes', 'zona', default, default,6);
INSERT INTO UBICACION VALUES (default, 'San Bernardino', 'zona', default, default,4);
INSERT INTO UBICACION VALUES (default, 'Avenida Baralt', 'zona', default, default,4);
INSERT INTO UBICACION VALUES (default, 'Avenida Victoria', 'zona', default, default,4);
INSERT INTO UBICACION VALUES (default, 'La Trinidad', 'zona', default, default,7);
INSERT INTO UBICACION VALUES (default, 'Prados del Este', 'zona', default, default,7);
INSERT INTO UBICACION VALUES (default, 'Catia la Mar', 'zona', default, default,9);
INSERT INTO UBICACION VALUES (default, 'Caraballeda', 'zona', default, default,9);
INSERT INTO UBICACION VALUES (default, 'Macuto', 'zona', default, default,9);

--reiniciador de secuencia
--alter table *nombre tabla*
--modify  id generated always as identity restart start with 1;