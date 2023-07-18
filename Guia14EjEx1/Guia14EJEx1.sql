-- 1. Mostrar el nombre de todos los jugadores ordenados alfabéticamente.
SELECT Nombre FROM JUGADORES ORDER BY Nombre ASC;
-- 2. Mostrar el nombre de los jugadores que sean pivots (‘C’) y que pesen más de 200 libras,
-- ordenados por nombre alfabéticamente.
SELECT Nombre, Posicion, Peso FROM JUGADORES WHERE Posicion LIKE 'C' AND Peso > 200 ORDER BY Nombre ASC;
-- 3. Mostrar el nombre de todos los equipos ordenados alfabéticamente.
SELECT Nombre FROM EQUIPOS ORDER BY Nombre;
-- 4. Mostrar el nombre de los equipos del este (East).
SELECT Nombre FROM EQUIPOS WHERE Conferencia = ('East');
-- 5. Mostrar los equipos donde su ciudad empieza con la letra ‘c’, ordenados por nombre.
SELECT Nombre, Ciudad FROM EQUIPOS WHERE Ciudad LIKE ('C%') ORDER BY Nombre;
-- 6. Mostrar todos los jugadores y su equipo ordenados por nombre del equipo.
SELECT Nombre, Nombre_equipo FROM JUGADORES ORDER BY Nombre;
-- 7. Mostrar todos los jugadores del equipo “Raptors” ordenados por nombre.
SELECT *, Nombre_equipo FROM JUGADORES WHERE Nombre_equipo = ('Raptors') ORDER BY Nombre;
-- 8. Mostrar los puntos por partido del jugador ‘Pau Gasol’.
SELECT J.Nombre, E.Puntos_por_partido FROM ESTADISTICAS E INNER JOIN JUGADORES J WHERE E.jugador = J.codigo AND J.Nombre = ('Pau Gasol');
-- 9. Mostrar los puntos por partido del jugador ‘Pau Gasol’ en la temporada ’04/05′.
SELECT J.Nombre, E.Puntos_por_partido, E.temporada FROM ESTADISTICAS E INNER JOIN JUGADORES J WHERE E.jugador = J.codigo AND J.Nombre = ('Pau Gasol') AND E.temporada = ('04/05');
-- 10. Mostrar el número de puntos de cada jugador en toda su carrera.
SELECT E.jugador, J.Nombre, ROUND(SUM(E.Puntos_por_partido)) PUNTOS_TOTALES FROM ESTADISTICAS E INNER JOIN JUGADORES J WHERE E.jugador = J.codigo GROUP BY E.jugador;
-- 11. Mostrar el número de jugadores de cada equipo.
SELECT COUNT(Nombre), Nombre_equipo FROM JUGADORES GROUP BY Nombre_equipo;
-- 12. Mostrar el jugador que más puntos ha realizado en toda su carrera.
SELECT E.jugador, J.Nombre, ROUND(SUM(E.Puntos_por_partido)) PUNTOS_TOTALES FROM ESTADISTICAS E INNER JOIN JUGADORES J WHERE E.jugador = J.codigo GROUP BY E.jugador ORDER BY SUM(E.Puntos_por_partido) DESC LIMIT 1;
-- 13. Mostrar el nombre del equipo, conferencia y división del jugador más alto de la NBA.
SELECT J.Nombre, EQ.Nombre, EQ.Conferencia, EQ.Division FROM JUGADORES J INNER JOIN EQUIPOS EQ WHERE J.Nombre_equipo = EQ.Nombre AND J.Altura = (SELECT Altura FROM JUGADORES ORDER BY Altura DESC LIMIT 1);
-- 14. Mostrar el partido o partidos (equipo_local, equipo_visitante y diferencia) con mayor diferencia de puntos.
SELECT codigo, equipo_local, puntos_local, equipo_visitante, puntos_visitante, ABS(puntos_local - puntos_visitante) DIFERENCIA FROM PARTIDOS ORDER BY DIFERENCIA DESC LIMIT 10;
-- 15. Mostrar quien gana en cada partido (codigo, equipo_local, equipo_visitante, equipo_ganador), en caso de empate sera null.
select *,   if (puntos_visitante > puntos_local, equipo_visitante,  -- if
			if (puntos_visitante < puntos_local, equipo_local, 		-- else if
			null)) 													-- else
as equipo_ganador
from partidos;

select *,
	case																-- switch
		when puntos_local > puntos_visitante then equipo_local			-- case1, then (es la funcion)
		when puntos_local < puntos_visitante then equipo_visitante 		-- case2, then (es la funcion)
        else null														-- else = default 
	end																	-- llave de cierre de switch // break
	as equipo_ganador
	from partidos;