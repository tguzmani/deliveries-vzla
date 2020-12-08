-- Inserts

-- Preferiblemente ubicar los inserts en forma alfabética para poder ubicarlos
-- de forma más sencilla

-- Contenidos
-- Ubicacion

-- Sector
INSERT INTO SECTOR VALUES (default, 'Restaurantes');
INSERT INTO SECTOR VALUES (default, 'Farmacia');
INSERT INTO SECTOR VALUES (default, 'Bebidas');
INSERT INTO SECTOR VALUES (default, 'Mercado');
INSERT INTO SECTOR VALUES (default, 'Mensajeria');
INSERT INTO SECTOR VALUES (default, 'Calzado');
INSERT INTO SECTOR VALUES (default, 'Café & Deli');
INSERT INTO SECTOR VALUES (default, 'Tecnologia');
INSERT INTO SECTOR VALUES (default, 'Floristeria');
INSERT INTO SECTOR VALUES (default, 'Empacados');
INSERT INTO SECTOR VALUES (default, 'Juguetes');
INSERT INTO SECTOR VALUES (default, 'Comida de Animales');
INSERT INTO SECTOR VALUES (default, 'Ropa');
INSERT INTO SECTOR VALUES (default, 'Deportes');
INSERT INTO SECTOR VALUES (default, 'Perfumeria');
--CUANDO EJECUTEN ESTOS INSERTS HACEMOS EL UPDATE DE LOS SECTORES A NUESTROS ALIADOS
UPDATE ALIADA SET ID_SECTOR = 1 WHERE ID =1;
UPDATE ALIADA SET ID_SECTOR = 1 WHERE ID =2;
UPDATE ALIADA SET ID_SECTOR = 1 WHERE ID =3;
UPDATE ALIADA SET ID_SECTOR = 1 WHERE ID =4;
UPDATE ALIADA SET ID_SECTOR = 1 WHERE ID =5;
UPDATE ALIADA SET ID_SECTOR = 2 WHERE ID =6;
UPDATE ALIADA SET ID_SECTOR = 2 WHERE ID =7;
UPDATE ALIADA SET ID_SECTOR = 1 WHERE ID =8;
UPDATE ALIADA SET ID_SECTOR = 3 WHERE ID =9;
UPDATE ALIADA SET ID_SECTOR = 3 WHERE ID =10;
UPDATE ALIADA SET ID_SECTOR = 1 WHERE ID =11;
UPDATE ALIADA SET ID_SECTOR = 1 WHERE ID =12;
UPDATE ALIADA SET ID_SECTOR = 1 WHERE ID =13;
UPDATE ALIADA SET ID_SECTOR = 3 WHERE ID =14;
UPDATE ALIADA SET ID_SECTOR = 1 WHERE ID =15;

--Servicio


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
