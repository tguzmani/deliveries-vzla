------------------------------------------------------------------------------------------------------
-- Módulo III
--
-- Contenidos
------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------
-- (m4.0) Funciones
------------------------------------------------------------------------------------------------------

create or replace function random_integer(
    maximum number
) return number is
begin
    return ROUND(DBMS_RANDOM.VALUE(1, maximum));
end;

create or replace function num_rows_application
return number is
    num_rows number;
begin
    select count(*) into num_rows from aplicacion;
    return num_rows;
end;

-- Devuelve un número redondo entre 50 y 3000
create or replace function random_quantity
return number is
    quantity NUMBER;
begin
    quantity := TRUNC(DBMS_RANDOM.VALUE(1, 3), 1)*POWER(10, ROUND(DBMS_RANDOM.VALUE(1, 3)));
    if quantity < 50 then
        return 50;
    end if;

    return quantity;
end;

-- Devuelve un precio razonable para el nivel del país
create or replace function random_price
return number is
    price NUMBER;
begin
    price := TRUNC(DBMS_RANDOM.VALUE(1, 3), 1)*POWER(10, ROUND(DBMS_RANDOM.VALUE(0, 1)));
    if false THEN
        RETURN 50;
    end if;

    RETURN price;
end;

-- Elige al azar entre anual, trimestral y mensual
create or replace function random_period
return varchar2 is
    random_value number;
    period varchar2(30);
begin
    random_value := ROUND(DBMS_RANDOM.VALUE(1, 3));

    if random_value = 1 then
        period := 'anual';
    elsif random_value = 2 then
        period := 'trimestral';
    else
        period := 'mensual';
    end if;

    return period;
end;

select random_quantity(), random_price(), random_period() from dual;

select random_integer(1,num_rows_application()) from dual;

------------------------------------------------------------------------------------------------------
-- (m4.1) Punto 1: Definición de acuerdos
------------------------------------------------------------------------------------------------------

create or replace procedure new_contracts
is
    random_rows number := random_integer(num_rows_application());

    cursor application_list is
        select id from aplicacion
        order by DBMS_RANDOM.RANDOM()
        fetch first random_rows rows only;
begin
    for culo in application_list
    loop
        DBMS_OUTPUT.PUT_LINE(culo.id)  ;
    end loop;
end;

call new_contracts();
