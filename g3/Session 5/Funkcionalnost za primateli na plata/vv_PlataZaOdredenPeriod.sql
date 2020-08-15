CREATE VIEW vv_PlataZaOdredenPeriod
AS
SELECT o.EmployeeId, TotalSales = SUM(o.TotalPrice), er.Points, er.PointValue, er.Experience, er.ExperienceCoef, er.IncentiveCoef,
		FiksnaPlata = (er.Points*er.PointValue),
		DodatokOdStaz = (er.Experience * er.ExperienceCoef),
		ProcentOdProdazba = (SUM(o.TotalPrice)*er.IncentiveCoef),
		VkupnaPlata = (er.Points*er.PointValue) + (er.Experience * er.ExperienceCoef) + (SUM(o.TotalPrice)*er.IncentiveCoef),
		o.OrderDate
FROM dbo.[Order] o
INNER JOIN EmployeeSalariesRegistar er
	ON o.EmployeeId = er.EmployeeID
GROUP BY o.EmployeeId, er.Points, er.PointValue, er.Experience, er.ExperienceCoef, er.IncentiveCoef, o.OrderDate