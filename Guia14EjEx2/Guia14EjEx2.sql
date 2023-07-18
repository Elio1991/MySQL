-- 1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.
SELECT codigo_oficina, ciudad FROM OFICINA;
-- 2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.
SELECT ciudad, telefono FROM OFICINA WHERE PAIS = ('ESPAÑA');
-- 3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un
-- código de jefe igual a 7.
SELECT nombre,  CONCAT(apellido1, ' ', apellido2) Apellidos, email FROM EMPLEADO WHERE codigo_jefe = (7);
-- 4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.
SELECT puesto, nombre, CONCAT(apellido1, ' ', apellido2) Apellidos, email FROM EMPLEADO WHERE codigo_jefe IS NULL;
-- 5. Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean
-- representantes de ventas.
SELECT nombre, CONCAT(apellido1, ' ', apellido2) Apellidos, puesto FROM EMPLEADO WHERE NOT PUESTO = ('Representante Ventas');
-- 6. Devuelve un listado con el nombre de los todos los clientes españoles.
SELECT * FROM CLIENTE WHERE PAIS = ('SPAIN');
-- 7. Devuelve un listado con los distintos estados por los que puede pasar un pedido.
SELECT estado FROM PEDIDO GROUP BY estado;
/* 8. Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago
en 2008. Tenga en cuenta que deberá eliminar aquellos códigos de cliente que aparezcan
repetidos. Resuelva la consulta:
o Utilizando la función YEAR de MySQL.
o Utilizando la función DATE_FORMAT de MySQL.
o Sin utilizar ninguna de las funciones anteriores. */ 
SELECT codigo_cliente, fecha_pago FROM PAGO WHERE YEAR(fecha_pago) = 2008 GROUP BY codigo_cliente;
SELECT codigo_cliente, fecha_pago FROM PAGO WHERE date_format(fecha_pago, '%Y') = ('2008');
SELECT codigo_cliente, fecha_pago FROM PAGO WHERE fecha_pago LIKE ('2008%') GROUP BY codigo_cliente;
-- 9. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de
-- entrega de los pedidos que no han sido entregados a tiempo.
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega FROM PEDIDO WHERE fecha_entrega > fecha_esperada;
/* 10. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de
entrega de los pedidos cuya fecha de entrega ha sido al menos dos días antes de la fecha
esperada.
o Utilizando la función ADDDATE de MySQL.
o Utilizando la función DATEDIFF de MySQL. */ 
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega FROM PEDIDO WHERE ADDDATE(fecha_entrega, INTERVAL 2 DAY) <= fecha_esperada;
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega FROM pedido WHERE fecha_entrega <= ADDDATE(fecha_esperada, INTERVAL -2 DAY);
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega FROM PEDIDO WHERE DATEDIFF(fecha_esperada, fecha_entrega) >= 2;
-- 11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.
SELECT * FROM PEDIDO WHERE estado = ('Rechazado') AND fecha_pedido LIKE ('2009%');
-- 12. Devuelve un listado de todos los pedidos que han sido entregados en el mes de enero de cualquier año.
SELECT * FROM PEDIDO WHERE MONTH(fecha_entrega) = 01 AND estado = ('Entregado');
-- 13. Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante Paypal.
-- Ordene el resultado de mayor a menor.
SELECT * FROM PAGO WHERE YEAR(fecha_pago) = 2008 AND forma_pago = ('Paypal') ORDER BY total DESC;
-- 14. Devuelve un listado con todas las formas de pago que aparecen en la tabla pago. Tenga en
-- cuenta que no deben aparecer formas de pago repetidas.
SELECT DISTINCT forma_pago FROM PAGO;
/* 15. Devuelve un listado con todos los productos que pertenecen a la gama Ornamentales y que
tienen más de 100 unidades en stock. El listado deberá estar ordenado por su precio de
venta, mostrando en primer lugar los de mayor precio. */ 
SELECT * FROM PRODUCTO WHERE gama = ('Ornamentales') AND cantidad_en_stock > (100) ORDER BY precio_venta DESC;
-- 16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y cuyo
-- representante de ventas tenga el código de empleado 11 o 30.
SELECT codigo_cliente, nombre_cliente, ciudad, codigo_empleado_rep_ventas FROM CLIENTE WHERE ciudad = ('MADRID') AND codigo_empleado_rep_ventas IN (11, 30);
/*Consultas multitabla (Composición interna)
Las consultas se deben resolver con INNER JOIN.*/
-- 1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.
SELECT C.nombre_cliente, E.nombre, CONCAT(E.apellido1, ' ', E.apellido2) Apellidos FROM CLIENTE C INNER JOIN EMPLEADO E ON C.codigo_empleado_rep_ventas = codigo_empleado;
-- 2. Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas.
SELECT P.codigo_cliente, C.nombre_cliente, P.fecha_pago, C.codigo_empleado_rep_ventas, E.nombre
 FROM CLIENTE C INNER JOIN PAGO P ON C.codigo_cliente = P.codigo_cliente
 INNER JOIN EMPLEADO E ON C.codigo_empleado_rep_ventas = E.codigo_empleado GROUP BY C.nombre_cliente;
