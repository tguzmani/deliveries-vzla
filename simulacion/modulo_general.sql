--CODIGO DE SIMULACION DE Deliveries
--COMPILAR LOS MODULOS 1, 2 y 3 ANTES DE EJECUTAR

--StoredProcedure QUE SIMULA UN DIA COMPLETO, BUSCA TODOS LOS PEDIDOS POSIBLES Y ALEATORIAMENTE DECIDE SI SE REALIZAN

CREATE OR REPLACE PROCEDURE simulate_day (in_fecha IN DATE)
IS
    aux v_pedidos_posibles%rowtype;
    evento NUMBER;
    contador INTEGER;
    CURSOR c1 IS
        SELECT * FROM v_pedidos_posibles --SAMPLE(50)
        WHERE in_fecha BETWEEN FECHA_I_CONTRATO AND FECHA_F_CONTRATO
        AND in_fecha > FECHA_REGISTRO;
BEGIN
    OPEN c1;
    contador:=0;
    evento:=0;
    LOOP
        FETCH c1 INTO aux;
        EXIT WHEN c1%NOTFOUND;
        contador:=contador+1;
        evento:= TRUNC(DBMS_RANDOM.VALUE(0,10));
        IF (evento<3) THEN
            --La probabilidad de que un usuario haga un pedido a una alida en la aplicacion registrada es de 2 en 10
            CREAR_PEDIDO(in_fecha,aux.CEDULA,aux.ID_APP,aux.ID_ALIADA);
            dbms_output.put_line('-------------------------------------------------------');
        END IF;
    END LOOP;
    CLOSE c1;
END;


--Para simular un solo dia
--CALL simulate_day(to_date('01/12/2020','DD/MM/YYYY'));
-----------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------


--StoredProcedure DE SIMULACION, SE DA UNA FECHA DE INICIO Y UNA FECHA DE FIN

CREATE OR REPLACE PROCEDURE simulacion (fecha_inicio IN DATE, fecha_fin IN DATE)
IS
    dias_transcurridos INTEGER;
BEGIN
    IF fecha_inicio>fecha_fin THEN
        RAISE_APPLICATION_ERROR(-20001, 'ERROR: Fecha de inicio de simulación mayor a fecha de fin.');
    end if;
    IF fecha_fin-fecha_inicio > 31 THEN
        RAISE_APPLICATION_ERROR(-20001, 'ERROR: Tiempo maximo de simulacion es un mes');
    end if;
    dias_transcurridos:=0;
    WHILE (fecha_inicio+dias_transcurridos <= fecha_fin)
        LOOP
            dbms_output.put_line( '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
            dbms_output.put_line( 'DIA: ' || dias_transcurridos || '- FECHA: ' || TO_CHAR(fecha_inicio+dias_transcurridos,'DD/MM/YYYY'));
            dbms_output.put_line( '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
            simulate_day(fecha_inicio+dias_transcurridos);
            dias_transcurridos := dias_transcurridos + 1;

            if mod(dias_transcurridos, 7) = 0 then
                -- esto ocurre cada 7 días
                -- se ejecuta 3 veces para disparar el trigger
                for i in 1..4 loop
                    deactivate_units_all_apps();
                end loop;

                repair_units_all_apps();
            end if;

        end loop;
end;

-----------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------

--EJEMPLO
CALL SIMULACION(to_date('01/07/2020','DD/MM/YYYY'),to_date('10/07/2020','DD/MM/YYYY'));
