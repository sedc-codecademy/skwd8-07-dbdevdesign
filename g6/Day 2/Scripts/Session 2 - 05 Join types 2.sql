DROP TABLE IF EXISTS Person;
DROP TABLE IF EXISTS City;

CREATE TABLE Person
(
	PersonID int
,	PersonName nvarchar(50)
,	CityID int
)

CREATE TABLE City
(
	CityID int
,	CityName nvarchar(50)
)

insert into Person
values
	(1, 'Marjan', 2)
,	(2, 'Riste', 2)
,	(3, 'Toshe', 1)
,	(4, 'Alek', null)

insert into City
values
	(1, 'Skopje')
,	(2, 'Veles')
,	(3, 'Ohrid')

select * from City
select * from Person
GO

-- CROSS join
select
	* 
from
	Person
	cross join City
order by
	Person.PersonID, City.CityID
GO

-- INNER JOIN
select
	* 
from
	Person as p
	INNER JOIN City as c ON p.CityID = c.CityID
GO

-- LEFT JOIN
select
	* 
from
	Person as p
	LEFT OUTER JOIN City as c ON p.CityID = c.CityID
GO

-- RIGHT JOIN
select
	* 
from
	Person as p
	RIGHT OUTER JOIN City as c ON p.CityID = c.CityID
GO

-- FULL JOIN
select
	* 
from
	Person as p
	FULL OUTER JOIN City as c ON p.CityID = c.CityID
GO

DROP TABLE IF EXISTS Person;
DROP TABLE IF EXISTS City;
GO