-- 3. Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de sus representantes de ventas.
SELECT C.codigo_cliente, C.nombre_cliente, P.id_transaccion, C.codigo_empleado_rep_ventas, E.nombre
 FROM CLIENTE C LEFT JOIN PAGO P ON C.codigo_cliente = P.codigo_cliente
 INNER JOIN EMPLEADO E ON C.codigo_empleado_rep_ventas = E.codigo_empleado WHERE P.id_transaccion IS NULL;
-- 4. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes
-- junto con la ciudad de la oficina a la que pertenece el representante.
SELECT C.codigo_cliente, C.nombre_cliente, P.id_transaccion, C.codigo_empleado_rep_ventas Cod_REP, E.nombre, CONCAT(E.apellido1, ' ', E.apellido2) Apellidos, E.codigo_oficina, O.ciudad
FROM CLIENTE C INNER JOIN PAGO P ON C.codigo_cliente = P.codigo_cliente
INNER JOIN EMPLEADO E ON C.codigo_empleado_rep_ventas = E.codigo_empleado
INNER JOIN OFICINA O ON E.codigo_oficina = O.codigo_oficina GROUP BY C.nombre_cliente ORDER BY C.codigo_cliente;
-- 5. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus
-- representantes junto con la ciudad de la oficina a la que pertenece el representante.
SELECT C.codigo_cliente, C.nombre_cliente, P.id_transaccion, C.codigo_empleado_rep_ventas Cod_REP, E.nombre, CONCAT(E.apellido1, ' ', E.apellido2) Apellidos, E.codigo_oficina, O.ciudad
FROM CLIENTE C LEFT JOIN PAGO P ON C.codigo_cliente = P.codigo_cliente
INNER JOIN EMPLEADO E ON C.codigo_empleado_rep_ventas = E.codigo_empleado
INNER JOIN OFICINA O ON E.codigo_oficina = O.codigo_oficina WHERE P.id_transaccion IS NULL GROUP BY C.nombre_cliente ORDER BY C.codigo_cliente;
-- 6. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.
SELECT DISTINCT O.codigo_oficina, O.linea_direccion1, E.codigo_empleado FROM OFICINA O 
INNER JOIN EMPLEADO E ON O.codigo_oficina = E.codigo_oficina
INNER JOIN CLIENTE C ON E.codigo_empleado = C.codigo_empleado_rep_ventas WHERE C.linea_direccion2 = ('Fuenlabrada');
-- 7. Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad
-- de la oficina a la que pertenece el representante.
SELECT C.nombre_cliente, E.nombre NOMBRE_REP, CONCAT(E.apellido1, ' ', E.apellido2) Apellidos_REP, O.ciudad 
FROM CLIENTE C INNER JOIN EMPLEADO E ON C.codigo_empleado_rep_ventas = E.codigo_empleado
INNER JOIN OFICINA O ON E.codigo_oficina = O.codigo_oficina;
-- 8. Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.
SELECT EMPLEADO.codigo_empleado, EMPLEADO.nombre EMPLEADO, CONCAT(EMPLEADO.apellido1, ' ', EMPLEADO.apellido2) APELLIDOS_EMP, EMPLEADO.codigo_jefe, JEFES.nombre NOMBRE_JEFE, 
CONCAT(JEFES.apellido1, ' ', JEFES.apellido2) APELLIDOS_JEFES FROM EMPLEADO EMPLEADO
LEFT JOIN EMPLEADO JEFES ON EMPLEADO.codigo_jefe = JEFES.codigo_empleado; 
-- 9. Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.
SELECT C.nombre_cliente, P.fecha_esperada, P.fecha_entrega FROM CLIENTE C 
INNER JOIN PEDIDO P ON C.codigo_cliente = P.codigo_cliente WHERE P.fecha_entrega > P.fecha_esperada;
-- 10. Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.
SELECT C.nombre_cliente, PRO.gama FROM CLIENTE C INNER JOIN PEDIDO P ON C.codigo_cliente = P.codigo_cliente
INNER JOIN DETALLE_PEDIDO DP ON P.codigo_pedido = DP.codigo_pedido
INNER JOIN PRODUCTO PRO ON DP.codigo_producto = PRO.codigo_producto;

