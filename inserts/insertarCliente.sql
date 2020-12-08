GRANT READ ON DIRECTORY IMAGEN TO SYSTEM;

CREATE OR REPLACE DIRECTORY imagen AS 'C:\Users\Tomas\Projects\bases2';

CREATE OR REPLACE PROCEDURE insertarCliente (
    in_nombre IN varchar2,
    in_rif IN varchar2,
    in_imagen IN varchar2,
    in_directorio IN varchar2
) AS

    f_lob bfile;
    b_lob blob;

BEGIN
    f_lob := bfilename(in_directorio, in_imagen); 

    INSERT INTO cliente (datos, logo)
    VALUES (datos_empresa(datos_empresa.VALIDAR_NOMBRE(in_nombre), DATOS_EMPRESA.validar_RIF(in_rif)), empty_blob())
    RETURNING logo into b_lob;  

    dbms_lob.fileopen(f_lob,dbms_lob.file_readonly);
    dbms_lob.loadfromfile(b_lob, f_lob, dbms_lob.getlength(f_lob));
    dbms_lob.fileclose(f_lob);
    commit;
END;

DECLARE
    directorio VARCHAR2(4000) := 'IMAGEN';
BEGIN
    insertarCliente(6035694,'Camila', 'María', 'Jung', 'Xu', 'camilajung@deliveries.app', '01.jpg', directorio);
    insertarCliente(13749571,'Eduardo', 'Andrés', 'Guerrero', 'Sucre', 'eduardoguerrero@deliveries.app', '02.jpg', directorio);
    insertarCliente(5263491,'Ana', 'María', 'González', 'Gutiérrez', 'anagonzález@deliveries.app', '03.jpg', directorio);
    insertarCliente(8052968,'Andrea', 'Carolina', 'Acosta', 'Blas', 'andreaacosta@deliveries.app', '04.jpg', directorio);
    insertarCliente(11914781,'Fernando', 'Eduardo', 'Vera', 'Santeliz', 'fernandovera@deliveries.app', '05.jpg', directorio);

    insertarCliente(14850119,'Natalia', 'Ximena', 'Sánchez', 'Salazara', 'nataliasanchez@deliveries.app', '06.jpg', directorio);
    insertarCliente(9234140,'Ronald', 'Rodrigo', 'Balza', 'Ugel', 'ronaldbalza@deliveries.app', '07.jpg', directorio);
    insertarCliente(11192772,'Eliecer', 'Alan', 'Montaña', 'Pérez', 'eliecermontaña@deliveries.app', '08.jpg', directorio);
    insertarCliente(7727507,'Francis', 'Ana', 'Pacheco', 'Guzmán', 'francispacheco@deliveries.app', '09.jpg', directorio);
    insertarCliente(8843392,'Julia', 'Amanda', 'Nova', 'Blair', 'julianova@deliveries.app', '10.jpg', directorio);

    insertarCliente(13908954,'Dominic', 'David', 'Noriega', 'Tirado', 'dominicnoriega@deliveries.app', '11.jpg', directorio);
    insertarCliente(13659465,'Eduardo', 'Ignacio', 'Rivas', 'Pino', 'eduardorivas@deliveries.app', '12.jpg', directorio);
    insertarCliente(12516807,'Santiago', 'Luz', 'Altrigada', 'Texeira', 'santiagoaltrigada@deliveries.app', '13.jpg', directorio);
    insertarCliente(8306312,'Yulaida', 'Edith', 'Zambrano', 'Amarista', 'yulaidazambrano@deliveries.app', '14.jpg', directorio);
    insertarCliente(8742813,'Fabrizio', 'Guillermo', 'Cabello', 'Liñares', 'fabriziocabello@deliveries.app', '15.jpg', directorio);
END;





















