--getdate() -- return current date

declare @date datetime
set @date = getdate()

declare @nextdate datetime
set @nextdate = '2021-01-01'

--DATEADD 
select @date as DateNow, DATEADD(minute, -15, @date) as DateBefore15Minutes, DATEADD(minute, 15, @date) as DateAfter15Minutes

select @date as DateNow, DATEADD(day, -7, @date) as DateLastWeek, DATEADD(day, 7, @date) as DateNextWeek

select @date as DateNow, DATEADD(month, -1, @date) as PreviousMonth, DATEADD(month, 1, @date) as NextMonth

select @date as DateNow, DATEADD(year, -1, @date) as PreviousYear, DATEADD(year, 1, @date) as NextYear

--DATE DIFF
SELECT @date as DateNow, DATEDIFF(year, @date, @nextdate) differenceinyear

SELECT @date as DateNow,DATEDIFF(day, @date,@nextdate) differenceinday

--UPPER/LOWER
SELECT UPPER('tREWjdfhsjf')

SELECT LOWER('tREWjdfhsjf')

--LTRIM/RTRIM removes blank spaces from left, right or both sides
SELECT LTRIM('       test') AS testLtrim, '       test'

SELECT RTRIM('Test d         ') AS testRtrim, 'Test d         '

SELECT LTRIM(RTRIM('       test d        ')) as testBoth 

--CHARINDEX - finds position of charachter in a string 
SELECT CHARINDEX('a', 'barame ST na koja pozicija e vo kolonava', 3)


--CAST / CONVERT
select
	'broj 20' as Str_Varchar
,	N'број 20' as Str_NVarchar
,	cast('20' as int) as Varchar_Cast_Int
,	cast(N'20' as int) as NVarchar_Cast_Int
,	convert(int, '20') as Varchar_Convert_Int
,	convert(int, N'20') as NVarchar_Convert_Int
,	@date as Datetime_Default
,	convert(varchar(50), @date, 104) as Datetime_Convert_Varchar	--dd.mm.yyyy