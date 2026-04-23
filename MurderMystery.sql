-- 26 de marzo de 2026

SELECT * FROM 'crime_scene_report';
--Muestra toda la tabla crime_scene_report

SELECT * FROM 'crime_scene_report' WHERE date = "20180115" AND type = "murder" AND city = "SQL City";
--Busca asesinatos en SQL City que hayan ocurrido el esa fecha

SELECT * FROM 'person' WHERE address_street_name = "Northwestern Dr" ORDER BY address_number DESC
--Encuentra la persona que vive en la ultima casa de la calle Northwestern

SELECT * FROM 'interview' WHERE person_id = "14887"
--De la tabla de "interview" muestra la entrevista del testigo con el id 14887

--ENTREVISTA:
--I heard a gunshot and then saw a man run out
--He had a "Get Fit Now Gym" bag. The membership number on the bag started with "48Z".
--Only gold members have those bags.
--The man got into a car with a plate that included "H42W"

SELECT * FROM 'get_fit_now_member' WHERE id LIKE "48Z%" AND membership_status = "gold"
-- Selecciona de la tabla get_fit_now_member los miembros que tengan membresia gold y su ID que empiece con 48Z%

SELECT 'get_fit_now_member'.id, 'get_fit_now_member'.name AS nombre_miembro, 'person'.name AS nombre_persona,
'person'.id AS id_persona
FROM 'get_fit_now_member' JOIN 'person' ON 'get_fit_now_member'.person_id = 'person'.id 
WHERE 'get_fit_now_member'.id LIKE "48Z%" AND 'get_fit_now_member'.membership_status = "gold"
--con JOIN se une la tabla de miembros del gimnasio con la de personas
--para ver los nombres e id de los sospechosos 

SELECT * FROM 'drivers_license' WHERE plate_number LIKE "%H42W%"
--Busca en la tabla de licencias todas las  patentes que contienen H42W
--
SELECT 'person'.name, 'drivers_license'.plate_number , 'drivers_license'.car_make, 'drivers_license'.car_model 
FROM 'person' JOIN 'drivers_license' ON 'person'.license_id = 'drivers_license'.id
WHERE 'drivers_license'.plate_number LIKE "%H42W%"
-- Con JOIN se une la tabla person con drivers_license para ver quienes coinciden con esa patente, lo cual reduce los sospechosos entre ellos jeremy bowers

SELECT 'person'.name,'interview'.transcript
FROM 'person' JOIN 'interview' ON 'person'.id = 'interview'.person_id 
WHERE 'person'.name = "Jeremy Bowers"
-- con JOIN se une la tabla person con interview para ver la entrevista de Jeremy Bowers y este termina confesando

INSERT INTO solution VALUES (1, "Jeremy Bowers");
        
        SELECT value FROM solution;

--SENTENCIA:
--Congrats, you found the murderer! But wait, there's more...
--If you think you're up for a challenge, try querying the interview transcript of the murderer to find the real villain behind this crime.
--If you feel especially confident in your SQL skills, try to complete this final step with no more than 2 queries. 
--Use this same INSERT statement with your new suspect to check your answer.

SELECT `get_fit_new_check_in'.member