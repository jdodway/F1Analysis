CREATE DATABASE Formula1;
USE Formula1;

-- Drivers by nationality
SELECT nationality, count(code) from drivers group by nationality order by count(code) desc;


-- Drivers and constructors ranking after each race for 2012 season
SELECT results.raceId, year ,races.name, forename, surname,  constructors.name, finishingPosition, points 
from results JOIN drivers on results.driverId = drivers.driverId 
JOIN constructors on results.constructorId = constructors.constructorId
JOIN races on results.raceID = races.raceId
where races.year = 2012 ORDER BY raceID ASC, finishingPosition ASC ;


-- 2012 qualifying times
SELECT qualifying.raceId, year ,races.name, forename, surname, q3, constructors.name, position
from qualifying JOIN drivers on qualifying.driverId = drivers.driverId 
JOIN constructors on qualifying.constructorId = constructors.constructorId
JOIN races on qualifying.raceID = races.raceId
where races.year = 2012 != '\N' ORDER BY raceID ASC, position ASC ;

-- fastest seasons at the historic silverstone, monza, spa, and monaco per qualifying lap
SELECT races.year, circuits.circuitRef, circuits.circuitName, position, q1, q2, q3
from races JOIN circuits on races.circuitId = circuits.circuitId
JOIN qualifying on races.raceId = qualifying.raceId
WHERE circuits.circuitRef IN ('monaco', 'spa', 'monza', 'silverstone') 
and position =1 ORDER BY year ASC;
 
-- now by fastest lap in the race
SELECT * from results;
SELECT races.year, circuits.circuitRef, circuits.circuitName, min(fastestLapTime)
from races JOIN circuits on races.circuitId = circuits.circuitId
JOIN results on races.raceId = results.raceId
WHERE circuits.circuitRef IN ('monaco', 'spa', 'monza', 'silverstone') and fastestLapTime is not null
group by circuits.circuitName,circuitRef, year
ORDER BY year ASC;

-- due to this data set not having fastest laps for anything before 1994 (Qual) and 2004 (Races),
-- I will follow up with python scraping