--Operators

-- =
select * from [dbo].[Employee] where FirstName = 'Aleksandar'

-- DISTINCT
select FirstName from [dbo].[Employee] where FirstName = 'Aleksandar'
select DISTINCT FirstName from [dbo].[Employee] where FirstName = 'Aleksandar'

-- <>
select * from [dbo].[Employee] where FirstName <> 'Aleksandar'

-- <
select * from [dbo].[Product] where Price < 100

-- >
select * from [dbo].[Order] where TotalPrice > 6000

-- <=
select * from [dbo].[Product] where [Weight] <= 500

-- >=
select * from [dbo].[Product] where [Cost] >= 170

-- LIKE (%)
select * from [dbo].[Employee] where LastName like 'Sto%'
select * from [dbo].[Employee] where LastName like '%ov'

-- IN
select * from [dbo].[Employee] where LastName IN ('Popovski', 'Mitrevski')

-- NOT IN
select * from [dbo].[Employee] where LastName NOT IN ('Popovski', 'Mitrevski')

-- AND
select * from [dbo].[Employee] where FirstName = 'Aleksandar' AND LastName = 'Mitrevski'

-- OR
select * from [dbo].[Customer] where City = 'Bitola' AND (CustomerSize = 'Small' OR CustomerSize = 'Medium')

-- NULL
select * from [dbo].[Product]

insert into [dbo].[Product] ([Code], [Name])
values ('NewProduct', 'NewProduct')

select * from [dbo].[Product] where [Weight] < 50
select * from [dbo].[Product] where [Description] = NULL
select * from [dbo].[Product] where [Description] IS NULL