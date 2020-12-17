-- Inserts

--Ejecutar archivos para insertar aplicaciones y aliadas

--Ejecutar Archivo para insertar clientes

-- Registro
INSERT INTO REGISTRO VALUES (1, 6035694, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (1, 13749571, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (1, 5263491, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (1, 8052968, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (2, 11914781, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (2, 14850119, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (2, 9234140, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (3, 8843392, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (3, 13908954, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (4, 12516807, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (4, 8306312, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (5, 5263491, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (5, 11914781, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (6, 11192772, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (6, 7727507, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (7, 13908954, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (7, 13659465, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (8, 8306312, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (8, 13749571, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (9, 11914781, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (9, 14850119, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (10, 11192772, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (10, 8843392, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (11, 12516807, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (12, 8742813, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (12, 6035694, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (13, 8052968, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (13, 9234140, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (14, 13908954, get_random_date(current_date));
INSERT INTO REGISTRO VALUES (15, 13659465, get_random_date(current_date));

--Servicio
INSERT INTO SERVICIO VALUES (default, 1, PRECIO_CANTIDAD(PRECIO_CANTIDAD.VALIDAR_CANTIDAD(100),
    PRECIO_CANTIDAD.VALIDAR_PRECIO(300)), 'trimestral', fechas(TO_DATE('2020-04-06', 'YYYY-MM-DD'),
        TO_DATE('2020-12-31', 'YYYY-MM-DD')));
INSERT INTO SERVICIO VALUES (default, 1, PRECIO_CANTIDAD(PRECIO_CANTIDAD.VALIDAR_CANTIDAD(50),
    PRECIO_CANTIDAD.VALIDAR_PRECIO(150)), 'mensual', fechas(TO_DATE('2020-04-01', 'YYYY-MM-DD'),
        TO_DATE('2020-12-31', 'YYYY-MM-DD')));
INSERT INTO SERVICIO VALUES (default, 2, PRECIO_CANTIDAD(PRECIO_CANTIDAD.VALIDAR_CANTIDAD(200),
    PRECIO_CANTIDAD.VALIDAR_PRECIO(200)), 'trimestral', fechas(TO_DATE('2020-05-01', 'YYYY-MM-DD'),
        TO_DATE('2020-11-30', 'YYYY-MM-DD')));
INSERT INTO SERVICIO VALUES (default, 2, PRECIO_CANTIDAD(PRECIO_CANTIDAD.VALIDAR_CANTIDAD(1500),
    PRECIO_CANTIDAD.VALIDAR_PRECIO(500)), 'anual', fechas(TO_DATE('2020-04-06', 'YYYY-MM-DD'),
        TO_DATE('2020-11-30', 'YYYY-MM-DD')));
INSERT INTO SERVICIO VALUES (default, 3, PRECIO_CANTIDAD(PRECIO_CANTIDAD.VALIDAR_CANTIDAD(100),
    PRECIO_CANTIDAD.VALIDAR_PRECIO(200)), 'mensual', fechas(TO_DATE('2020-11-01', 'YYYY-MM-DD'),
        TO_DATE('2021-11-01', 'YYYY-MM-DD')));
INSERT INTO SERVICIO VALUES (default, 3, PRECIO_CANTIDAD(PRECIO_CANTIDAD.VALIDAR_CANTIDAD(500),
    PRECIO_CANTIDAD.VALIDAR_PRECIO(500)), 'trimestral', fechas(TO_DATE('2020-04-06', 'YYYY-MM-DD'),
        TO_DATE('2020-11-01', 'YYYY-MM-DD')));
INSERT INTO SERVICIO VALUES (default, 4, PRECIO_CANTIDAD(PRECIO_CANTIDAD.VALIDAR_CANTIDAD(100),
    PRECIO_CANTIDAD.VALIDAR_PRECIO(100)), 'mensual', fechas(TO_DATE('2020-05-01', 'YYYY-MM-DD'),
        TO_DATE('2020-09-30', 'YYYY-MM-DD')));
INSERT INTO SERVICIO VALUES (default, 4, PRECIO_CANTIDAD(PRECIO_CANTIDAD.VALIDAR_CANTIDAD(200),
    PRECIO_CANTIDAD.VALIDAR_PRECIO(150)), 'mensual', fechas(TO_DATE('2020-04-01', 'YYYY-MM-DD'),
        TO_DATE('2020-05-01', 'YYYY-MM-DD')));
INSERT INTO SERVICIO VALUES (default, 5, PRECIO_CANTIDAD(PRECIO_CANTIDAD.VALIDAR_CANTIDAD(200),
    PRECIO_CANTIDAD.VALIDAR_PRECIO(250)), 'mensual', fechas(TO_DATE('2020-08-01', 'YYYY-MM-DD'),
        TO_DATE('2020-11-30', 'YYYY-MM-DD')));
INSERT INTO SERVICIO VALUES (default, 5, PRECIO_CANTIDAD(PRECIO_CANTIDAD.VALIDAR_CANTIDAD(2000),
    PRECIO_CANTIDAD.VALIDAR_PRECIO(1000)), 'anual', fechas(TO_DATE('2020-04-01', 'YYYY-MM-DD'),
        TO_DATE('2020-04-25', 'YYYY-MM-DD')));
INSERT INTO SERVICIO VALUES (default, 6, PRECIO_CANTIDAD(PRECIO_CANTIDAD.VALIDAR_CANTIDAD(400),
    PRECIO_CANTIDAD.VALIDAR_PRECIO(500)), 'trimestral', fechas(TO_DATE('2020-11-01', 'YYYY-MM-DD'),
        TO_DATE('2020-12-31', 'YYYY-MM-DD')));
INSERT INTO SERVICIO VALUES (default, 7, PRECIO_CANTIDAD(PRECIO_CANTIDAD.VALIDAR_CANTIDAD(800),
    PRECIO_CANTIDAD.VALIDAR_PRECIO(1000)), 'anual', fechas(TO_DATE('2020-12-01', 'YYYY-MM-DD'),
        TO_DATE('2021-12-01', 'YYYY-MM-DD')));
INSERT INTO SERVICIO VALUES (default, 8, PRECIO_CANTIDAD(PRECIO_CANTIDAD.VALIDAR_CANTIDAD(75),
    PRECIO_CANTIDAD.VALIDAR_PRECIO(150)), 'mensual', fechas(TO_DATE('2020-08-01', 'YYYY-MM-DD'),
        TO_DATE('2020-12-31', 'YYYY-MM-DD')));
INSERT INTO SERVICIO VALUES (default, 9, PRECIO_CANTIDAD(PRECIO_CANTIDAD.VALIDAR_CANTIDAD(80),
    PRECIO_CANTIDAD.VALIDAR_PRECIO(100)), 'mensual', fechas(TO_DATE('2020-10-05', 'YYYY-MM-DD'),
        TO_DATE('2020-10-31', 'YYYY-MM-DD')));
INSERT INTO SERVICIO VALUES (default, 10, PRECIO_CANTIDAD(PRECIO_CANTIDAD.VALIDAR_CANTIDAD(300),
    PRECIO_CANTIDAD.VALIDAR_PRECIO(400)), 'trimestral', fechas(TO_DATE('2020-04-06', 'YYYY-MM-DD'),
        TO_DATE('2020-12-31', 'YYYY-MM-DD')));
INSERT INTO SERVICIO VALUES (default, 11, PRECIO_CANTIDAD(PRECIO_CANTIDAD.VALIDAR_CANTIDAD(200),
    PRECIO_CANTIDAD.VALIDAR_PRECIO(300)), 'mensual', fechas(TO_DATE('2020-04-06', 'YYYY-MM-DD'),
        TO_DATE('2020-12-31', 'YYYY-MM-DD')));
INSERT INTO SERVICIO VALUES (default, 12, PRECIO_CANTIDAD(PRECIO_CANTIDAD.VALIDAR_CANTIDAD(100),
    PRECIO_CANTIDAD.VALIDAR_PRECIO(150)), 'mensual', fechas(TO_DATE('2020-05-06', 'YYYY-MM-DD'),
        TO_DATE('2020-12-31', 'YYYY-MM-DD')));
INSERT INTO SERVICIO VALUES (default, 13, PRECIO_CANTIDAD(PRECIO_CANTIDAD.VALIDAR_CANTIDAD(75),
    PRECIO_CANTIDAD.VALIDAR_PRECIO(100)), 'mensual', fechas(TO_DATE('2020-03-13', 'YYYY-MM-DD'),
        TO_DATE('2020-06-13', 'YYYY-MM-DD')));
INSERT INTO SERVICIO VALUES (default, 14, PRECIO_CANTIDAD(PRECIO_CANTIDAD.VALIDAR_CANTIDAD(450),
    PRECIO_CANTIDAD.VALIDAR_PRECIO(450)), 'trimestral', fechas(TO_DATE('2020-11-05', 'YYYY-MM-DD'),
        TO_DATE('2021-06-25', 'YYYY-MM-DD')));
INSERT INTO SERVICIO VALUES (default, 15, PRECIO_CANTIDAD(PRECIO_CANTIDAD.VALIDAR_CANTIDAD(500),
    PRECIO_CANTIDAD.VALIDAR_PRECIO(600)), 'anual', fechas(TO_DATE('2020-12-01', 'YYYY-MM-DD'),
        TO_DATE('2020-06-01', 'YYYY-MM-DD')));

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

--Estos Updates deben ejecutarlos despues de haber insertado los sectores para ponerle el sector a las aliadas
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

-- Contrato
INSERT INTO contrato VALUES (default, 1, 2, fechas(TO_DATE('2020-07-06', 'YYYY-MM-DD'), TO_DATE('2020-10-06', 'YYYY-MM-DD')), 1, 1);
INSERT INTO contrato VALUES (default, 1, 11, fechas(TO_DATE('2020-02-16', 'YYYY-MM-DD'), TO_DATE('2020-05-16', 'YYYY-MM-DD')), 1, 1);
INSERT INTO contrato VALUES (default, 2, 9, fechas(TO_DATE('2020-10-04', 'YYYY-MM-DD'), TO_DATE('2020-11-04', 'YYYY-MM-DD')), 3, 2);
INSERT INTO contrato VALUES (default, 2, 1, fechas(TO_DATE('2020-04-07', 'YYYY-MM-DD'), TO_DATE('2021-04-07', 'YYYY-MM-DD')), 4, 2);
INSERT INTO contrato VALUES (default, 3, 12, fechas(TO_DATE('2020-11-21', 'YYYY-MM-DD'), TO_DATE('2020-12-21', 'YYYY-MM-DD')), 5, 3);
INSERT INTO contrato VALUES (default, 3, 5, fechas(TO_DATE('2020-05-07', 'YYYY-MM-DD'), TO_DATE('2020-08-07', 'YYYY-MM-DD')), 6, 3);
INSERT INTO contrato VALUES (default, 4, 4, fechas(TO_DATE('2020-08-27', 'YYYY-MM-DD'), TO_DATE('2020-09-27', 'YYYY-MM-DD')), 7, 4);
INSERT INTO contrato VALUES (default, 4, 6, fechas(TO_DATE('2020-04-09', 'YYYY-MM-DD'), TO_DATE('2020-05-09', 'YYYY-MM-DD')), 8, 4);
INSERT INTO contrato VALUES (default, 5, 3, fechas(TO_DATE('2020-11-20', 'YYYY-MM-DD'), TO_DATE('2020-12-20', 'YYYY-MM-DD')), 9, 5);
INSERT INTO contrato VALUES (default, 5, 2, fechas(TO_DATE('2020-08-8', 'YYYY-MM-DD'), TO_DATE('2020-09-8', 'YYYY-MM-DD')), 9, 5);
INSERT INTO contrato VALUES (default, 5, 13, fechas(TO_DATE('2020-04-26', 'YYYY-MM-DD'), TO_DATE('2021-04-26', 'YYYY-MM-DD')), 10, 5);
INSERT INTO contrato VALUES (default, 8, 7, fechas(TO_DATE('2020-08-25', 'YYYY-MM-DD'), TO_DATE('2020-09-25', 'YYYY-MM-DD')), 13, 8);
INSERT INTO contrato VALUES (default, 9, 15, fechas(TO_DATE('2020-10-17', 'YYYY-MM-DD'), TO_DATE('2020-11-17', 'YYYY-MM-DD')), 14, 9);
INSERT INTO contrato VALUES (default, 10, 9, fechas(TO_DATE('2020-10-23', 'YYYY-MM-DD'), TO_DATE('2020-01-23', 'YYYY-MM-DD')), 15, 10);
INSERT INTO contrato VALUES (default, 13, 6, fechas(TO_DATE('2020-03-15', 'YYYY-MM-DD'), TO_DATE('2020-04-15', 'YYYY-MM-DD')), 18, 13);
INSERT INTO contrato VALUES (default, 1, 2, fechas(TO_DATE('2020-10-07', 'YYYY-MM-DD'), TO_DATE('2020-11-07', 'YYYY-MM-DD')), 2, 1);

-- Ubicacion
INSERT INTO UBICACION VALUES (default, 'Distrito Capital', 'estado', 10.50071475276337, -66.9511029846569, default);
INSERT INTO UBICACION VALUES (default, 'Miranda', 'estado', 10.275709860107188, -66.42898801626855, default);
INSERT INTO UBICACION VALUES (default, 'La Guaira', 'estado', 10.616607794151536, -66.93314690371663, default);
INSERT INTO UBICACION VALUES (default, 'Libertador', 'municipio', 10.502305479593335, -66.95148466218333, 1);
INSERT INTO UBICACION VALUES (default, 'El Hatillo', 'municipio', 10.42467449286987, -66.82523422284868, 2);
INSERT INTO UBICACION VALUES (default, 'Chacao', 'municipio', 10.494648052846701, -66.8550803794353, 2);
INSERT INTO UBICACION VALUES (default, 'Baruta', 'municipio', 10.435469137523633, -66.87448588618497, 2);
INSERT INTO UBICACION VALUES (default, 'Sucre', 'municipio', 10.512271363522597, -66.78401629345602, 2);
INSERT INTO UBICACION VALUES (default, 'Vargas', 'municipio', 10.617282684894848, -66.9269670943103, 3);
INSERT INTO UBICACION VALUES (default, 'Altamira', 'zona', 10.509722952107035, -66.85184684519079,6);
INSERT INTO UBICACION VALUES (default, 'Chacao', 'zona', 10.494648052846701, -66.8550803794353, 6);
INSERT INTO UBICACION VALUES (default, 'Chacaito', 'zona', 10.492872589807865, -66.86731091466498, 6);
INSERT INTO UBICACION VALUES (default, 'La Castellana', 'zona', 10.506892245049915, -66.85579505675713, 6);
INSERT INTO UBICACION VALUES (default, 'Las Mercedes', 'zona', 10.482630760860538, -66.86104527457431, 7);
INSERT INTO UBICACION VALUES (default, 'Los Dos Caminos', 'zona', 10.501331217200084, -66.83224337638781, 8);
INSERT INTO UBICACION VALUES (default, 'Los Palos Grandes', 'zona', 10.507249206930775, -66.84287282441545, 6);
INSERT INTO UBICACION VALUES (default, 'San Bernardino', 'zona', 10.51535615951692, -66.90134834044454, 4);
INSERT INTO UBICACION VALUES (default, 'Avenida Baralt', 'zona', 10.516816505005062, -66.91573571688004, 4);
INSERT INTO UBICACION VALUES (default, 'Avenida Victoria', 'zona', 10.48666244401694, -66.90133777179757, 4);
INSERT INTO UBICACION VALUES (default, 'La Trinidad', 'zona', 10.434606478526481, -66.87088099736482, 7);
INSERT INTO UBICACION VALUES (default, 'Prados del Este', 'zona', 10.449036238696191, -66.88687882456107, 7);
INSERT INTO UBICACION VALUES (default, 'Catia la Mar', 'zona', 10.599081805002227, -67.04842898578981, 9);
INSERT INTO UBICACION VALUES (default, 'Caraballeda', 'zona', 10.624167217150097, -66.85092083117203, 9);
INSERT INTO UBICACION VALUES (default, 'Macuto', 'zona', 10.616764438209742, -66.8960680472307, 9);


-- Oficina
INSERT INTO oficina VALUES (1, 20);
INSERT INTO oficina VALUES (1, 11);
INSERT INTO oficina VALUES (2, 21);
INSERT INTO oficina VALUES (3, 24);
INSERT INTO oficina VALUES (3, 18);
INSERT INTO oficina VALUES (4, 11);
INSERT INTO oficina VALUES (4, 19);
INSERT INTO oficina VALUES (5, 11);
INSERT INTO oficina VALUES (5, 12);
INSERT INTO oficina VALUES (6, 11);
INSERT INTO oficina VALUES (7, 22);
INSERT INTO oficina VALUES (7, 21);
INSERT INTO oficina VALUES (8, 12);
INSERT INTO oficina VALUES (8, 13);
INSERT INTO oficina VALUES (8, 22);
INSERT INTO oficina VALUES (9, 12);
INSERT INTO oficina VALUES (9, 11);
INSERT INTO oficina VALUES (9, 21);
INSERT INTO oficina VALUES (10, 18);
INSERT INTO oficina VALUES (11, 12);
INSERT INTO oficina VALUES (11, 17);
INSERT INTO oficina VALUES (12, 19);
INSERT INTO oficina VALUES (13, 21);
INSERT INTO oficina VALUES (13, 19);
INSERT INTO oficina VALUES (14, 23);
INSERT INTO oficina VALUES (14, 18);
INSERT INTO oficina VALUES (15, 24);
INSERT INTO oficina VALUES (15, 14);

-- Sucursal
INSERT INTO sucursal VALUES (1, 14);
INSERT INTO sucursal VALUES (1, 11);
INSERT INTO sucursal VALUES (2, 16);
INSERT INTO sucursal VALUES (2, 14);
INSERT INTO sucursal VALUES (2, 15);
INSERT INTO sucursal VALUES (3, 13);
INSERT INTO sucursal VALUES (4, 21);
INSERT INTO sucursal VALUES (5, 16);
INSERT INTO sucursal VALUES (5, 15);
INSERT INTO sucursal VALUES (6, 17);
INSERT INTO sucursal VALUES (6, 19);
INSERT INTO sucursal VALUES (7, 21);
INSERT INTO sucursal VALUES (8, 14);
INSERT INTO sucursal VALUES (8, 13);
INSERT INTO sucursal VALUES (9, 13);
INSERT INTO sucursal VALUES (9, 10);
INSERT INTO sucursal VALUES (10, 12);
INSERT INTO sucursal VALUES (11, 12);
INSERT INTO sucursal VALUES (11, 24);
INSERT INTO sucursal VALUES (11, 17);
INSERT INTO sucursal VALUES (11, 23);
INSERT INTO sucursal VALUES (12, 19);
INSERT INTO sucursal VALUES (12, 17);
INSERT INTO sucursal VALUES (13, 13);
INSERT INTO sucursal VALUES (13, 24);
INSERT INTO sucursal VALUES (13, 15);
INSERT INTO sucursal VALUES (14, 13);
INSERT INTO sucursal VALUES (14, 21);
INSERT INTO sucursal VALUES (15, 20);
INSERT INTO sucursal VALUES (15, 10);

-- Puntos de Referencia
INSERT INTO PTO_REFERENCIA VALUES (DEFAULT,'Plaza Francia');
INSERT INTO PTO_REFERENCIA VALUES (DEFAULT,'Centro Sambil Caracas');
INSERT INTO PTO_REFERENCIA VALUES (DEFAULT,'Avenida El Parque');
INSERT INTO PTO_REFERENCIA VALUES (DEFAULT,'Centro Deportivo Eugenio Mendoza');
INSERT INTO PTO_REFERENCIA VALUES (DEFAULT,'Cerca del Tolón');
INSERT INTO PTO_REFERENCIA VALUES (DEFAULT,'Transversal 5');
INSERT INTO PTO_REFERENCIA VALUES (DEFAULT,'Cerca del Excelsior Gama');
INSERT INTO PTO_REFERENCIA VALUES (DEFAULT,'Crema Paraíso');
INSERT INTO PTO_REFERENCIA VALUES (DEFAULT,'Frente al Ministerio');
INSERT INTO PTO_REFERENCIA VALUES (DEFAULT,'Calle Chile');
INSERT INTO PTO_REFERENCIA VALUES (DEFAULT,'Cerca del Polideportivo');
INSERT INTO PTO_REFERENCIA VALUES (DEFAULT,'Por el Galerías Prados del Este');
INSERT INTO PTO_REFERENCIA VALUES (DEFAULT,'Funeraria San Antonio');
INSERT INTO PTO_REFERENCIA VALUES (DEFAULT,'Av. La Costanera');
INSERT INTO PTO_REFERENCIA VALUES (DEFAULT,'Plaza Las Palomas');
INSERT INTO PTO_REFERENCIA VALUES (DEFAULT,'Hotel Ávila');
INSERT INTO PTO_REFERENCIA VALUES (DEFAULT,'Multicentro Empresarial');
INSERT INTO PTO_REFERENCIA VALUES (DEFAULT,'En la estación de Metro');
INSERT INTO PTO_REFERENCIA VALUES (DEFAULT,'Cerca del colegio Británico');
INSERT INTO PTO_REFERENCIA VALUES (DEFAULT,'Bomba de gasolina');

-- Direcciones
INSERT INTO DIRECCION VALUES (DEFAULT,6035694,10,1);
INSERT INTO DIRECCION VALUES (DEFAULT,13749571,11,2);
INSERT INTO DIRECCION VALUES (DEFAULT,5263491,12,3);
INSERT INTO DIRECCION VALUES (DEFAULT,8052968,13,4);
INSERT INTO DIRECCION VALUES (DEFAULT,11914781,14,5);
INSERT INTO DIRECCION VALUES (DEFAULT,14850119,15,6);
INSERT INTO DIRECCION VALUES (DEFAULT,9234140,16,7);
INSERT INTO DIRECCION VALUES (DEFAULT,11192772,17,8);
INSERT INTO DIRECCION VALUES (DEFAULT,7727507,18,9);
INSERT INTO DIRECCION VALUES (DEFAULT,8843392,19,10);
INSERT INTO DIRECCION VALUES (DEFAULT,13908954,20,11);
INSERT INTO DIRECCION VALUES (DEFAULT,13659465,21,12);
INSERT INTO DIRECCION VALUES (DEFAULT,12516807,22,13);
INSERT INTO DIRECCION VALUES (DEFAULT,8306312,23,14);
INSERT INTO DIRECCION VALUES (DEFAULT,8742813,24,15);
INSERT INTO DIRECCION VALUES (DEFAULT,6035694,17,16);
INSERT INTO DIRECCION VALUES (DEFAULT,11192772,11,17);
INSERT INTO DIRECCION VALUES (DEFAULT,12516807,15,18);
INSERT INTO DIRECCION VALUES (DEFAULT,8742813,13,19);
INSERT INTO DIRECCION VALUES (DEFAULT,7727507,10,20);

-- Unidades
CREATE OR REPLACE PROCEDURE insertar_unidades
IS
    office OFICINA%rowtype;
    CURSOR c1 IS
        SELECT * INTO office
        FROM OFICINA;
BEGIN
    OPEN c1;
    LOOP
        FETCH c1 INTO office;
        EXIT WHEN c1%NOTFOUND;
        INSERT INTO UNIDAD VALUES (DEFAULT,get_random_placa(1),'camioneta','activo',office.ID_APLICACION,office.ID_ZONA,NULL);
        INSERT INTO UNIDAD VALUES (DEFAULT,get_random_placa(1),'carro','activo',office.ID_APLICACION,office.ID_ZONA,NULL);
        INSERT INTO UNIDAD VALUES (DEFAULT,get_random_placa(2),'moto','activo',office.ID_APLICACION,office.ID_ZONA,NULL);
        INSERT INTO UNIDAD VALUES (DEFAULT,get_random_placa(2),'moto','activo',office.ID_APLICACION,office.ID_ZONA,NULL);
        INSERT INTO UNIDAD VALUES (DEFAULT,get_random_placa(2),'moto','activo',office.ID_APLICACION,office.ID_ZONA,NULL);
    END LOOP;
    CLOSE c1;
END;

CALL insertar_unidades();

--reiniciador de secuencia
--alter table *nombre tabla*
--modify  id generated always as identity restart start with 1;
