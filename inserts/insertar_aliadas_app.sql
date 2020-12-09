CREATE OR REPLACE DIRECTORY imagen AS 'C:\deliveries';

create or replace PROCEDURE insertar_aliada_app (
    flag IN integer,
    in_nombre IN varchar2,
    in_rif IN varchar2,
    in_imagen IN varchar2,
    in_directorio IN varchar2
    )

    as

   f_lob bfile;
   b_lob blob;

BEGIN

    f_lob := bfilename(in_directorio, in_imagen);
    IF flag=1 THEN
        INSERT INTO APLICACION (datos, logo)
        VALUES (datos_empresa(datos_empresa.VALIDAR_NOMBRE(in_nombre), DATOS_EMPRESA.validar_RIF(in_rif)),empty_blob())
        RETURNING logo into b_lob;
    ELSIF flag=2 THEN
        INSERT INTO ALIADA (datos, logo)
        VALUES (datos_empresa(datos_empresa.VALIDAR_NOMBRE(in_nombre), DATOS_EMPRESA.validar_RIF(in_rif)),empty_blob())
        RETURNING logo into b_lob;
    end if;

    dbms_lob.fileopen(f_lob,dbms_lob.file_readonly);
    dbms_lob.loadfromfile(b_lob, f_lob, dbms_lob.getlength(f_lob));
    dbms_lob.fileclose(f_lob);

   commit;

END;
    
declare
    directorio VARCHAR2(4000) := 'IMAGEN';
begin
    --INSERTS DE LAS APPs DE DELIVERY
    insertar_aliada_app(1,'Yummy','500194552','yummy.jpg',directorio);
    insertar_aliada_app(1,'PedidosYa','402838298','pedidosya.png',directorio);
    insertar_aliada_app(1,'Traetelo','500196283','traetelo.jpg',directorio);
    insertar_aliada_app(1,'Rappi','306842675','rappi.png',directorio);
    insertar_aliada_app(1,'Ubii Go','407586980','ubiigo.png',directorio);

    insertar_aliada_app(1,'Liveri','408120348','liveri.png',directorio);
    insertar_aliada_app(1,'Kepido','408128932','kepido.jpg',directorio);
    insertar_aliada_app(1,'PedidosToGo','408173829','pedidostogo.jpg',directorio);
    insertar_aliada_app(1,'Raudo','306842676','raudo.png',directorio);
    insertar_aliada_app(1,'MiDelivery','306325676','midelivery.png',directorio);

    insertar_aliada_app(1,'Domicilios.com','306842325','domicilios.png',directorio);
    insertar_aliada_app(1,'Glovo','307289320','glovo.png',directorio);
    insertar_aliada_app(1,'DeTodito','406100659','detodito.png',directorio);
    insertar_aliada_app(1,'YoLoPido','296866959','yolopido.jpg',directorio);
    insertar_aliada_app(1,'LaQueFaltaba','987654321','laquefaltaba.jpg',directorio);

    --INSERTS DE LAS EMPRESAS ALIADAS
    insertar_aliada_app(2,'Mc Donalds','402838298','mcdonals.png',directorio);
    insertar_aliada_app(2,'Burger King','312497130','burgerking.png',directorio);
    insertar_aliada_app(2,'Churchs Chiken','307878991','churchschicken.jpg',directorio);
    insertar_aliada_app(2,'Arturos','002197528','arturos.png',directorio);
    insertar_aliada_app(2,'Churro Mania','296102619','churromania.png',directorio);

    insertar_aliada_app(2,'Farmatodo','00020200','farmatodo.jpg',directorio);
    insertar_aliada_app(2,'Farmahorro','000263493','farmahorro.jpg',directorio);
    insertar_aliada_app(2,'Fresh Fish','308944459','freshfish.jpg',directorio);
    insertar_aliada_app(2,'Prolicor','001708685','prolicor.jpg',directorio);
    insertar_aliada_app(2,'Pepsi','301370139','pepsi.png',directorio);

    insertar_aliada_app(2,'Lucky Lucianos','305492808','luckylucianos.jpg',directorio);
    insertar_aliada_app(2,'Full Pizza','314519492','fullpizza.png',directorio);
    insertar_aliada_app(2,'Subway','307307536','subway.png',directorio);
    insertar_aliada_app(2,'Batys Merengadas','404808760','batys.jpg',directorio);
    insertar_aliada_app(2,'Krispy Donuts','312358785','krispydonuts.png',directorio);
end;
