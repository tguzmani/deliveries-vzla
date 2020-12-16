------------------------------------------------------------------------------------------------------
-- Módulo III
--
-- Contenidos
-- (m4.0) Funciones
-- (m4.1) Definición de contratos
------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------
-- (m4.0) Funciones
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

-- Devuelve un precio razonable para el nivel del país
create or replace function random_price(quantity number)
return number is
    price NUMBER;
begin
    price := quantity + ROUND(DBMS_RANDOM.VALUE(-3, 3))*POWER(10, ROUND(DBMS_RANDOM.VALUE(1, 2)));
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

------------------------------------------------------------------------------------------------------
-- (m4.1) Punto 1: Definición de acuerdos
------------------------------------------------------------------------------------------------------

create or replace procedure new_contracts
is
    random_rows number := round(random_integer(num_rows_application()) * 1/3);
    initial_date date := sysdate;
    ending_date date;
    periodo varchar2(50);
    id_aliada number;
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

        if periodo = 'anual' then
            ending_date := initial_date + 365;
        elsif periodo = 'trimestral' then
            ending_date := initial_date + 90;
        else
            ending_date := initial_date + 30;
        end if;

        quantity := random_quantity();
        price := random_price(quantity);

        -- estos son los datos del insert de servicio
        separator('=',80);
        puts('DATOS SERVICIO');
        DBMS_OUTPUT.PUT_LINE(app.id);
        DBMS_OUTPUT.PUT_LINE(initial_date);
        DBMS_OUTPUT.PUT_LINE(periodo);
        DBMS_OUTPUT.PUT_LINE(ending_date);
        insert into servicio values (default,
                                     app.id,
                                     precio_cantidad(quantity, price),
                                     periodo,
                                     fechas(initial_date, ending_date)) returning id into id_servicio;
        separator('-',40);

        id_aliada := random_integer(num_rows_aliada());
        puts('DATOS CONTRATO');
        DBMS_OUTPUT.PUT_LINE(app.id);
        DBMS_OUTPUT.PUT_LINE(id_aliada);
        DBMS_OUTPUT.PUT_LINE(initial_date);
        DBMS_OUTPUT.PUT_LINE(periodo);
        DBMS_OUTPUT.PUT_LINE('id servicio = ' || id_servicio);
        DBMS_OUTPUT.PUT_LINE(ending_date);
    end loop;
end;

call new_contracts();

select * from servicio order by id desc;

delete from servicio where id > 20;




