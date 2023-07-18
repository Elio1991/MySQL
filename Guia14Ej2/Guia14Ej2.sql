-- 1. Lista el nombre de todos los productos que hay en la tabla producto.
SELECT nombre FROM PRODUCTO;
-- 2. Lista los nombres y los precios de todos los productos de la tabla producto.
SELECT nombre, precio FROM PRODUCTO;
-- 3. Lista todas las columnas de la tabla producto.
SELECT * FROM PRODUCTO;
-- 4. Lista los nombres y los precios de todos los productos de la tabla producto, redondeando el valor del precio.
SELECT nombre, ROUND(precio) FROM PRODUCTO;
-- 5. Lista el código de los fabricantes que tienen productos en la tabla producto.
SELECT codigo_fabricante FROM PRODUCTO;
-- 6. Lista el código de los fabricantes que tienen productos en la tabla producto, sin mostrar los repetidos.
SELECT DISTINCT codigo_fabricante FROM PRODUCTO;
SELECT codigo_fabricante FROM PRODUCTO GROUP BY codigo_fabricante;
-- 7. Lista los nombres de los fabricantes ordenados de forma ascendente.
SELECT nombre FROM FABRICANTE ORDER BY nombre;
-- 8. Lista los nombres de los productos ordenados en primer lugar por el nombre de forma ascendente y en segundo lugar por el precio de forma descendente.
SELECT nombre, precio FROM PRODUCTO ORDER BY nombre ASC, precio DESC;
-- 9. Devuelve una lista con las 5 primeras filas de la tabla fabricante.
SELECT * FROM FABRICANTE WHERE codigo BETWEEN 1 AND 5;
SELECT * FROM FABRICANTE LIMIT 5;
-- 10. Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas ORDER BY y LIMIT).
SELECT nombre, precio FROM PRODUCTO ORDER BY precio LIMIT 1;
-- 11. Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas ORDER BY y LIMIT).
SELECT nombre, precio FROM PRODUCTO ORDER BY precio DESC LIMIT 1;
-- 12. Lista el nombre de los productos que tienen un precio menor o igual a $120.
SELECT nombre, precio FROM PRODUCTO WHERE precio <= (120);
-- 13. Lista todos los productos que tengan un precio entre $60 y $200. Utilizando el operador BETWEEN.
SELECT * FROM PRODUCTO WHERE precio BETWEEN (60) AND (200);
-- 14. Lista todos los productos donde el código de fabricante sea 1, 3 o 5. Utilizando el operador IN.
SELECT * FROM PRODUCTO WHERE codigo_fabricante IN (1, 3, 5);
-- 15. Devuelve una lista con el nombre de todos los productos que contienen la cadena Portátil en el nombre.
SELECT nombre FROM PRODUCTO WHERE nombre LIKE ('%PORTATIL%');
-- Consultas Multitabla.
-- 1. Devuelve una lista con el código del producto, nombre del producto, código del fabricante y nombre del fabricante, de todos los productos de la base de datos.
SELECT PRODUCTO.codigo ID_PRODUCTO, PRODUCTO.nombre NOMBRE_PRODUCTO, codigo_fabricante CODIGO_FABRICANTE, FABRICANTE.nombre NOMBRE_FABRICANTE FROM PRODUCTO INNER JOIN FABRICANTE ON PRODUCTO.codigo_fabricante = FABRICANTE.codigo;
-- Opc B.
SELECT p.codigo codigo_prod,p.nombre,f.codigo codigo_fab,f.nombre FROM producto p, fabricante f 
 WHERE p.codigo_fabricante = f.codigo;
