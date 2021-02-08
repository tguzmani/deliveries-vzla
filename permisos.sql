create role empleado_comercio; 
create role gerente_comercio;
create role gerente_aplicacion;
create role cliente;
create role conductor;

-- CLIENTE
grant select on cliente to empleado_comercio;
grant select on cliente to gerente_comercio;
grant select on cliente to gerente_aplicacion;
grant insert, select, update, delete on cliente to cliente;
grant select on cliente to conductor;

-- REGISTRO
grant select, delete on registro to gerente_aplicacion;
grant insert, select, update, delete on registro to cliente;
grant select on registro to conductor;

-- DIRECCIÓN
grant select, delete on direccion to gerente_aplicacion;
grant insert, select, update, delete on direccion to cliente;
grant select on direccion to conductor;

-- PUNTO DE REFERENCIA
grant select on pto_referencia to empleado_comercio;
grant select on pto_referencia to gerente_comercio;
grant select, update, delete on pto_referencia to gerente_aplicacion;
grant insert, select, update, delete on pto_referencia to cliente;
grant select on pto_referencia to conductor;

-- UBICACION
grant select on ubicacion to empleado_comercio;
grant select on ubicacion to gerente_comercio;
grant insert, select, update, delete on ubicacion to gerente_aplicacion;
grant select on ubicacion to cliente;
grant select on ubicacion to conductor;

-- OFICINA
grant select on oficina to empleado_comercio;
grant select on oficina to gerente_comercio;
grant insert, select, update, delete on oficina to gerente_aplicacion;
grant select on oficina to conductor;

-- APLICACION
grant select on aplicacion to empleado_comercio;
grant select on aplicacion to gerente_comercio;
grant insert, select, update, delete on aplicacion to gerente_aplicacion;
grant select on aplicacion to cliente;
grant select on aplicacion to conductor;

-- SERVICIO
grant select on servicio to gerente_comercio;
grant insert, select, update, delete on servicio to gerente_aplicacion;

-- CONTRATO
grant select on contrato to empleado_comercio;
grant select on contrato to gerente_comercio;
grant insert, select, update, delete on contrato to gerente_aplicacion;

-- ALIADA
grant select on aliada to empleado_comercio;
grant insert, select, update, delete on aliada to gerente_comercio;
grant select on aliada to gerente_aplicacion;
grant select on aliada to cliente;
grant select on aliada to conductor;

-- SUCURSAL
grant select on sucursal to empleado_comercio;
grant insert, select, update, delete on sucursal to gerente_comercio;
grant select on sucursal to gerente_aplicacion;
grant select on sucursal to cliente;
grant select on sucursal to conductor;

-- SECTOR
grant select on sector to empleado_comercio;
grant select on sector to gerente_comercio;
grant insert, select, update, delete on sector to gerente_aplicacion;
grant select on sector to cliente;

-- PRODUCTO
grant insert, select, update, delete on producto to empleado_comercio;
grant insert, select, update, delete on producto to gerente_comercio;
grant select on producto to gerente_aplicacion;
grant select on producto to cliente;
grant select on producto to conductor;

-- PEDIDO
grant select on pedido to empleado_comercio;
grant select on pedido to gerente_comercio;
grant insert, select, update, delete on pedido to gerente_aplicacion;
grant insert, select on pedido to cliente;
grant select on pedido to conductor;

-- UNIDAD
grant select on unidad to empleado_comercio;
grant select on unidad to gerente_comercio;
grant insert, select, update, delete on unidad to gerente_aplicacion;
grant select, update on unidad to conductor;

-- USUARIOS
alter session set "_ORACLE_SCRIPT" = true;

create user andrea
identified by secreto;
grant create session to andrea;
grant cliente to andrea;

create user enrique
identified by secreto;
grant create session to enrique;
grant gerente_aplicacion to enrique;

create user paola
identified by secreto;
grant create session to paola;
grant gerente_comercio to paola;

create user julio
identified by secreto;
grant create session to julio;
grant empleado_comercio to julio;

create user juan
identified by secreto;
grant create session to juan;
grant conductor to juan;
