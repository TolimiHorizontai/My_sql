/* ----------------------- PostgreSQL customers db: ------------------------*/

select *
from public.customer;

select Count (customer_id)
from public.customer;

select count(*) 
from public.customer
group by store_id;

select store_id, count (customer_id)
from public.customer
group by store_id;

select last_name
from public.customer
order by last_name asc;

--vidutinė mookėjimų už filmų nuomą suma:
select avg(rental_rate)
from public.film;

--didžiausia mokėjimų už filmų nuomą suma:
select max(rental_rate)
from public.film;

--mažiausia mokėjimų už filmų nuomą suma:
select min(rental_rate)
from public.film;

--Kitas būdas min ir max,
--Min:
select rental_rate
from public.film
order by rental_rate asc
limit 1;

--Max:
select rental_rate
from public.film
order by rental_rate desc
limit 1;

--Visi vienoje užklausoje:
select MIN(rental_rate), MAX(rental_rate), AVG(rental_rate)
from public.film;

select avg(rental_rate)
from public.film
where rating = 'R';

select count(*)
from public.film
where rating = 'PG-13' and rental_rate > 3;

select count(*)
from public.film
where rating = 'R' or rental_rate < 3;

--tvarkingas išdėstymas pagal id:
select * 
from public.film
where title like 'A%'
order by film_id;

--kitas būdas:
select * 
from public.film
where title like 'A%';

--dar vienas būdas:
select title 
from public.film
where title like 'A%';

--Kuriais metais/mėnesį/dieną paskutinį kartą buvo atnaujinta informacija apie darbuotojus?
select DATE_PART('year',last_update) as metai, Date_PART('month', last_update) as menuo, 
Date_PART('day', last_update) as diena
from public.staff;

--Kiek adresų lentoje yra rajonų (district), kurių pavadinimai prasideda A raide? Su COUNT (DISTINCT) ir UPPER...

select count(DISTINCT district) as district_A
from public.address
where district like 'A%';

select COUNT(DISTINCT(UPPER (district)))
from public.address
where district like 'A%';

select count(district) as district_A
from public.address
where UPPER(district) like 'A%';

--3 pamoka. Visos praktinės užduotys.

-- Kurių filmų inventoriaus (pagal ID) antrojoje parduotuvėje yra daugiau nei trys vienetai? 

select count(inventory_id) as vienetu_sk, film_id 
from public.inventory
where store_id=2
group by film_id
having count (film_id)>3;


--Kokios yra pirmosios trys filmų kalbų raides? (paverskite jas didžiosiomis)(keli variantai):

--1)
select name, UPPER(SUBSTRING(name, 1, 3)) 
from public.language;

--2)
select name, UPPER(SUBSTRING(name, 1, 3)) as Kalbos_trumpinys
from public.language;

--3)
select UPPER (name), UPPER(SUBSTRING(name, 1, 3)) 
from public.language;

--4)
select UPPER (name), UPPER(SUBSTRING(name, 1, 3)) as Kalbos_trumpinys
from public.language;

--Kuriais metais/mėnesį/dieną paskutinį kartą buvo atnaujinta informacija apie darbuotojus?
select last_update
from public.staff;


--Ištraukite darbuotojų elektroninio pašto adresus (mažosiomis raidėmis)

--1)
select LOWER(email)
from public.staff;

--2)su 'as'..
select LOWER(email) as lower_email
from public.staff;


--Koks vidutinis darbuotojų elektroninio pašto adreso ilgis? (suapvalinkite iki sveikųjų dalių)
--1):
select ROUND(AVG(length(email)))
from public.staff;

--2):
select ROUND(AVG(length(email))) as Round_email_length
from public.staff;


--Kiek yra filmų, kuriuos reikės gražinti tarp 27 ir 30 mėnesio dienos? 
--1):
select count(DATE_PART('day', return_date)) 
from public.rental
where DATE_PART('day', return_date) between 27 and 30;

--2):
select count(DATE_PART('day', return_date)) as return_day_27_30
from public.rental
where DATE_PART('day', return_date) between 27 and 30;


--Kokia vidutinė bauda gresia už filmų negrąžinimą grupuojant juos pagal reitingą? (suapvalinkite iki šimtųjų dalių)
select ROUND(AVG(replacement_cost), 2) as AVG_RPL_cost, rating
from public.film
group by rating;


