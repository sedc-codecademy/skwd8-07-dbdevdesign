declare @Student table
(ID int, [Name] nvarchar(50), CollegeID int)

declare @College table
(ID int, [Name] nvarchar(50))

insert into @Student (ID, [Name], CollegeID)
values
	(1, 'Aco', 1)
,	(2, 'Bojan', 2)
,	(3, 'Cobe', 1)
,	(4, 'Darko', null)

insert into @College (ID, [Name])
values
	(1, 'MIT')
,	(2, 'Berkeley')
,	(3, 'Princeton')

select
	s.ID, s.[Name], c.[Name] as College
from
	@Student as s
	left outer join @College as c on s.CollegeID = c.ID

-- IS NULL
select
	s.ID, s.[Name], c.[Name] as College
from
	@Student as s
	left outer join @College as c on s.CollegeID = c.ID
where
	c.[Name] is null

-- IS NOT NULL
select
	s.ID, s.[Name], c.[Name] as College
from
	@Student as s
	left outer join @College as c on s.CollegeID = c.ID
where
	c.[Name] is not null

-- COALESCE, ISNULL
select
	s.ID, s.[Name], Coalesce(c.[Name], '') as College_Coalesce, ISNULL(c.[Name], '') as College_IsNull
from
	@Student as s
	left outer join @College as c on s.CollegeID = c.ID

-- NULLIF
select
	s.ID, NULLIF(s.[Name], 'Darko') as Student_NullIF, c.[Name] as College
from
	@Student as s
	left outer join @College as c on s.CollegeID = c.ID

