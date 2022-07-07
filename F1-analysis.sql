CREATE DATABASE Formula1;
USE Formula1;

-- Drivers by nationality, exported as f1driversnation.csv
SELECT nationality, count(code) from drivers group by nationality order by count(code) desc;


-- Drivers and constructors ranking after each race for 2012 season, 
-- exported as F1RaceTimeline2012.csv
SELECT results.raceId, year ,races.name, forename, surname,  constructors.name, finishingPosition, points 
from results JOIN drivers on results.driverId = drivers.driverId 
JOIN constructors on results.constructorId = constructors.constructorId
JOIN races on results.raceID = races.raceId
where races.year = 2012 ORDER BY raceID ASC, finishingPosition ASC ;

-- Drivers and constructors ranking after each race for 2007 season, 
-- exported as F1RaceTimeline2007.csv
SELECT results.raceId, year ,races.name, forename, surname,  constructors.name, finishingPosition, points 
from results JOIN drivers on results.driverId = drivers.driverId 
JOIN constructors on results.constructorId = constructors.constructorId
JOIN races on results.raceID = races.raceId
where races.year = 2007 ORDER BY raceID ASC, finishingPosition ASC ;

-- Drivers and constructors ranking after each race for 2007 season, 
-- exported as F1RaceTimeline2007.csv
SELECT results.raceId, year ,races.name, concat(forename,' ', suraname) as Drivername,  constructors.name, finishingPosition, points 
from results JOIN drivers on results.driverId = drivers.driverId 
JOIN constructors on results.constructorId = constructors.constructorId
JOIN races on results.raceID = races.raceId
where races.year = 2007 ORDER BY raceID ASC, finishingPosition ASC ;

-- Drivers and constructors ranking after each race for 1984
SELECT results.raceId, year ,races.name, forename, surname,  constructors.name, finishingPosition, points 
from results JOIN drivers on results.driverId = drivers.driverId 
JOIN constructors on results.constructorId = constructors.constructorId
JOIN races on results.raceID = races.raceId
where races.year = 1984 ORDER BY raceID ASC, finishingPosition ASC ;

-- Drivers and constructors ranking after each race from every season, 
-- exported as F1EveryRace.csv
SELECT results.raceId, year ,races.name, forename, surname,  constructors.name as Constructors, finishingPosition, points 
from results JOIN drivers on results.driverId = drivers.driverId 
JOIN constructors on results.constructorId = constructors.constructorId
JOIN races on results.raceID = races.raceId
Group by races.year, results.raceId, races.name,forename, surname,  constructors.name, finishingPosition, points ORDER BY raceID ASC, finishingPosition ASC ;

-- 2012 qualifying times, exported as F1Qual2012.csv
SELECT qualifying.raceId, year ,races.name, forename, surname, q3, constructors.name, position
from qualifying JOIN drivers on qualifying.driverId = drivers.driverId 
JOIN constructors on qualifying.constructorId = constructors.constructorId
JOIN races on qualifying.raceID = races.raceId
where races.year = 2012 ORDER BY raceID ASC, position ASC ;

-- fastest seasons at the historic silverstone, monza, spa, and monaco per qualifying lap
-- exported as F1QualyAllFastest.csv
SELECT races.year, circuits.circuitRef, circuits.circuitName, position, q1, q2, q3
from races JOIN circuits on races.circuitId = circuits.circuitId
JOIN qualifying on races.raceId = qualifying.raceId
WHERE circuits.circuitRef IN ('monaco', 'spa', 'monza', 'silverstone') 
and position =1 ORDER BY year ASC;
 
-- now by fastest lap in the race, exported as F1RaceFastestLap.csv
SELECT * from results;
SELECT races.year, circuits.circuitRef, circuits.circuitName, min(fastestLapTime) as FastestLap
from races JOIN circuits on races.circuitId = circuits.circuitId
JOIN results on races.raceId = results.raceId
WHERE circuits.circuitRef IN ('monaco', 'spa', 'monza', 'silverstone') and fastestLapTime is not null
group by circuits.circuitName,circuitRef, year
ORDER BY year ASC;