--Kiek adresų lentoje yra rajonų (district), kurių pavadinimai prasideda A raide?
select count(district) as district_A
from public.address
where district like 'A%';


--Ištraukite miestų ir šalių pavadinimus
select city, country
from public.city as cityname
inner join public.country as countryname on countryname.country_id=cityname.country_id;


--Ištraukite filmų pavadinimus ir jų kategorijas
select title, name
from public.film as films
inner join public.film_category as filmcategory on filmcategory.film_id=films.film_id
inner join public.category as categories on categories.category_id=filmcategory.category_id;


--Ištraukite aktorių vardus, pavardes ir kokiuose filmuose jie vaidino 
select first_name, last_name, title
from public.actor as actorname
inner join public.film_actor as actorid on actorid.actor_id=actorname.actor_id
inner join public.film as films on films.film_id=actorid.film_id;

-- 4 pamoka praktinės užduotys

-- 1)Ištraukite miestų ir šalių pavadinimus

select city, country
from public.city as cities
inner join public.country as countries
on cities.country_id = countries.country_id;

select cit.city, ctr.country
from public.city as cit
left join public.country as ctron cit.country_id = ctr.country_id;

-- 2) Ištraukite filmų pavadinimus ir jų kategorijas

select name, title
from public.category as categories
inner join public.film_category as filmcategory on filmcategory.category_id = categories.category_id
inner join public.film as movies on filmcategory.film_id = movies.film_id;

select title, name
from public.film as flm
left join public.film_category as flmcat on flm.film_id = flmcat.film_id
left join public.category as cat cat.category_id = flmcat.category_id;

-- 3)Ištraukite aktorių vardus, pavardes ir kokiuose filmuose jie vaidino

select first_name as actorname,
last_name as actorlastname, title
from  public.actor as actors
inner join public.film_actor as filmactor on filmactor.actor_id = actors.actor_id
inner join public.film as films on films.film_id = filmactor.film_id;

select act.first_name as actorname,
last_name as actorlastname, title
from  public.actor as act
left join public.film_actor as filmactor on filmactor.actor_id = act.actor_id
left join public.film as films on films.film_id = filmactor.film_id;


-- 4)Kiek yra filmų grupuojant juos pagal kategorijas?

select count(title) as filmu_skaicius, name as kategorijos_pavadinimas
from public.film as films
inner join public.film_category as filmcategory on filmcategory.film_id = films.film_id
inner join public.category as categories on categories.category_id = filmcategory.category_id
group by name;

select name as pavadinimas, count(title) as filmu_skaicius
from public.film as films
inner join public.film_category as filmcategory on filmcategory.film_id = films.film_id
inner join public.category as categories on categories.category_id = filmcategory.category_id
group by name;

-- 5)Kokia kalba sukurti filmai vidutiniškai ilgiausi pagal trukmę?

select MAX(length), name
from public.film as films
inner join public.language as kalbos on kalbos.language_id = films.language_id
group by name;

select ROUND(AVG(length),2), name
from public.film as films
inner join public.language as kalbos on kalbos.language_id = films.language_id
group by name
order by name desc
limit 1;

select lan.language, avg(flm.length)
from public.film as flm
inner join public.language as lan on flm.language_id = lan.language_idgroup by lan.name;

select lan.language, round(avg(flm.length), 2)
from public.film as lan
full join public.film as flm on flm.language_id = lan.language_id 
group by lan.name;

--Ištraukite stulpelius su aktorių vardais ir nurodykite, kurie iš jų yra ‘short’ 
--(mažiau, nei šešios raidės) ir ‘long’ (daugiau, arba lygu šešioms raidėms). 
--Priešingu atveju nurodykite ‘unknown’

select 
	case 
	when length(first_name)<6 then 'short'
	when length(first_name)>=6 then 'long'
	else 'unknown'
	end as vardo_ilgis
from public.actor;

select first_name,
	case 
	when length(first_name)<6 then 'short'
	when length(first_name)>=6 then 'long'
	else 'unknown'
	end as vardo_ilgis
from public.actor;


select first_name,
	case 
	when length(first_name)<6 then 'short'
	when length(first_name)>=6 then 'long'
	else 'unknown'
	end as vardo_ilgis
