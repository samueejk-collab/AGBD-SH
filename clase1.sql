
1- SELECT * FROM INHABITANT
--Seleccionar de la lista de inhabitant
2- SELECT * FROM INHABITANT WHERE state LIKE "friendly"
--Seleccionar de la lista de inhabitant donde estado sea friendly
3- SELECT * FROM INHABITANT WHERE state LIKE "friendly" and job = "weaponsmith"
--Seleccionar de la lista de inhabitant donde estado sea fiendly y trabaje de weaponsmith
4- SELECT * FROM INHABITANT WHERE state LIKE "friendly" and job LIKE '%smith'
--Seleccionar de la lista de inhabitant donde estado sea friendly y el nombre de su trabajo termine con smith
5- SELECT personid FROM INHABITANT WHERE NAME = "Stranger"
--Seleccionar personid de la lista de inhabitant donde nombre sea stranger
6- SELECT gold FROM INHABITANT WHERE NAME ="Stranger"
--Seleccionar oro de la lista de inhabitant donde nommbre coincida con stranger
7- SELECT * FROM ITEM WHERE owner IS NULL
--Seleccionar de la lista de item donde owner es null
8- UPDATE item SET owner = 20 WHERE owner IS NULL
--Actualizar lista item. el owner 20 donde owner sea null
9- SELECT * FROM ITEM WHERE owner = "20"
--Seleccionar de la lista item donde owner sea igual a 20
10-SELECT * FROM INHABITANT WHERE state LIKE "Friendly" and JOB = "dealer" or JOB = "merchant"
--Seleccionar de la lista de inhabitant donde el estado sea friendly(amistoso) y job(trabajo) sea dealer  o merchant
11-UPDATE item SET owner = 15 WHERE item = "teapot" or item = "ring"
--Actualizar de la lista item, donde el item sea dueño 15, los items teapot y ring
12-UPDATE INHABITANT SET NAME = "MIKU" WHERE NAME = "Stranger" 
--Actualizar de la lista inhabitant el nombre a miku donde habia stranger 
13-SELECT * FROM INHABITANT WHERE job LIKE "Baker" ORDER BY gold DESC 
--Seleccionar de la lista inhabitant quiienes trabajen de cocinero en orden decendiente de acuerdo al oro 
14-SELECT * FROM INHABITANT WHERE job LIKE "pilot"
--Seleccionar de la lista inhabitant quien trabaje de piloto
15-SELECT NAME FROM INHABITANT WHERE personid = "13"
--Seleccionar de columna name de lista inhabitant donde personid sea 13
16-SELECT COUNT(*) FROM inhabitant, village WHERE village.villageid = inhabitant.villageid and village.name = 'Onionville' and inhabitant.gender LIKE "f"
-- un Contador de la lista inhabitant y village, donde el villageid(el id de la lista village) coincida con inhabitant.villageid(de la lista inhabitant) ademas de que de que el nombre del puedblo sea onionville y que sea mujer
17-SELECT inhabitant.name FROM inhabitant, village WHERE village.villageid = inhabitant.villageid and village.name = 'Onionville' and inhabitant.gender LIKE "f"
--Seleccionar de la lista inhabitant y village el nombre donde los ids coincidan y el nombre delpueblo sea onionville y sea mujer 
18-SELECT SUM(inhabitant.gold) FROM inhabitant WHERE inhabitant.job = "baker" or inhabitant.job ="dealer" or inhabitant.job ="merchant"
--Suma de el oro de la lista de inhabitant de quienes trabajen de baker o dealer o merchant
19-SELECT state, AVG(inhabitant.gold) FROM inhabitant GROUP BY state ORDER BY AVG(inhabitant.gold)
--Seleccionar segun el estadp y el oro de la lista inhabitant, ordenar segun la cant de oro que tengan ()order by)
20-DELETE FROM inhabitant WHERE name = 'Dirty Diane'
--Seleccionar de inhabitant donde nombre sea dirty diane 
21-UPDATE INHABITANT SET STATE = "friendly" WHERE job = "pilot" 
--Actuazliza lista inhabitant el estadofriendly donde job(trabajo) sea piloto
