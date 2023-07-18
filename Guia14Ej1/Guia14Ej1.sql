-- 1. Obtener los datos completos de los empleados.
SELECT * FROM EMPLEADOS;
-- 2. Obtener los datos completos de los departamentos.
SELECT * FROM DEPARTAMENTOS;
-- 3. Listar el nombre de los departamentos.
SELECT nombre_depto FROM DEPARTAMENTOS;
-- 4. Obtener el nombre y salario de todos los empleados.
SELECT nombre, sal_emp FROM EMPLEADOS;
-- 5. Listar todas las comisiones.
SELECT comision_emp FROM EMPLEADOS;
-- 6. Obtener los datos de los empleados cuyo cargo sea ‘Secretaria’.
SELECT * FROM EMPLEADOS WHERE cargo_emp IN ('SECRETARIA');
-- 7. Obtener los datos de los empleados vendedores, ordenados por nombre alfabéticamente.
SELECT * FROM EMPLEADOS WHERE cargo_emp IN ('VENDEDOR') ORDER BY nombre;
-- 8. Obtener el nombre y cargo de todos los empleados, ordenados por salario de menor a mayor.
SELECT nombre, cargo_emp, sal_emp FROM EMPLEADOS ORDER BY sal_emp;
-- 9. Obtener el nombre de o de los jefes que tengan su departamento situado en la ciudad de “Ciudad Real”
SELECT nombre_jefe_depto, ciudad FROM DEPARTAMENTOS WHERE ciudad IN ('CIUDAD REAL'); 
-- 10. Elabore un listado donde para cada fila, figure el alias ‘Nombre’ y ‘Cargo’ para las respectivas tablas de empleados.
SELECT id_emp, nombre NOMBRE, sex_emp, fec_nac, fec_incorporacion, sal_emp, comision_emp, cargo_emp CARGO, id_depto FROM EMPLEADOS;
-- 11. Listar los salarios y comisiones de los empleados del departamento 2000, ordenado por comisión de menor a mayor.
SELECT nombre, sal_emp, comision_emp, id_depto FROM EMPLEADOS WHERE id_depto = (2000) ORDER BY comision_emp;
/* 12. Obtener el valor total a pagar a cada empleado del departamento 3000, que resulta
de: sumar el salario y la comisión, más una bonificación de 500. Mostrar el nombre del
empleado y el total a pagar, en orden alfabético.*/
SELECT nombre NOMBRE, id_depto, sal_emp SALARIO , comision_emp COMISION, (sal_emp + comision_emp + 500) TOTAL_A_PAGAR FROM EMPLEADOS WHERE id_depto = (3000) ORDER BY nombre;
-- 13. Muestra los empleados cuyo nombre empiece con la letra J.
SELECT id_emp, nombre FROM EMPLEADOS WHERE nombre LIKE ('J%');
-- 14. Listar el salario, la comisión, el salario total (salario + comisión) y nombre, de aquellos empleados que tienen comisión superior a 1000. 
SELECT nombre NOMBRE, sal_emp SALARIO, comision_emp COMISION, (sal_emp + comision_emp) SALARIO_TOTAL FROM EMPLEADOS WHERE comision_emp > (1000); 
-- 15. Obtener un listado similar al anterior, pero de aquellos empleados que NO tienen comisión.
SELECT nombre NOMBRE, sal_emp SALARIO, comision_emp COMISION, (sal_emp + comision_emp) SALARIO_TOTAL FROM EMPLEADOS WHERE comision_emp = (0); 
-- 16. Obtener la lista de los empleados que ganan una comisión superior a su sueldo.
SELECT nombre NOMBRE, comision_emp COMISION, sal_emp SALARIO FROM EMPLEADOS WHERE comision_emp > sal_emp;
-- 17. Listar los empleados cuya comisión es menor o igual que el 30% de su sueldo.
SELECT nombre NOMBRE, comision_emp COMISION, sal_emp SALARIO, (sal_emp * 0.30) '30%' FROM EMPLEADOS WHERE comision_emp <= (sal_emp * 0.30);
-- 18. Hallar los empleados cuyo nombre no contiene la cadena “MA”. 
SELECT id_emp ID, nombre NOMBRE FROM EMPLEADOS WHERE nombre NOT LIKE ('%MA%');
-- 19. Obtener los nombres de los departamentos que sean “Ventas”, “Investigación” o “Mantenimiento”.
SELECT id_depto ID, nombre_depto NOMBRE_DEPTO FROM DEPARTAMENTOS WHERE nombre_depto IN ('VENTAS', 'INVESTIGACION', 'MANTENIMIENTO');
-- 20. Ahora obtener el contrario, los nombres de los departamentos que no sean “Ventas” ni “Investigación” ni “Mantenimiento”.
SELECT id_depto ID, nombre_depto NOMBRE_DEPTO FROM DEPARTAMENTOS WHERE nombre_depto NOT IN ('VENTAS', 'INVESTIGACION', 'MANTENIMIENTO');
-- 21. Mostrar el salario más alto de la empresa.
SELECT id_emp ID, nombre NOMBRE, MAX(sal_emp) SALARIO FROM EMPLEADOS;
-- 22. Mostrar el nombre del último empleado de la lista por orden alfabético.
SELECT id_emp ID, MAX(nombre) NOMBRE FROM EMPLEADOS;
-- 23. Hallar el salario más alto, el más bajo y la diferencia entre ellos.
SELECT MAX(sal_emp) MAS_ALTO, MIN(sal_emp) MAS_BAJO, (MAX(sal_emp) - MIN(sal_emp)) DIFERENCIA FROM EMPLEADOS;
-- 24. Hallar el salario promedio por departamento.
SELECT id_depto, ROUND(AVG(sal_emp),2) PROMEDIO FROM EMPLEADOS GROUP BY id_depto;
-- Consultas con Having.
-- 25. Hallar los departamentos que tienen más de tres empleados. Mostrar el número de empleados de esos departamentos.
SELECT COUNT(id_depto) NRO_DE_EMPLEADOS, id_depto FROM EMPLEADOS GROUP BY id_depto HAVING COUNT(id_depto) > 3;
-- 26. Hallar los departamentos que no tienen empleados.
SELECT COUNT(id_depto) NRO_DE_EMPLEADOS, id_depto FROM EMPLEADOS GROUP BY id_depto HAVING COUNT(id_depto) = 0;
-- Consulta Multitabla (Uso de la sentencia JOIN/LEFT JOIN/RIGHT JOIN)
-- 27. Mostrar la lista de empleados, con su respectivo departamento y el jefe de cada departamento.
SELECT id_emp ID, nombre NOMBRE, cargo_emp CARGO, EMPLEADOS.id_depto ID_DTO, nombre_depto NOMBRE_DTO, DEPARTAMENTOS.nombre_jefe_depto NOMBRE_DE_JEFE FROM EMPLEADOS INNER JOIN DEPARTAMENTOS ON DEPARTAMENTOS.id_depto = EMPLEADOS.id_depto;
-- Consulta con Subconsulta.
-- 28. Mostrar la lista de los empleados cuyo salario es mayor o igual que el promedio de la empresa. Ordenarlo por departamento.
SELECT id_emp ID, nombre NOMBRE, sal_emp SALARIO, id_depto FROM EMPLEADOS WHERE sal_emp >= (SELECT ROUND(AVG(sal_emp),2) FROM EMPLEADOS) ORDER BY id_depto;
-- (promedio de salarios de la empresa)
SELECT ROUND(AVG(sal_emp),2) PROMEDIO FROM EMPLEADOS;