from public.actor
group by 
case 
	when length(first_name)<6 then 'short'
	when length(first_name)>=6 then 'long'
	else 'unknown'
	end;

--Suskaičiuokite, kiek yra filmų, kuriuos galima išsinuomoti ilgiau, nei keturias dienas?

select count(
	case 
	when rental_duration > 4 then 1 

	end) as daugiau_4
from public.film;

--šitas neveikia:
select sum(
	case 
	when rental_duration > 4 then 1 else 0 
	end) count(*)
from public.film;


select count(*)
from public.film
where rental_duration > 4;

select sum(case when rental_duration > 4 then 1 else 0 end),
count (*) * 1,0,
round ((sum(case when rental_duration > 4 then 1 else 0 end))/(count(*)*1,0),2)
from public.film;


--Šalia filmo pavadinimo, nurodykite tris patinkančių filmų kategorijas (‘patinka’). 
--Priešingu atveju nurodykite ‘nepatinka’

select flm.title, cat.name,

case 
when cat.name = 'Family' then 'patinka'
when cat.name = 'Action' then 'patinka'
when cat.name = 'Comedy' then 'patinka'
else 'nepatinka' end as Patinka

from public.film as flm
left join public.film_category as ctg
on ctg.film_id = flm.film_id
left join public.category as cat
on ctg.category_id = cat.category_id
;


select flm.title, cat.name,
case 
when cat.name in ('Music', 'Drama', 'Comedy') then 'patinka'
else 'nepatinka' end as Įvertinimas
from public.film as flm
left join public.film_category as ctg
on ctg.film_id = flm.film_id
left join public.category as cat
on ctg.category_id = cat.category_id
;

--Kiek atliktų mokėjimų yra didesni, nei 6 doleriai? 

select count(
	case
	when amount > 6 then 1
	
	end) as didesni_nei6_mokėjimai
from public.payment;

select 
sum (case when amount > 6 then 1 else 0 end),
count (amount)
from public.payment;

select count(*)
from public.payment
where amount > 6;


/* --------------------  departments db: -------------------- */

select
	CASE 
	when empl.dep_id = 1 THEN 'Monika'
	
	when empl.dep_id = 2 THEN 'Aidas'

	when empl.dep_id = 3 THEN 'Vaidas'
	ELSE 'unlisted'
	END as "Manager", 
	round(AVG(empl.salary), 0) as "Amount"
	

from public.employees as empl 

group by empl.dep_id
order by empl.dep_id asc;

/*xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx*/

/*Teisingas sprendimas:*/

select mgr.name as "Manager",  round(avg(e.salary), 0) as "Amount"

from public.employees as e

left join public.departments as d
	on d.id=e.dep_id
	
left join public.employees as mgr
	on d.mgr_id=mgr.id
	
group by e.dep_id, mgr.name;

/*xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx*/

Select e.id as "employee id", d.location as "Location"
from public.employees as empl
left join public.departments as d on empl.dep_id=d.id
left join public.employees as e on d.mgr_id=e.id
group by e.id, d.location, d.mgr_id;

Select e.id as "employee id", d.location as "Location"
from public.employees as empl
inner join public.departments as d on empl.dep_id=d.id
left join public.employees as e on d.mgr_id=e.id
group by e.id, d.location, d.mgr_id;


Select e.id as "employee id", d.location as "Location"
from public.employees as empl
inner join public.departments as d on empl.dep_id=d.id
inner join public.employees as e on d.mgr_id=e.id
group by e.id, d.location, d.mgr_id;

Select e.id as "employee id", d.location as "Location"
from public.employees as empl
full join public.departments as d on empl.dep_id=d.id
inner join public.employees as e on d.mgr_id=e.id
group by e.id, d.location, d.mgr_id;


select count (dep.id) as "# departments"
from public.departments dep
inner join public.employees e on dep.mgr_id=e.id
where dep.mgr_id!=e.id;


select count (dep.id) as "# departments"
from public.departments dep
inner join public.employees e on dep.mgr_id=e.id
where dep.id!=e.dep_id;


select count (dep.mgr_id) as "# departments"
from public.departments dep
inner join public.employees e on dep.mgr_id=e.id
where dep.id!=e.dep_id;   