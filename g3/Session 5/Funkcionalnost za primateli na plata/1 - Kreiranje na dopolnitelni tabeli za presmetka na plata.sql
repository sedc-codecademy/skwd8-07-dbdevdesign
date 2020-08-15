DROP TABLE IF EXISTS dbo.EmployeeSalariesRegistar;
GO

CREATE TABLE dbo.EmployeeSalariesRegistar
	(EmployeeID INT, 
	 Points SMALLINT,
	 PointValue DECIMAL(18,2),
	 Experience INT,
	 ExperienceCoef DECIMAL(18,6),
	 IncentiveCoef DECIMAL(18,6),
	 CreatedDate SMALLDATETIME,
	 CreatedBy NVARCHAR(50),
	 ModifiedDate SMALLDATETIME,
	 ModifiedBy NVARCHAR(50)
	 )
GO

DROP TABLE IF EXISTS dbo.EmployeeSalariesEvidence;
GO

CREATE TABLE dbo.EmployeeSalariesEvidence
	(EmployeeID INT,  
	 YearMonth CHAR(6),
	 Incentive DECIMAL(18,2), 
	 TotalSalary DECIMAL(18,2),
	 PaymentDate DATE);
GO



---SKRIPTA ZA POLNENJE NA REGISTAROT ZA PLATI
DELETE FROM EmployeeSalariesRegistar

INSERT INTO dbo.EmployeeSalariesRegistar 
	(EmployeeID, 
	 Points, 
	 PointValue, 
	 Experience, 
	 ExperienceCoef, 
	 IncentiveCoef,
	 CreatedDate, 
	 CreatedBy)
SELECT Id, 
	   350, --bodovi
	   100, --vrednost po bod
	   DATEDIFF(year,DateOfBirth,GETDATE()), --Presmetka na Staz
	   150, --dodatok od staz * godina staz
	   0.5, --procent na bonus
	   GETDATE(), --datum na vnes vo sistem
	   'HR-Aleksandar Velkov' --vraboten koj go vnel vo sistem
FROM Employee
GO

UPDATE dbo.EmployeeSalariesRegistar 
	SET Points = 250, 
		ModifiedDate=GETDATE()+1,
		ModifiedBy = 'HR-Risto Sefot'
WHERE EmployeeID IN (1,5,9,20,30,33,44,88,57,22)
GO

UPDATE dbo.EmployeeSalariesRegistar 
	SET Points = 400, 
		ModifiedDate=GETDATE()+2,
		ModifiedBy = 'HR-Risto Sefot'
WHERE EmployeeID IN (12,51,95,26,38,39,41,82,58,23)
GO

UPDATE dbo.EmployeeSalariesRegistar 
	SET Points = 450, 
		ModifiedDate=GETDATE()+3,
		ModifiedBy = 'HR-Risto Sefot'
WHERE EmployeeID IN (15,55,98,23,34,32,47,87,53,29)
GO