-- due to this data set not having fastest laps for anything before 1994 (Qual) and 2004 (Races),
-- I will follow up with python scraping


-- Which races had American drivers, exported as F1 American timeline
select distinct(year), circuits.circuitName as 'Circuit Name', count(distinct(results.driverId)) as 'Number of American Drivers' from races 
join results on races.raceId = results.raceId join circuits on races.circuitId = circuits.circuitId
join drivers on results.driverId = drivers.driverId where nationality = 'American' 
group by year, circuits.circuitName  order by year;

-- Names of F1 Drivers that participated outside of Indy 500
select Distinct(results.driverId), concat(forename, ' ',surname) as Name from races 
join results on races.raceId = results.raceId join circuits on races.circuitId = circuits.circuitId
join drivers on results.driverId = drivers.driverId where nationality = 'American' 
and circuitName != 'Indianapolis Motor Speedway';

-- How many are there?
select count(Distinct(results.driverId)) from races 
join results on races.raceId = results.raceId join circuits on races.circuitId = circuits.circuitId
join drivers on results.driverId = drivers.driverId where nationality = 'American' 
and circuitName != 'Indianapolis Motor Speedway';

-- there are 4 drivers, with driverIds (667, 680, 693, 737), without names, let's see which races/years they drove
select results.driverId, concat(forename, ' ',surname) as Name, circuitName, year from races 
join results on races.raceId = results.raceId join circuits on races.circuitId = circuits.circuitId
join drivers on results.driverId = drivers.driverId where nationality = 'American' 
and circuitName != 'Indianapolis Motor Speedway' and results.driverId In(680) order by year;
-- 680 is amystery
-- Who is 680, explore by seeing how they finished
select results.driverId, circuitName, number, finishingPosition, year from races 
join results on races.raceId = results.raceId join circuits on races.circuitId = circuits.circuitId
join drivers on results.driverId = drivers.driverId where nationality = 'American' 
and circuitName != 'Indianapolis Motor Speedway' and results.driverId In(680) order by year;

-- 680 is a Belgian Driver, Jacques Swaters
-- Let's see if he is listed under the Belgian driver list
select Distinct(results.driverId), concat(forename, ' ',surname) as Name from races 
join results on races.raceId = results.raceId join circuits on races.circuitId = circuits.circuitId
join drivers on results.driverId = drivers.driverId where nationality = 'Belgian' 
and circuitName != 'Indianapolis Motor Speedway';
-- no they are not, so let's update it
SELECT * from drivers where driverId = 680;
SET SQL_SAFE_UPDATES = 0;
UPDATE drivers SET driverRef = 'swaters', code  = 'SWT', forename = 'Jacques', surname ='Swaters', 
nationality ='Belgian' where driverId = 680;

-- Check our work
SELECT * from drivers where driverId = 680;

-- Now let's add the info in for these 3
-- 693 = Fred Wacker
-- 737 = Robert O'Brien who only participated in one F1 race, Spa
-- 667 = John Fitch who only participatted in 2 F1 races, '53 and '55 Monza
UPDATE drivers SET driverRef = 'wacker', code  = 'WAK', forename = 'Fred', surname ='Wacker'
 where driverId = 693;
 
UPDATE drivers SET driverRef = 'robrien', code  = 'rob', forename = 'Robert', surname ="O'Brien"
 where driverId = 737;

UPDATE drivers SET driverRef = 'fitch', code  = 'FIT', forename = 'John', surname ='Fitch'
 where driverId = 667;
 
-- now to check our work
SELECT * from drivers where driverId IN (693, 737, 667);

-- Number of non-indy 500 American drivers throught the years
select year, count(distinct(results.driverId)) as 'Number of American Drivers' from races 
join results on races.raceId = results.raceId join circuits on races.circuitId = circuits.circuitId
join drivers on results.driverId = drivers.driverId where nationality = 'American' 
and circuitName != 'Indianapolis Motor Speedway' group by year order by year;
