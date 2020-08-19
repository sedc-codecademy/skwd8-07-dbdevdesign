alter procedure dbo.BusinessEntityAccountList(@businessentityid int)
as
begin
 /*
 Created by : Dana Tasevska
 Created date : 18.08.2020
 Description : Procedure that list business entities and their account number
 */ 
  
	create table #banki (code nvarchar(10), [description] nvarchar(100))
    insert into #banki values ('210','NLB'), ('200', 'Stopanska'), ('300', 'Komercijalna'),
                              ('500' , 'Shparkase')

    select be.ID,be.name,bed.AccountNumber,b.[description]
    from dbo.businessentity be
    inner join dbo.businessentity_details bed on be.id=bed.BusinessentityID
    inner join #banki b on left(accountnumber,3)=b.code
	where be.id = @businessentityid
    order by be.ID

	drop table #banki

end

go

--1--
execute dbo.BusinessEntityAccountList 1
go
--2--
declare @businessentityid int
set @businessentityid = 1

exec dbo.BusinessEntityAccountList @businessentityid
go

--3--
exec dbo.BusinessEntityAccountList @businessentityid = 2