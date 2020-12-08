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