/*Consultas multitabla (Composición externa)
Resuelva todas las consultas utilizando las cláusulas LEFT JOIN, RIGHT JOIN, JOIN. */
-- 1. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
SELECT C.nombre_cliente, P.id_transaccion FROM CLIENTE C LEFT JOIN PAGO P ON C.codigo_cliente = P.codigo_cliente
 WHERE P.id_transaccion IS NULL GROUP BY C.nombre_cliente;
-- 2. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pedido.
SELECT C.codigo_cliente, C.nombre_cliente, P.codigo_pedido FROM CLIENTE C LEFT JOIN PEDIDO P
ON C.codigo_cliente = P.codigo_cliente WHERE P.codigo_pedido IS NULL;
-- 3. Devuelve un listado que muestre los clientes que no han realizado ningún pago y los que
-- no han realizado ningún pedido.
SELECT C.codigo_cliente, C.nombre_cliente, P.codigo_pedido, PG.id_transaccion FROM CLIENTE C
 LEFT JOIN PEDIDO P ON C.codigo_cliente = P.codigo_cliente 
 LEFT JOIN PAGO PG ON C.codigo_cliente = PG.codigo_cliente WHERE P.codigo_pedido IS NULL AND PG.id_transaccion IS NULL;
-- 4. Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada.
SELECT E.codigo_empleado, E.nombre, CONCAT(E.apellido1, ' ', E.apellido2) APELLIDOS, O.codigo_oficina 
FROM EMPLEADO E LEFT JOIN OFICINA O ON E.codigo_oficina = O.codigo_oficina WHERE O.codigo_oficina IS NULL;
-- 5. Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado.
SELECT E.codigo_empleado, E.nombre, CONCAT(E.apellido1, ' ', E.apellido2) APELLIDOS, C.codigo_cliente 
FROM EMPLEADO E LEFT JOIN CLIENTE C ON E.codigo_empleado = C.codigo_empleado_rep_ventas WHERE C.codigo_empleado_rep_ventas IS NULL;
-- 6. Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los
-- que no tienen un cliente asociado.
SELECT E.codigo_empleado, E.nombre, CONCAT(E.apellido1, ' ', E.apellido2) APELLIDOS, O.codigo_oficina, C.codigo_cliente 
FROM EMPLEADO E LEFT JOIN OFICINA O ON E.codigo_oficina = O.codigo_oficina 
LEFT JOIN CLIENTE C ON E.codigo_empleado = C.codigo_empleado_rep_ventas WHERE C.codigo_empleado_rep_ventas IS NULL OR O.codigo_oficina IS NULL;
-- (No hay empleados sin codigo de oficina).
-- 7. Devuelve un listado de los productos que nunca han aparecido en un pedido.
SELECT P.codigo_producto, P.nombre, P.gama, P.proveedor, P.descripcion, P.precio_venta, P.precio_proveedor, PED.codigo_pedido FROM PRODUCTO P 
LEFT JOIN DETALLE_PEDIDO DP ON P.codigo_producto = DP.codigo_producto
LEFT JOIN PEDIDO PED ON DP.codigo_pedido = PED.codigo_pedido WHERE PED.codigo_pedido IS NULL;
-- 8. Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los
-- representantes de ventas de algún cliente que haya realizado la compra de algún producto de la gama Frutales.
SELECT OFI.codigo_oficina, OFI.ciudad, OFI.pais, EM.codigo_empleado, CLI.nombre_cliente, PRO.gama
FROM OFICINA OFI LEFT JOIN EMPLEADO EM ON OFI.codigo_oficina = EM.codigo_oficina
INNER JOIN CLIENTE CLI ON EM.codigo_empleado = CLI.codigo_empleado_rep_ventas
INNER JOIN PEDIDO PE ON CLI.codigo_cliente = PE.codigo_cliente
INNER JOIN DETALLE_PEDIDO DP ON PE.codigo_pedido = DP.codigo_pedido
INNER JOIN PRODUCTO PRO ON DP.codigo_producto = PRO.codigo_producto WHERE  AND PRO.gama LIKE ('Frutales');
-- FALTA LA CONDICION DEL FILTRO
/*9. Devuelve un listado con los clientes que han realizado algún pedido, pero no han realizado
ningún pago.
10. Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el
nombre de su jefe asociado.
Consultas resumen
1. ¿Cuántos empleados hay en la compañía?
2. ¿Cuántos clientes tiene cada país?
3. ¿Cuál fue el pago medio en 2009?
4. ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el
número de pedidos.
5. Calcula el precio de venta del producto más caro y más barato en una misma consulta.
6. Calcula el número de clientes que tiene la empresa.
7. ¿Cuántos clientes tiene la ciudad de Madrid?
8. ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan por M?
9. Devuelve el nombre de los representantes de ventas y el número de clientes al que atiende
cada uno.

10. Calcula el número de clientes que no tiene asignado representante de ventas.
11. Calcula la fecha del primer y último pago realizado por cada uno de los clientes. El listado
deberá mostrar el nombre y los apellidos de cada cliente.
12. Calcula el número de productos diferentes que hay en cada uno de los pedidos.
13. Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de
los pedidos.
14. Devuelve un listado de los 20 productos más vendidos y el número total de unidades que
se han vendido de cada uno. El listado deberá estar ordenado por el número total de
unidades vendidas.
15. La facturación que ha tenido la empresa en toda la historia, indicando la base imponible, el
IVA y el total facturado. La base imponible se calcula sumando el coste del producto por el
número de unidades vendidas de la tabla detalle_pedido. El IVA es el 21 % de la base
imponible, y el total la suma de los dos campos anteriores.
16. La misma información que en la pregunta anterior, pero agrupada por código de producto.
17. La misma información que en la pregunta anterior, pero agrupada por código de producto
filtrada por los códigos que empiecen por OR.
18. Lista las ventas totales de los productos que hayan facturado más de 3000 euros. Se
mostrará el nombre, unidades vendidas, total facturado y total facturado con impuestos (21%
IVA)
Subconsultas con operadores básicos de comparación
1. Devuelve el nombre del cliente con mayor límite de crédito.
2. Devuelve el nombre del producto que tenga el precio de venta más caro.
3. Devuelve el nombre del producto del que se han vendido más unidades. (Tenga en cuenta
que tendrá que calcular cuál es el número total de unidades que se han vendido de cada
producto a partir de los datos de la tabla detalle_pedido. Una vez que sepa cuál es el código
del producto, puede obtener su nombre fácilmente.)
4. Los clientes cuyo límite de crédito sea mayor que los pagos que haya realizado. (Sin utilizar
INNER JOIN).
5. Devuelve el producto que más unidades tiene en stock.
6. Devuelve el producto que menos unidades tiene en stock.
7. Devuelve el nombre, los apellidos y el email de los empleados que están a cargo de Alberto
Soria.
Subconsultas con ALL y ANY
1. Devuelve el nombre del cliente con mayor límite de crédito.
2. Devuelve el nombre del producto que tenga el precio de venta más caro.
3. Devuelve el producto que menos unidades tiene en stock.
Subconsultas con IN y NOT IN
1. Devuelve el nombre, apellido1 y cargo de los empleados que no representen a ningún
cliente.
2. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
3. Devuelve un listado que muestre solamente los clientes que sí han realizado ningún pago.

4. Devuelve un listado de los productos que nunca han aparecido en un pedido.
5. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que
no sean representante de ventas de ningún cliente.
Subconsultas con EXISTS y NOT EXISTS
1. Devuelve un listado que muestre solamente los clientes que no han realizado ningún
pago.
2. Devuelve un listado que muestre solamente los clientes que sí han realizado ningún pago.
3. Devuelve un listado de los productos que nunca han aparecido en un pedido.
4. Devuelve un listado de los productos que han aparecido en un pedido alguna vez. */