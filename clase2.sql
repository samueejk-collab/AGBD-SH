-- 26 de marzo de 2026
SELECT * FROM  'crime_scene_report'
SELECT * FROM  'crime_scene_report' where date = "20180115" and type = "murder" and city = "SQL City"
Security footage shows that there were 2 witnesses. The first witness lives at the last house on "Northwestern Dr". The second witness, named Annabel, lives somewhere on "Franklin Ave".
SELECT * FROM 'person' where address_street_name = "Northwestern Dr" order by address_number DESC

SELECT * FROM 'interview' where person_id = "14887"  

I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. The membership number on the bag started with "48Z". Only gold members have those bags. The man got into a car with a plate that included "H42W"


SELECT * FROM "get_fit_now_member" where id LIKE "48Z%"  and membership_status = "gold"

id	  person_id	name	 membership_start_date	membership_status
48Z7A	28819	Joe Germuska	20160305	         gold
48Z55	67318	Jeremy Bowers	20160101	         gold

/ /desde aca se puede usar JOIN
// hasta encontrar a jeremy 

SELECT * FROM "drivers_license" where plate_number LIKE "%H42W%"

id	  age height eye_color	hair gender	 plate_number	car_make	car_model
183779	21	65	blue	 blonde	 female	 H42W0X	      Toyota	Prius
423327	30	70	brown	 brown	 male	 0H42W2       Chevrolet	Spark LS
664760	21	71	black	 black	 male	 4H42WR	       Nissan	Altima

id	      name	     license_id	address_number	address_street_name	       ssn
67318	Jeremy Bowers	423327	     530	    Washington Pl, Apt 3A	 871539279

SELECT * FROM "interview" where person_id LIKE "67318" 
person_id	transcript
67318	I was hired by a woman with a lot of money. I don't know her name but I know she's around 5'5" (65") or 5'7" (67"). She has red hair and she drives a Tesla Model S. I know that she attended the SQL Symphony Concert 3 times in December 2017. 

INSERT INTO solution VALUES (1, 'Jeremy Bowers');
        
        SELECT value FROM solution;

value
Congrats, you found the murderer! But wait, there's more... If you think you're up for a challenge, try querying the interview transcript of the murderer to find the real villain behind this crime. If you feel especially confident in your SQL skills, try to complete this final step with no more than 2 queries. Use this same INSERT statement with your new suspect to check your answer.

SELECT * FROM "drivers_license" where hair_color LIKE "red" and gender = "female" and car_model = "Model S" and  

  id	age	height	eye_color hair_color	gender	plate_number	car_make	car_model
202298	68	66	   green	   red	        female	    500123	         Tesla	     Model S
291182	65	66	   blue	       red	        female	    08CM64	         Tesla	     Model S
918773	48	65	   black	   red	        female      917UU3           Tesla       Model S
       