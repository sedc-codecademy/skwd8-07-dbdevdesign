--delete na stavki od tabela
--where se koristi dokolku sakame da isfiltrirame stavki sto ke gi brisheme
delete d
--select *
from dbo.EmployeeSalariesEvidence d
--where EmployeeID = 2

--za brishenje na tabela od baza, da se vnimava pri koristenje na ovaa naredba 
drop table dbo.EmployeeSalariesEvidence

--promena na pobatocen tip na kolona od tabela
alter table dbo.EmployeeSalariesRegistar
alter column Experience nvarchar(10)

--1--back up
select *
into dbo.BKP_EmployeeSalariesRegistar_20082020
from dbo.EmployeeSalariesRegistar

select *
from dbo.BKP_EmployeeSalariesRegistar_20082020

--2--delete 
delete d
--select *
from dbo.EmployeeSalariesRegistar d

--naredba za prikaz na kodot na objektot
sp_helptext '[dbo].[ToCyrillic]'

--ALT+F1 za prikaz na struktura na tabela