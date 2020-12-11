--GUIA PARA SETIAR LOS BLOB:

--1) DESDE EL USUARIO SYS (TENIENDO EN CUENTA QUE EL USUARIO PRINCIPAL QUE USTEDES USAN ES SYSTEM, COMO YO), EJECUTAR EL SIGUIENTE CODIGO:

GRANT READ on DIRECTORY IMAGEN TO SYSTEM;

--2) SE CREA UNA NUEVA CARPETA LOCAL EN LA PC EN QUE SE TENGAN TODAS LAS IMAGENES .PNG .JPG etc.
-- YO CREO UNA CARPETA LLAMADA Deliveries EN C:\
-- Y SE CREA UN DIRECTORIO CON EL SIG. CODIGO

 CREATE OR REPLACE DIRECTORY imagen AS 'C:\deliveries';

 --3)POR ULTIMO, SE USA UN PROCEDIMIENTO PARA INSERTAR CADA APLICACION CON SU RESPECTIVA IMAGEN :

 create or replace PROCEDURE insertar_aplicacion (
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
   INSERT INTO APLICACION (datos, logo)
   VALUES (datos_empresa(datos_empresa.VALIDAR_NOMBRE(in_nombre), DATOS_EMPRESA.validar_RIF(in_rif)),empty_blob())
   RETURNING logo into b_lob;

   --Abrir archivo

   dbms_lob.fileopen(f_lob,dbms_lob.file_readonly);

   --Leer archivo

   dbms_lob.loadfromfile(b_lob, f_lob, dbms_lob.getlength(f_lob));

   --Cerrar archivo

   dbms_lob.fileclose(f_lob);

   commit;

END;

-- 4) SE EJECUTA ASI:

declare
    directorio VARCHAR2(4000) := 'IMAGEN';
begin
    insertar_aplicacion('Yummy','500194552','yummy.jpg',directorio);
    insertar_aplicacion('PedidosYa','402838298','pedidosya.png',directorio);
    insertar_aplicacion('Traetelo','500196283','traetelo.jpg',directorio);
    insertar_aplicacion('Rappi','306842675','rappi.png',directorio);
    insertar_aplicacion('Ubii Go','407586980','ubiigo.png',directorio);

    insertar_aplicacion('Liveri','408120348','liveri.png',directorio);
    insertar_aplicacion('Kepido','408128932','kepido.jpg',directorio);
    insertar_aplicacion('PedidosToGo','408173829','pedidostogo.jpg',directorio);
    insertar_aplicacion('Raudo','306842676','raudo.png',directorio);
    insertar_aplicacion('MiDelivery','306325676','midelivery.png',directorio);

    insertar_aplicacion('Domicilios.com','306842325','domicilios.png',directorio);
    insertar_aplicacion('Glovo','307289320','glovo.png',directorio);
    insertar_aplicacion('DeTodito','406100659','detodito.png',directorio);
    insertar_aplicacion('YoLoPido','296866959','yolopido.jpg',directorio);
    insertar_aplicacion('LaQueFaltaba','987654321','laquefaltaba.jpg',directorio);
end;

--SIGANOS EN IG PARA MAS INFORMACION @sebas.gonzz


