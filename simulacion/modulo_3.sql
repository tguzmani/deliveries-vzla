------------------------------------------------------------------------------------------------------
-- Módulo III
--
-- (m3.0) Funciones
-- (m3.1) Stored Procedures
-- (m3.2) Generar nuevos contratos y servicios
-- (m3.3) Pruebas del módulo
------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------
-- (m3.0) Funciones
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

create or replace function num_rows_aliada
return number is
    num_rows number;
begin
    select count(*) into num_rows from aliada;
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

-- Genera un precio en función de la cantidad
create or replace function random_price(quantity number)
return number is
    price NUMBER;
begin
    -- price := quantity + ROUND(DBMS_RANDOM.VALUE(-3, 3))*POWER(10, ROUND(DBMS_RANDOM.VALUE(1, 2)));
    price := quantity * (random_integer(5) + 7) / 10;
    if false THEN
        RETURN 50;
    end if;

    return abs(price);
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

create or replace function offset_by_period(periodo varchar2)
return number is
    offset number;
begin
    if periodo = 'anual' then
        offset := 365;
    elsif periodo = 'trimestral' then
        offset := 90;
    else
        offset := 30;
    end if;

    return offset;
end;

select random_quantity(), random_price(), random_period() from dual;

------------------------------------------------------------------------------------------------------
-- (m3.1) Stored Procedures
------------------------------------------------------------------------------------------------------

create or replace procedure separator(symbol varchar2, length in number)
is
    out varchar(80);
begin
    select rpad(symbol, length, symbol) into out from dual;
    DBMS_OUTPUT.PUT_LINE(out);
end;

create or replace procedure puts(string in varchar2)
is
    out varchar(250);
begin
    DBMS_OUTPUT.PUT_LINE(string);
end;

------------------------------------------------------------------------------------------------------
-- (m3.2) Generar nuevos contratos y servicios
------------------------------------------------------------------------------------------------------

create or replace procedure new_contracts
is
    random_rows number := round(random_integer(num_rows_application()) * 1/3);
    initial_date date := sysdate;
    ending_date date;
    periodo varchar2(50);
    id_aliada number;
    id_aplicacion number;
    id_servicio number;
    quantity number;
    price number;

    cursor application_list is
        select id from aplicacion
        order by DBMS_RANDOM.RANDOM()
        fetch first random_rows rows only;
begin
    for app in application_list
    loop
        periodo := random_period();
        ending_date := initial_date + offset_by_period(periodo);

        quantity := random_quantity();
        price := random_price(quantity);

        -- estos son los datos del insert de servicio
        separator('=',80);
        puts('DATOS SERVICIO');
        DBMS_OUTPUT.PUT_LINE('app.id = ' || app.id);
        DBMS_OUTPUT.PUT_LINE('periodo = ' || periodo);
        DBMS_OUTPUT.PUT_LINE('initial_date = ' || initial_date);
        DBMS_OUTPUT.PUT_LINE('ending_date = ' || ending_date);
        insert into servicio values (default,
                                     app.id,
                                     precio_cantidad(quantity, price),
                                     periodo,
                                     fechas(initial_date, ending_date))
                                     returning id, id_aplicacion into id_servicio, id_aplicacion;
        separator('-',40);

        select id_aliada
        into id_aliada
        from oficina o, sucursal s, ubicacion u
        where o.id_zona = s.id_zona and
              o.id_zona = u.id and
              o.id_aplicacion = id_aplicacion
        order by DBMS_RANDOM.RANDOM()
        fetch first row only;

        puts('DATOS CONTRATO');
        DBMS_OUTPUT.PUT_LINE('app.id = ' || app.id);
        DBMS_OUTPUT.PUT_LINE('id_aliada = ' || id_aliada);
        DBMS_OUTPUT.PUT_LINE('id_servicio = ' || id_servicio);
        DBMS_OUTPUT.PUT_LINE('periodo = ' || periodo);
        DBMS_OUTPUT.PUT_LINE('initial_date = ' || initial_date);
        DBMS_OUTPUT.PUT_LINE('ending_date = ' || ending_date);
        insert into contrato values (default,
                                     id_aplicacion,
                                     id_aliada,
                                     fechas(initial_date, ending_date),
                                     id_servicio,
                                     id_aplicacion);
    end loop;
end;


------------------------------------------------------------------------------------------------------
-- (m3.3) Pruebas del módulo
------------------------------------------------------------------------------------------------------

-- Verificar que todas las funciones hayan sido compiladas
select random_integer(10),
       num_rows_application(),
       num_rows_aliada(),
       random_quantity(),
       random_price(10),
       random_period(),
       offset_by_period('mensual')
from dual;

-- Llamar una sola vez
call new_contracts();

-- Llamar n veces
declare
    n number := 20;
begin
    for i in 1..n loop
        new_contracts();
    end loop;
end;

-- Selects y deletes sencillos
select * from contrato order by n_contrato desc;
select * from contrato where n_contrato > 15;
delete from contrato where n_contrato > 15;

select * from servicio order by id desc;
select * from servicio where id > 20;
delete from servicio where id > 20;

-- Borrar de ambas tablas
begin
    delete from contrato where n_contrato > 15;
    delete from servicio where id > 20;
end;





