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
grant select on registro to empleado_comercio;
grant select on registro to gerente_comercio;
grant select on registro to gerente_aplicacion;
grant insert, select, update, delete on registro to cliente;
grant select on registro to conductor;

-- DIRECCIÓN
grant insert, select, update, delete on direccion to empleado_comercio;
grant insert, select, update, delete on direccion to gerente_comercio;
grant insert, select, update, delete on direccion to gerente_aplicacion;
grant insert, select, update, delete on direccion to cliente;
grant insert, select, update, delete on direccion to conductor;

-- PUNTO DE REFERENCIA
grant insert, select, update, delete on pto_referencia to empleado_comercio;
grant insert, select, update, delete on pto_referencia to gerente_comercio;
grant insert, select, update, delete on pto_referencia to gerente_aplicacion;
grant insert, select, update, delete on pto_referencia to cliente;
grant insert, select, update, delete on pto_referencia to conductor;

-- UBICACION
grant insert, select, update, delete on ubicacion to empleado_comercio;
grant insert, select, update, delete on ubicacion to gerente_comercio;
grant insert, select, update, delete on ubicacion to gerente_aplicacion;
grant insert, select, update, delete on ubicacion to cliente;
grant insert, select, update, delete on ubicacion to conductor;

-- OFICINA
grant insert, select, update, delete on oficina to empleado_comercio;
grant insert, select, update, delete on oficina to gerente_comercio;
grant insert, select, update, delete on oficina to gerente_aplicacion;
grant insert, select, update, delete on oficina to cliente;
grant insert, select, update, delete on oficina to conductor;

-- APLICACION
grant insert, select, update, delete on aplicacion to empleado_comercio;
grant insert, select, update, delete on aplicacion to gerente_comercio;
grant insert, select, update, delete on aplicacion to gerente_aplicacion;
grant insert, select, update, delete on aplicacion to cliente;
grant insert, select, update, delete on aplicacion to conductor;

-- SERVICIO
grant insert, select, update, delete on servicio to empleado_comercio;
grant insert, select, update, delete on servicio to gerente_comercio;
grant insert, select, update, delete on servicio to gerente_aplicacion;
grant insert, select, update, delete on servicio to cliente;
grant insert, select, update, delete on servicio to conductor;

-- CONTRATO
grant insert, select, update, delete on contrato to empleado_comercio;
grant insert, select, update, delete on contrato to gerente_comercio;
grant insert, select, update, delete on contrato to gerente_aplicacion;
grant insert, select, update, delete on contrato to cliente;
grant insert, select, update, delete on contrato to conductor;

-- ALIADA
grant insert, select, update, delete on aliada to empleado_comercio;
grant insert, select, update, delete on aliada to gerente_comercio;
grant insert, select, update, delete on aliada to gerente_aplicacion;
grant insert, select, update, delete on aliada to cliente;
grant insert, select, update, delete on aliada to conductor;

-- SECTOR
grant insert, select, update, delete on sector to empleado_comercio;
grant insert, select, update, delete on sector to gerente_comercio;
grant insert, select, update, delete on sector to gerente_aplicacion;
grant insert, select, update, delete on sector to cliente;
grant insert, select, update, delete on sector to conductor;

-- PRODUCTO
grant insert, select, update, delete on producto to empleado_comercio;
grant insert, select, update, delete on producto to gerente_comercio;
grant insert, select, update, delete on producto to gerente_aplicacion;
grant insert, select, update, delete on producto to cliente;
grant insert, select, update, delete on producto to conductor;

-- PEDIDO
grant insert, select, update, delete on pedido to empleado_comercio;
grant insert, select, update, delete on pedido to gerente_comercio;
grant insert, select, update, delete on pedido to gerente_aplicacion;
grant insert, select, update, delete on pedido to cliente;
grant insert, select, update, delete on pedido to conductor;

-- UNIDAD
grant insert, select, update, delete on unidad to empleado_comercio;
grant insert, select, update, delete on unidad to gerente_comercio;
grant insert, select, update, delete on unidad to gerente_aplicacion;
grant insert, select, update, delete on unidad to cliente;
grant insert, select, update, delete on unidad to conductor;