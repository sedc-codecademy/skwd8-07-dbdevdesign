-- String Functions

select
	FirstName
,	LastName
,	replace(FirstName,'ks', 'X') as Replace_ks_X
,	Substring(FirstName, 4, 2) as Substring_4_2
,	Left(FirstName, 3) as Left_3
,	Right(FirstName, 2) as Right_2
,	Len(FirstName) as LenColumn
,	Concat(FirstName, N' + ', LastName) as Concat_Name
from
	Employee
where
	FirstName = 'Aleksandar' and LastName = 'Stojanovski'
go


select lastname,STRING_AGG(firstname,',') WITHIN GROUP (ORDER BY firstname) firstname_list
from dbo.Employee
where
	FirstName = 'Aleksandar' and LastName = 'Stojanovski'
group by LastName

