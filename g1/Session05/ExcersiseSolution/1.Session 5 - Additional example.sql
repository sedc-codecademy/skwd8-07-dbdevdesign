--1-- Create table -- drop table dbo.businessentity_details
create table dbo.businessentity_details 
(
 ID int identity(1,1) primary key clustered ([ID] asc),
 BusinessentityID int NOT NULL constraint FK_businessentity_detailsID foreign key ([Businessentityid]) references dbo.businessentity([ID]),
 AccountNumber nvarchar(15) not null,
 [Address] nvarchar(250) not null,
 Contact nvarchar(100) not null,
 email nvarchar(250) not null,
 comment nvarchar(max) NULL
)

go

--2-- create constraint
alter table dbo.businessentity_details with check
add constraint UN_AccountNum UNIQUE(accountnumber)

go

ALTER TABLE dbo.businessentity_details with check
ADD CONSTRAINT CH_email  CHECK(email LIKE '%@%.%')

go

ALTER TABLE dbo.businessentity_details with check
ADD CONSTRAINT CH_contact  CHECK(substring (Contact,1,2)='07')

go
--3-- insert values
insert into dbo.businessentity_details (BusinessentityID,AccountNumber,[Address],Contact,email,comment)
values(1,'210500222333','Partizanski Odredi 15','070555666','aaa@vitalia.com','Nema zabeleshka')
go
insert into dbo.businessentity_details (BusinessentityID,AccountNumber,[Address],Contact,email,comment)
values(2,'210500222334','XXXX 15','070779523','bbb@vitalia.com',NULL)
go
insert into dbo.businessentity_details (BusinessentityID,AccountNumber,[Address],Contact,email,comment)
values(3,'210500222335','XXXX 16','070779523','ccc@vitalia.com','TEST 1')
go
insert into dbo.businessentity_details (BusinessentityID,AccountNumber,[Address],Contact,email,comment)
values(4,'210500222335','XXXX 17','070779523','dddvitalia.com',NULL)
go
insert into dbo.businessentity_details (BusinessentityID,AccountNumber,[Address],Contact,email,comment)
values(5,'210500222336','XXXX 18','070779544','vvv@vitaliacom','Nema plateno faktura')
go
insert into dbo.businessentity_details (BusinessentityID,AccountNumber,[Address],Contact,email,comment)
values(6,'210500222337','XXXX 19','070779555','ddd@vitaliacom',NULL)
go
insert into dbo.businessentity_details (BusinessentityID,AccountNumber,[Address],Contact,email,comment)
values(7,'210500222338','XXXX 20','070779566','aa@vitalia.com','Nevaliden kontakt')
go

--4-- update values
update businessentity_details
set comment = 'Nema zabeleshka za smetka'
go