/* 2. Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos
los productos de la base de datos. Ordene el resultado por el nombre del fabricante, por
orden alfabético. */
SELECT PRODUCTO.nombre NOMBRE_PRODUCTO, PRODUCTO.precio, FABRICANTE.nombre FROM PRODUCTO INNER JOIN FABRICANTE ON PRODUCTO.codigo_fabricante = FABRICANTE.codigo ORDER BY FABRICANTE.nombre;
-- 3. Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.
SELECT PRODUCTO.nombre, PRODUCTO.precio, FABRICANTE.nombre FROM PRODUCTO INNER JOIN FABRICANTE ON PRODUCTO.codigo_fabricante = FABRICANTE.codigo ORDER BY PRODUCTO.precio LIMIT 1;
-- 4. Devuelve una lista de todos los productos del fabricante Lenovo.
SELECT PRODUCTO.nombre, PRODUCTO.precio, FABRICANTE.nombre FROM PRODUCTO INNER JOIN FABRICANTE ON PRODUCTO.codigo_fabricante = FABRICANTE.codigo WHERE FABRICANTE.nombre LIKE ('LENOVO');
-- 5. Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que $200.
SELECT PRODUCTO.nombre, PRODUCTO.precio, FABRICANTE.nombre FROM PRODUCTO INNER JOIN FABRICANTE ON PRODUCTO.codigo_fabricante = FABRICANTE.codigo WHERE FABRICANTE.nombre LIKE ('CRUCIAL') AND PRODUCTO.precio > (200);
-- 6. Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard. Utilizando el operador IN.
SELECT PRODUCTO.codigo, PRODUCTO.nombre, PRODUCTO.precio, FABRICANTE.nombre FROM PRODUCTO INNER JOIN FABRICANTE ON PRODUCTO.codigo_fabricante = FABRICANTE.codigo WHERE FABRICANTE.nombre IN ('Asus', 'Hewlett-Packard');
/* 7. Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos
los productos que tengan un precio mayor o igual a $180. Ordene el resultado en primer
lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden
ascendente) */
SELECT PRODUCTO.nombre, PRODUCTO.precio, FABRICANTE.nombre FROM PRODUCTO INNER JOIN FABRICANTE ON PRODUCTO.codigo_fabricante = FABRICANTE.codigo WHERE PRODUCTO.precio >= (180) ORDER BY PRODUCTO.precio DESC, PRODUCTO.nombre ASC;
-- Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.
/* 1. Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los
productos que tiene cada uno de ellos. El listado deberá mostrar también aquellos
fabricantes que no tienen productos asociados. */
SELECT FABRICANTE.codigo, FABRICANTE.nombre, PRODUCTO.nombre NOMBRE_PRODUCTO FROM FABRICANTE RIGHT JOIN PRODUCTO ON FABRICANTE.codigo = PRODUCTO.codigo_fabricante;
-- 2. Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún producto asociado.
SELECT * FROM FABRICANTE LEFT JOIN PRODUCTO ON FABRICANTE.codigo = PRODUCTO.codigo_fabricante WHERE FABRICANTE.codigo NOT IN (SELECT PRODUCTO.codigo_fabricante FROM PRODUCTO);
/* Subconsultas (En la cláusula WHERE)
Con operadores básicos de comparación */ 
-- 1. Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN).
SELECT * FROM PRODUCTO , FABRICANTE WHERE PRODUCTO.codigo_fabricante = FABRICANTE.codigo AND FABRICANTE.nombre LIKE ('LENOVO'); 
-- 2. Devuelve todos los datos de los productos que tienen el mismo precio que el producto más caro del fabricante Lenovo. (Sin utilizar INNER JOIN).
SELECT * FROM PRODUCTO , FABRICANTE WHERE PRODUCTO.codigo_fabricante = FABRICANTE.codigo AND PRODUCTO.precio = (SELECT PRODUCTO.precio FROM PRODUCTO , FABRICANTE WHERE PRODUCTO.codigo_fabricante = FABRICANTE.codigo AND FABRICANTE.nombre LIKE ('LENOVO') ORDER BY PRODUCTO.PRECIO DESC LIMIT 1);
-- 3. Lista el nombre del producto más caro del fabricante Lenovo.
SELECT PRODUCTO.nombre FROM PRODUCTO , FABRICANTE WHERE PRODUCTO.codigo_fabricante = FABRICANTE.codigo AND FABRICANTE.nombre LIKE ('LENOVO') ORDER BY PRODUCTO.PRECIO DESC LIMIT 1;
-- 4. Lista todos los productos del fabricante Asus que tienen un precio superior al precio medio de todos sus productos.
SELECT PRODUCTO.codigo, PRODUCTO.nombre, PRODUCTO.precio, FABRICANTE.nombre FROM PRODUCTO, FABRICANTE WHERE PRODUCTO.codigo_fabricante = FABRICANTE.codigo
AND FABRICANTE.nombre = ('Asus') AND PRODUCTO.precio >  (SELECT AVG(PRODUCTO.precio) FROM  PRODUCTO, FABRICANTE WHERE FABRICANTE.codigo = PRODUCTO.codigo_fabricante AND FABRICANTE.nombre = ('Asus'));
-- Subconsultas con IN y NOT IN
-- 1. Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando IN o NOT IN).
SELECT FABRICANTE.codigo, FABRICANTE.nombre, PRODUCTO.nombre FROM FABRICANTE, PRODUCTO WHERE PRODUCTO.codigo_fabricante = FABRICANTE.codigo AND FABRICANTE.codigo IN (SELECT PRODUCTO.codigo_fabricante FROM PRODUCTO);
-- 2. Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando IN o NOT IN).
-- SELECT FABRICANTE.nombre FROM PRODUCTO, FABRICANTE WHERE FABRICANTE.codigo IN (8,9) GROUP BY FABRICANTE.nombre; 
SELECT FABRICANTE.nombre, PRODUCTO.nombre FROM FABRICANTE LEFT JOIN PRODUCTO ON FABRICANTE.codigo = PRODUCTO.codigo_fabricante WHERE FABRICANTE.CODIGO NOT IN (SELECT PRODUCTO.codigo_fabricante FROM PRODUCTO);

-- Subconsultas (En la cláusula HAVING)
-- 1. Devuelve un listado con todos los nombres de los fabricantes que tienen el mismo número de productos que el fabricante Lenovo.
-- SELECT FABRICANTE.nombre FROM FABRICANTE WHERE (SELECT COUNT(PRODUCTO.codigo_fabricante) FROM PRODUCTO WHERE PRODUCTO.codigo_fabricante = FABRICANTE.codigo) =
-- (SELECT COUNT(PRODUCTO.codigo_fabricante) FROM PRODUCTO WHERE PRODUCTO.codigo_fabricante = (SELECT codigo FROM FABRICANTE WHERE nombre = ('Lenovo')));

SELECT fabricante.codigo, fabricante.nombre Fabricante, count(producto.codigo_fabricante) Prod_por_Fabricantes  FROM producto RIGHT JOIN fabricante 
on producto.codigo_fabricante = fabricante.codigo GROUP BY fabricante.nombre
HAVING count(fabricante.nombre)=(select count(producto.codigo_fabricante ) FROM producto RIGHT JOIN fabricante 
on producto.codigo_fabricante = fabricante.codigo where fabricante.nombre='Lenovo') ;
